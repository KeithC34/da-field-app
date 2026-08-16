import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import '../../core/sync/offline_sync_status.dart';
import '../local/database/app_database.dart';

class SyncRunResult {
  const SyncRunResult({
    required this.status,
    this.uploaded = 0,
    this.downloaded = 0,
    this.failed = 0,
    this.conflicts = 0,
  });

  final String status;
  final int uploaded;
  final int downloaded;
  final int failed;
  final int conflicts;
}

class SyncProcessor {
  SyncProcessor(
    this._database,
    this._dio,
    Connectivity connectivity, {
    Future<List<ConnectivityResult>> Function()? connectivityCheck,
    this.downloadChanges = true,
  }) : _connectivityCheck = connectivityCheck ?? connectivity.checkConnectivity;

  static const _logName = 'SyncProcessor';
  static const _lastPullCursorKey = 'last_pull_cursor';

  final AppDatabase _database;
  final Dio _dio;
  final Future<List<ConnectivityResult>> Function() _connectivityCheck;
  final bool downloadChanges;
  final Uuid _uuid = const Uuid();
  bool _isProcessing = false;

  Future<SyncRunResult> processQueue({
    String trigger = 'manual',
    bool force = false,
  }) async {
    if (_isProcessing) return const SyncRunResult(status: 'already_running');
    _isProcessing = true;
    final logId = _uuid.v4();
    await _database
        .into(_database.syncLogs)
        .insert(
          SyncLogsCompanion.insert(
            id: logId,
            trigger: trigger,
            status: 'running',
            startedAt: DateTime.now().toUtc(),
          ),
        );

    var uploaded = 0;
    var downloaded = 0;
    var failed = 0;
    var conflicts = 0;
    String? runMessage;
    try {
      final results = await _connectivityCheck();
      if (!results.any((result) => result != ConnectivityResult.none)) {
        await _completeLog(
          logId,
          status: 'offline',
          message: 'No network connection.',
        );
        return const SyncRunResult(status: 'offline');
      }

      await _recoverInterruptedItems();
      final now = DateTime.now().toUtc();
      final candidates =
          await (_database.select(_database.syncQueue)
                ..where(
                  (table) =>
                      table.syncStatus.equals(OfflineSyncStatus.pending) |
                      table.syncStatus.equals(OfflineSyncStatus.failed),
                )
                ..orderBy([
                  (table) => OrderingTerm.asc(table.createdAt),
                  (table) => OrderingTerm.asc(table.id),
                ]))
              .get();
      final items = force
          ? candidates
          : candidates
                .where(
                  (item) =>
                      item.nextAttemptAt == null ||
                      !item.nextAttemptAt!.isAfter(now),
                )
                .toList();

      for (final item in items) {
        final itemStatus = await _processItem(item);
        switch (itemStatus) {
          case OfflineSyncStatus.synced:
            uploaded++;
          case OfflineSyncStatus.conflict:
            conflicts++;
          default:
            failed++;
        }
      }

      final attachmentResult = await _uploadStandaloneAttachments();
      uploaded += attachmentResult.uploaded;
      failed += attachmentResult.failed;

      if (downloadChanges) {
        try {
          downloaded = await _downloadUpdates();
          try {
            await _refreshMediaVerificationStatuses();
          } catch (error, stackTrace) {
            developer.log(
              'Record synchronization completed, but media review states could not be refreshed.',
              name: _logName,
              error: error,
              stackTrace: stackTrace,
            );
          }
        } catch (error, stackTrace) {
          failed++;
          runMessage = 'Download failed: ${_errorMessage(error)}';
          developer.log(
            'Upload processing completed, but downloading server changes failed.',
            name: _logName,
            error: error,
            stackTrace: stackTrace,
          );
        }
      }

      final resultStatus = conflicts > 0
          ? 'conflict'
          : failed > 0
          ? 'partial'
          : 'completed';
      await _completeLog(
        logId,
        status: resultStatus,
        uploaded: uploaded,
        downloaded: downloaded,
        failed: failed,
        conflicts: conflicts,
        message: runMessage,
      );
      return SyncRunResult(
        status: resultStatus,
        uploaded: uploaded,
        downloaded: downloaded,
        failed: failed,
        conflicts: conflicts,
      );
    } catch (error, stackTrace) {
      await _completeLog(
        logId,
        status: 'failed',
        failed: failed + 1,
        message: _errorMessage(error),
      );
      developer.log(
        'Unable to process the synchronization queue.',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
      return SyncRunResult(
        status: 'failed',
        uploaded: uploaded,
        downloaded: downloaded,
        failed: failed + 1,
        conflicts: conflicts,
      );
    } finally {
      _isProcessing = false;
    }
  }

  Future<String> _processItem(SyncQueueData item) async {
    Map<String, dynamic>? payload;
    try {
      payload = _decodePayload(item.payload);
      await _setStatus(item, payload, OfflineSyncStatus.syncing);

      final genericRecord = item.recordId == null
          ? null
          : await (_database.select(_database.offlineRecords)
                  ..where((table) => table.id.equals(item.recordId!)))
                .getSingleOrNull();
      final queuedMethod = item.method.toUpperCase();
      final isLegacyMultipart =
          queuedMethod == 'POST_MULTIPART' && genericRecord == null;
      final requestPayload = Map<String, dynamic>.from(payload)
        ..remove('_photo_paths');
      final isGeneric =
          genericRecord != null &&
          item.recordId != null &&
          item.recordType != null;
      final Object networkPayload;
      if (isGeneric) {
        for (final key in const {
          'offline_record_id',
          'created_at',
          'updated_at',
          'created_by',
          'field_worker_id',
          'latitude',
          'longitude',
        }) {
          requestPayload.remove(key);
        }
        networkPayload = {
          'record_id': genericRecord.id,
          'record_type': genericRecord.recordType,
          'payload': requestPayload,
          'target_endpoint': item.endpoint,
          'latitude': genericRecord.latitude,
          'longitude': genericRecord.longitude,
          'created_at': genericRecord.createdAt.toIso8601String(),
          'updated_at': genericRecord.updatedAt.toIso8601String(),
          'created_by': genericRecord.createdBy,
          'field_worker_id': genericRecord.fieldWorkerId,
        };
      } else if (!isLegacyMultipart && item.recordId != null) {
        requestPayload['offline_record_id'] = item.recordId;
        networkPayload = requestPayload;
      } else {
        networkPayload = requestPayload;
      }

      final response = await _requestWithTransientRetry(
        isGeneric ? '/mobile-sync/records' : item.endpoint,
        method: isGeneric
            ? 'POST'
            : isLegacyMultipart
            ? 'POST'
            : queuedMethod == 'POST_MULTIPART'
            ? 'POST'
            : queuedMethod,
        dataFactory: () =>
            isLegacyMultipart ? _buildMultipartData(payload!) : networkPayload,
        contentType: isLegacyMultipart ? null : Headers.jsonContentType,
        syncId: item.recordId,
      );
      final responseData = response.data;
      final serverRecordId = responseData is Map
          ? responseData['id']?.toString()
          : null;
      final serverUpdatedAt = responseData is Map
          ? DateTime.tryParse(responseData['updated_at']?.toString() ?? '')
                ?.toUtc()
          : null;

      if (genericRecord != null &&
          item.recordId != null &&
          item.recordType != null) {
        await _uploadGenericPhotos(item.recordId!, item.recordType!);
      }
      await _setStatus(
        item,
        payload,
        OfflineSyncStatus.synced,
        serverRecordId: serverRecordId,
        serverUpdatedAt: serverUpdatedAt,
      );
      return OfflineSyncStatus.synced;
    } catch (error, stackTrace) {
      final status = _isConflict(error)
          ? OfflineSyncStatus.conflict
          : OfflineSyncStatus.failed;
      try {
        await _setStatus(
          item,
          payload,
          status,
          errorMessage: _errorMessage(error),
          incrementRetry: status == OfflineSyncStatus.failed,
        );
      } catch (stateError, stateStackTrace) {
        developer.log(
          'Unable to persist the sync failure for queue item ${item.id}.',
          name: _logName,
          error: stateError,
          stackTrace: stateStackTrace,
        );
      }
      developer.log(
        'Failed to synchronize queue item ${item.id}; it was retained.',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
      return status;
    }
  }

  Future<Response<Object?>> _requestWithTransientRetry(
    String endpoint, {
    required String method,
    required FutureOr<Object> Function() dataFactory,
    required String? contentType,
    String? syncId,
    Map<String, dynamic>? queryParameters,
  }) async {
    DioException? lastError;
    for (var attempt = 0; attempt < 2; attempt++) {
      try {
        final response = await _dio.request<Object?>(
          endpoint,
          data: await dataFactory(),
          queryParameters: queryParameters,
          options: Options(
            method: method,
            contentType: contentType,
            headers: {'Idempotency-Key': syncId},
          ),
        );
        if (response.statusCode != 200 && response.statusCode != 201) {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: 'Unexpected status code ${response.statusCode}',
          );
        }
        return response;
      } on DioException catch (error) {
        lastError = error;
        if (attempt == 1 || !_isTransient(error)) rethrow;
        await Future<void>.delayed(const Duration(milliseconds: 400));
      }
    }
    throw lastError!;
  }

  Future<void> _uploadGenericPhotos(String recordId, String recordType) async {
    final photos =
        await (_database.select(_database.offlinePhotos)..where(
              (table) =>
                  table.recordId.equals(recordId) &
                  table.syncStatus.isNotValue(OfflineSyncStatus.synced),
            ))
            .get();
    for (final photo in photos) {
      if (!await File(photo.filePath).exists()) {
        throw FileSystemException(
          'Queued photo is no longer available.',
          photo.filePath,
        );
      }
      final response = await _requestWithTransientRetry(
        '/mobile-sync/records/$recordId/photos',
        method: 'POST',
        dataFactory: () async => FormData.fromMap({
          'photo_id': photo.id,
          'record_type': recordType,
          'photo': await MultipartFile.fromFile(
            photo.filePath,
            filename: p.basename(photo.filePath),
            contentType: DioMediaType.parse(photo.mimeType),
          ),
        }),
        contentType: null,
        syncId: photo.id,
      );
      final data = response.data;
      await (_database.update(
        _database.offlinePhotos,
      )..where((table) => table.id.equals(photo.id))).write(
        OfflinePhotosCompanion(
          syncStatus: const Value(OfflineSyncStatus.synced),
          syncError: const Value(null),
          serverFileId: Value(
            data is Map
                ? (data['media_file_id'] ?? data['file_id'])?.toString()
                : null,
          ),
          serverFileUrl: Value(data is Map ? data['file_url']?.toString() : null),
          verificationStatus: const Value('verification_required'),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
    }
  }

  Future<({int uploaded, int failed})> _uploadStandaloneAttachments() async {
    var uploaded = 0;
    var failed = 0;
    final attachments =
        await (_database.select(_database.offlinePhotos)..where(
              (table) =>
                  (table.syncStatus.equals(OfflineSyncStatus.pending) |
                      table.syncStatus.equals(OfflineSyncStatus.failed)) &
                  table.recordType.isNotValue(''),
            ))
            .get();

    for (final attachment in attachments) {
      final localRecord =
          await (_database.select(_database.offlineRecords)
                ..where((table) => table.id.equals(attachment.recordId)))
              .getSingleOrNull();
      // Attachments that belong to an unsynced field record are sent by that
      // record's existing queue item first, preserving causal ordering.
      if (localRecord != null &&
          localRecord.syncStatus != OfflineSyncStatus.synced) {
        continue;
      }
      try {
        if (!await File(attachment.filePath).exists()) {
          throw FileSystemException('Queued file is no longer available.', attachment.filePath);
        }
        await (_database.update(_database.offlinePhotos)
              ..where((table) => table.id.equals(attachment.id)))
            .write(
              OfflinePhotosCompanion(
                syncStatus: const Value(OfflineSyncStatus.syncing),
                syncError: const Value(null),
                updatedAt: Value(DateTime.now().toUtc()),
              ),
            );
        final response = await _requestWithTransientRetry(
          '/media',
          method: 'POST',
          dataFactory: () async => FormData.fromMap({
            'file': await MultipartFile.fromFile(
              attachment.filePath,
              filename: p.basename(attachment.filePath),
              contentType: DioMediaType.parse(attachment.mimeType),
            ),
          }),
          contentType: null,
          syncId: attachment.id,
          queryParameters: {
            'record_id': attachment.recordId,
            'record_type': _mediaRecordType(attachment.recordType),
          },
        );
        final data = response.data;
        await (_database.update(_database.offlinePhotos)
              ..where((table) => table.id.equals(attachment.id)))
            .write(
              OfflinePhotosCompanion(
                syncStatus: const Value(OfflineSyncStatus.synced),
                syncError: const Value(null),
                serverFileId: Value(data is Map ? data['file_id']?.toString() : null),
                serverFileUrl: Value(data is Map ? data['file_url']?.toString() : null),
                verificationStatus: const Value('verification_required'),
                updatedAt: Value(DateTime.now().toUtc()),
              ),
            );
        uploaded++;
      } catch (error) {
        await (_database.update(_database.offlinePhotos)
              ..where((table) => table.id.equals(attachment.id)))
            .write(
              OfflinePhotosCompanion(
                syncStatus: const Value(OfflineSyncStatus.failed),
                syncError: Value(_errorMessage(error)),
                updatedAt: Value(DateTime.now().toUtc()),
              ),
            );
        failed++;
      }
    }
    return (uploaded: uploaded, failed: failed);
  }

  String _mediaRecordType(String recordType) => switch (recordType) {
    'pig_health' => 'pig_health',
    'disease_report' => 'disease_report',
    'piglet' => 'piglet',
    'pig_pen_inspection' => 'pig_pen_inspection',
    'waste_inspection' => 'waste_inspection',
    'wastewater_inspection' => 'wastewater_inspection',
    'field_verification' => 'field_verification',
    'dispersal_monitoring' => 'dispersal_monitoring',
    'return_piglet_verification' => 'return_piglet_verification',
    'pig' => 'pig',
    'inspection' => 'inspection',
    _ => recordType,
  };

  Future<void> _refreshMediaVerificationStatuses() async {
    final response = await _dio.get<Object?>('/media', queryParameters: {'limit': 500});
    if (response.data is! List) return;
    for (final item in response.data as List) {
      if (item is! Map) continue;
      final fileId = item['file_id']?.toString();
      final status = item['verification_status']?.toString();
      if (fileId == null || status == null) continue;
      if (!{'pending', 'approved', 'rejected'}.contains(status)) continue;
      final localStatus = switch (status) {
        'approved' => 'verified',
        'rejected' => 'rejected',
        _ => 'verification_required',
      };
      await (_database.update(_database.offlinePhotos)
            ..where(
              (table) =>
                  table.serverFileId.equals(fileId) | table.id.equals(fileId),
            ))
          .write(
            OfflinePhotosCompanion(
              verificationStatus: Value(localStatus),
              updatedAt: Value(DateTime.now().toUtc()),
            ),
          );
    }
  }

  Future<int> _downloadUpdates() async {
    var downloaded = 0;
    var hasMore = true;
    var cursor =
        await (_database.select(_database.syncMetadata)
              ..where((table) => table.key.equals(_lastPullCursorKey)))
            .getSingleOrNull();

    while (hasMore) {
      final queryParameters = <String, dynamic>{'limit': 500};
      if (cursor != null) {
        queryParameters['updated_since'] = cursor.value;
      }
      final response = await _dio.get<Object?>(
        '/mobile-sync/changes',
        queryParameters: queryParameters,
      );
      final body = response.data;
      if (body is! Map) {
        throw const FormatException('Invalid server change response.');
      }
      final records = body['records'];
      if (records is! List) {
        throw const FormatException('Server changes must be a list.');
      }
      for (final raw in records) {
        if (raw is Map) {
          await _mergeServerRecord(Map<String, dynamic>.from(raw));
          downloaded++;
        }
      }
      final nextCursor = body['cursor']?.toString();
      if (nextCursor == null || DateTime.tryParse(nextCursor) == null) {
        throw const FormatException('Server change cursor is invalid.');
      }
      await _database
          .into(_database.syncMetadata)
          .insertOnConflictUpdate(
            SyncMetadataCompanion.insert(
              key: _lastPullCursorKey,
              value: nextCursor,
              updatedAt: Value(DateTime.now().toUtc()),
            ),
          );
      cursor = await (_database.select(
        _database.syncMetadata,
      )..where((table) => table.key.equals(_lastPullCursorKey))).getSingle();
      hasMore = body['has_more'] == true;
    }
    return downloaded;
  }

  Future<void> _mergeServerRecord(Map<String, dynamic> server) async {
    final recordId = server['record_id']?.toString();
    final recordType = server['record_type']?.toString();
    final payload = server['payload'];
    final serverUpdatedAt = DateTime.tryParse(
      server['updated_at']?.toString() ?? '',
    )?.toUtc();
    if (recordId == null ||
        recordType == null ||
        payload is! Map ||
        serverUpdatedAt == null) {
      throw const FormatException(
        'Server record is missing synchronization metadata.',
      );
    }
    final existing = await (_database.select(
      _database.offlineRecords,
    )..where((table) => table.id.equals(recordId))).getSingleOrNull();
    final pendingLocal =
        existing != null &&
        {
          OfflineSyncStatus.pending,
          OfflineSyncStatus.syncing,
          OfflineSyncStatus.failed,
          OfflineSyncStatus.conflict,
        }.contains(existing.syncStatus);
    if (pendingLocal &&
        (existing.serverUpdatedAt == null ||
            existing.serverUpdatedAt != serverUpdatedAt)) {
      await (_database.update(
        _database.offlineRecords,
      )..where((table) => table.id.equals(recordId))).write(
        OfflineRecordsCompanion(
          syncStatus: const Value(OfflineSyncStatus.conflict),
          syncError: const Value('Server and local versions both changed.'),
          serverUpdatedAt: Value(serverUpdatedAt),
          serverRecordId: Value(server['server_record_id']?.toString()),
        ),
      );
      await (_database.update(
        _database.syncQueue,
      )..where((table) => table.recordId.equals(recordId))).write(
        const SyncQueueCompanion(
          status: Value(OfflineSyncStatus.conflict),
          syncStatus: Value(OfflineSyncStatus.conflict),
          lastError: Value('Server and local versions both changed.'),
        ),
      );
      return;
    }

    final location = payload['location'];
    final coordinates = location is Map ? location['coordinates'] : null;
    final latitude =
        _asDouble(payload['latitude']) ??
        (coordinates is List && coordinates.length >= 2
            ? _asDouble(coordinates[1])
            : null) ??
        existing?.latitude ??
        0;
    final longitude =
        _asDouble(payload['longitude']) ??
        (coordinates is List && coordinates.length >= 2
            ? _asDouble(coordinates[0])
            : null) ??
        existing?.longitude ??
        0;
    final createdAt =
        DateTime.tryParse(server['created_at']?.toString() ?? '')?.toUtc() ??
        serverUpdatedAt;
    final workerId =
        server['field_worker_id']?.toString() ??
        existing?.fieldWorkerId ??
        'server';
    final createdBy =
        server['created_by']?.toString() ?? existing?.createdBy ?? workerId;

    await _database
        .into(_database.offlineRecords)
        .insertOnConflictUpdate(
          OfflineRecordsCompanion.insert(
            id: recordId,
            recordType: recordType,
            payload: jsonEncode(Map<String, dynamic>.from(payload)),
            latitude: latitude,
            longitude: longitude,
            createdAt: Value(existing?.createdAt ?? createdAt),
            updatedAt: Value(serverUpdatedAt),
            createdBy: createdBy,
            fieldWorkerId: workerId,
            syncStatus: const Value(OfflineSyncStatus.synced),
            syncError: const Value(null),
            serverRecordId: Value(server['server_record_id']?.toString()),
            serverUpdatedAt: Value(serverUpdatedAt),
          ),
        );
  }

  double? _asDouble(Object? value) => value is num
      ? value.toDouble()
      : double.tryParse(value?.toString() ?? '');

  Future<void> _recoverInterruptedItems() async {
    final now = DateTime.now().toUtc();
    await _database.transaction(() async {
      await (_database.update(_database.syncQueue)..where(
            (table) => table.syncStatus.equals(OfflineSyncStatus.syncing),
          ))
          .write(
            SyncQueueCompanion(
              status: const Value(OfflineSyncStatus.pending),
              syncStatus: const Value(OfflineSyncStatus.pending),
              updatedAt: Value(now),
              lastError: const Value(
                'Previous synchronization was interrupted.',
              ),
            ),
          );
      await (_database.update(_database.offlineRecords)..where(
            (table) => table.syncStatus.equals(OfflineSyncStatus.syncing),
          ))
          .write(
            const OfflineRecordsCompanion(
              syncStatus: Value(OfflineSyncStatus.pending),
              syncError: Value('Previous synchronization was interrupted.'),
            ),
          );
      await (_database.update(_database.offlinePhotos)..where(
            (table) => table.syncStatus.equals(OfflineSyncStatus.syncing),
          ))
          .write(
            const OfflinePhotosCompanion(
              syncStatus: Value(OfflineSyncStatus.pending),
              syncError: Value('Previous synchronization was interrupted.'),
            ),
          );
    });
  }

  Future<void> _setStatus(
    SyncQueueData item,
    Map<String, dynamic>? payload,
    String status, {
    String? errorMessage,
    bool incrementRetry = false,
    String? serverRecordId,
    DateTime? serverUpdatedAt,
  }) async {
    final now = DateTime.now().toUtc();
    final retryCount = item.retryCount + (incrementRetry ? 1 : 0);
    final retryDelay = Duration(seconds: 5 * (1 << retryCount.clamp(0, 6)));
    await _database.transaction(() async {
      await (_database.update(
        _database.syncQueue,
      )..where((table) => table.id.equals(item.id))).write(
        SyncQueueCompanion(
          status: Value(status),
          syncStatus: Value(status),
          updatedAt: Value(now),
          lastAttemptAt: Value(
            status == OfflineSyncStatus.syncing ? now : item.lastAttemptAt,
          ),
          nextAttemptAt: Value(incrementRetry ? now.add(retryDelay) : null),
          retryCount: incrementRetry ? Value(retryCount) : const Value.absent(),
          lastError: Value(errorMessage),
          serverRecordId: serverRecordId == null
              ? const Value.absent()
              : Value(serverRecordId),
        ),
      );
      await _setLocalRecordStatus(
        item,
        payload,
        status,
        errorMessage,
        now,
        serverRecordId,
        serverUpdatedAt,
      );
    });
  }

  Future<void> _setLocalRecordStatus(
    SyncQueueData item,
    Map<String, dynamic>? payload,
    String status,
    String? errorMessage,
    DateTime now,
    String? serverRecordId,
    DateTime? serverUpdatedAt,
  ) async {
    final isSynced = status == OfflineSyncStatus.synced;
    final recordId = item.recordId ?? _legacyRecordId(item.endpoint, payload);
    if (recordId == null) return;

    if (item.recordType == 'notification_read') {
      final notificationId = recordId.replaceFirst('notification:', '');
      await (_database.update(_database.notifications)
            ..where((table) => table.id.equals(notificationId)))
          .write(NotificationsCompanion(
            syncStatus: Value(status),
            lastError: Value(errorMessage),
          ));
      return;
    }

    switch (item.endpoint) {
      case '/pig-farmers':
        await (_database.update(
          _database.farmers,
        )..where((table) => table.id.equals(recordId))).write(
          FarmersCompanion(
            isSynced: Value(isSynced),
            syncStatus: Value(status),
            updatedAt: Value(now),
          ),
        );
      case '/disease-reports':
        await (_database.update(
          _database.diseaseReports,
        )..where((table) => table.id.equals(recordId))).write(
          DiseaseReportsCompanion(
            isSynced: Value(isSynced),
            syncStatus: Value(status),
            updatedAt: Value(now),
          ),
        );
      case '/inspections':
        await (_database.update(
          _database.inspections,
        )..where((table) => table.id.equals(recordId))).write(
          InspectionsCompanion(
            isSynced: Value(isSynced),
            syncStatus: Value(status),
            updatedAt: Value(now),
          ),
        );
      case '/pigs':
        await (_database.update(
          _database.pigs,
        )..where((table) => table.id.equals(recordId))).write(
          PigsCompanion(
            isSynced: Value(isSynced),
            syncStatus: Value(status),
            updatedAt: Value(now),
          ),
        );
      case '/dispersals':
        await (_database.update(
          _database.dispersals,
        )..where((table) => table.id.equals(recordId))).write(
          DispersalsCompanion(
            isSynced: Value(isSynced),
            syncStatus: Value(status),
            updatedAt: Value(now),
          ),
        );
    }

    if (item.recordType != null) {
      await (_database.update(
        _database.offlineRecords,
      )..where((table) => table.id.equals(recordId))).write(
        OfflineRecordsCompanion(
          syncStatus: Value(status),
          syncError: Value(errorMessage),
          updatedAt: Value(now),
          serverRecordId: serverRecordId == null
              ? const Value.absent()
              : Value(serverRecordId),
          serverUpdatedAt: serverUpdatedAt == null
              ? const Value.absent()
              : Value(serverUpdatedAt),
        ),
      );
      final photoQuery = _database.update(_database.offlinePhotos)
        ..where(
          (table) =>
              table.recordId.equals(recordId) &
              (status == OfflineSyncStatus.synced
                  ? const Constant(true)
                  : table.syncStatus.isNotValue(OfflineSyncStatus.synced)),
        );
      await photoQuery.write(
        OfflinePhotosCompanion(
          syncStatus: Value(status),
          syncError: Value(errorMessage),
          updatedAt: Value(now),
        ),
      );
    }
  }

  Future<void> _completeLog(
    String id, {
    required String status,
    int uploaded = 0,
    int downloaded = 0,
    int failed = 0,
    int conflicts = 0,
    String? message,
  }) async {
    await (_database.update(
      _database.syncLogs,
    )..where((table) => table.id.equals(id))).write(
      SyncLogsCompanion(
        status: Value(status),
        uploadedCount: Value(uploaded),
        downloadedCount: Value(downloaded),
        failedCount: Value(failed),
        conflictCount: Value(conflicts),
        message: Value(message),
        completedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  String? _legacyRecordId(String endpoint, Map<String, dynamic>? payload) {
    if (payload == null) return null;
    final key = switch (endpoint) {
      '/pig-farmers' => 'farmer_id',
      '/disease-reports' => 'disease_id',
      '/inspections' => 'inspection_id',
      '/pigs' => 'pig_id',
      '/dispersals' => 'dispersal_id',
      _ => 'offline_record_id',
    };
    final value = payload[key] ?? payload['offline_record_id'];
    return value is String && value.trim().isNotEmpty ? value.trim() : null;
  }

  Map<String, dynamic> _decodePayload(String encodedPayload) {
    final decoded = jsonDecode(encodedPayload);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Queue payload must be a JSON object.');
    }
    return decoded;
  }

  FormData _buildMultipartData(Map<String, dynamic> payload) {
    final fields = Map<String, dynamic>.from(payload);
    final directPhotoPath = fields.remove('photoPath');
    final queuedPhotoPaths = fields.remove('_photo_paths');
    final photoPath =
        directPhotoPath ??
        (queuedPhotoPaths is List && queuedPhotoPaths.isNotEmpty
            ? queuedPhotoPaths.first
            : null);
    if (photoPath is! String || photoPath.trim().isEmpty) {
      throw const FormatException(
        'Multipart payload must contain a non-empty photo path.',
      );
    }
    final normalizedPath = photoPath.trim();
    fields['photo'] = MultipartFile.fromFileSync(
      normalizedPath,
      filename: p.basename(normalizedPath),
    );
    return FormData.fromMap(fields);
  }

  bool _isConflict(Object error) =>
      error is DioException && error.response?.statusCode == 409;

  bool _isTransient(DioException error) =>
      error.type == DioExceptionType.connectionError ||
      error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.sendTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      (error.response?.statusCode ?? 0) >= 500;

  String _errorMessage(Object error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map) {
        final detail = data['detail'];
        if (detail is String && detail.trim().isNotEmpty) return detail;
      }
      return 'Network sync failed: ${error.message ?? error.type.name}';
    }
    return error.toString();
  }
}
