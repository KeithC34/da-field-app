import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/sync/offline_record_type.dart';
import '../../core/sync/offline_sync_status.dart';
import '../../data/local/database/app_database.dart';

/// Saves Phase 18 field operations locally before any network request is made.
///
/// The caller supplies the API contract details for the operation. This keeps
/// every field workflow on the same durable, auditable queue while allowing
/// FastAPI endpoints to evolve independently from the mobile database.
class OfflineRecordRepository {
  OfflineRecordRepository(
    this._database, {
    String Function()? fieldWorkerIdProvider,
  }) : _fieldWorkerIdProvider =
           fieldWorkerIdProvider ?? (() => 'local-field-worker');

  final AppDatabase _database;
  final String Function() _fieldWorkerIdProvider;
  final Uuid _uuid = const Uuid();

  Future<String> saveRecord({
    required String recordType,
    required Map<String, dynamic> payload,
    required String endpoint,
    required String method,
    required double latitude,
    required double longitude,
    List<String> photoPaths = const [],
    String? id,
  }) async {
    final normalizedType = recordType.trim();
    final normalizedEndpoint = endpoint.trim();
    final normalizedMethod = method.trim().toUpperCase();
    final recordId = (id?.trim().isNotEmpty ?? false) ? id!.trim() : _uuid.v4();
    final workerId = _fieldWorkerIdProvider().trim();

    if (!OfflineRecordType.values.contains(normalizedType)) {
      throw ArgumentError.value(
        recordType,
        'recordType',
        'Unsupported record type.',
      );
    }
    if (normalizedEndpoint.isEmpty || !normalizedEndpoint.startsWith('/')) {
      throw ArgumentError.value(
        endpoint,
        'endpoint',
        'Endpoint must start with /.',
      );
    }
    if (normalizedMethod.isEmpty) {
      throw ArgumentError.value(method, 'method', 'HTTP method is required.');
    }
    if (!latitude.isFinite || latitude < -90 || latitude > 90) {
      throw ArgumentError.value(
        latitude,
        'latitude',
        'Latitude must be between -90 and 90.',
      );
    }
    if (!longitude.isFinite || longitude < -180 || longitude > 180) {
      throw ArgumentError.value(
        longitude,
        'longitude',
        'Longitude must be between -180 and 180.',
      );
    }
    if (workerId.isEmpty || workerId == 'local-field-worker') {
      throw StateError(
        'A signed-in field worker ID is required for offline records.',
      );
    }

    final normalizedPhotoPaths = <String>[];
    for (final path in photoPaths) {
      final normalizedPath = path.trim();
      if (normalizedPath.isEmpty) {
        throw ArgumentError.value(
          path,
          'photoPaths',
          'Photo path must not be empty.',
        );
      }
      if (!await File(normalizedPath).exists()) {
        throw ArgumentError.value(
          path,
          'photoPaths',
          'A selected photo could not be found.',
        );
      }
      normalizedPhotoPaths.add(normalizedPath);
    }

    final now = DateTime.now().toUtc();
    final queuedPayload = <String, dynamic>{
      ...payload,
      'offline_record_id': recordId,
      'created_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
      'created_by': workerId,
      'field_worker_id': workerId,
      'latitude': latitude,
      'longitude': longitude,
      if (normalizedPhotoPaths.isNotEmpty) '_photo_paths': normalizedPhotoPaths,
    };

    await _database.transaction(() async {
      await _database
          .into(_database.offlineRecords)
          .insert(
            OfflineRecordsCompanion.insert(
              id: recordId,
              recordType: normalizedType,
              payload: jsonEncode(queuedPayload),
              latitude: latitude,
              longitude: longitude,
              createdAt: Value(now),
              updatedAt: Value(now),
              createdBy: workerId,
              fieldWorkerId: workerId,
              syncStatus: const Value(OfflineSyncStatus.pending),
            ),
          );

      for (final photoPath in normalizedPhotoPaths) {
        await _database
            .into(_database.offlinePhotos)
            .insert(
              OfflinePhotosCompanion.insert(
                id: _uuid.v4(),
                recordId: recordId,
                recordType: Value(normalizedType),
                filePath: photoPath,
                mimeType: _mimeTypeFor(photoPath),
                createdAt: Value(now),
                updatedAt: Value(now),
                createdBy: workerId,
                fieldWorkerId: workerId,
                syncStatus: const Value(OfflineSyncStatus.pending),
                verificationStatus: const Value('verification_required'),
              ),
            );
      }

      await _database
          .into(_database.syncQueue)
          .insert(
            SyncQueueCompanion.insert(
              endpoint: normalizedEndpoint,
              method: normalizedMethod,
              payload: jsonEncode(queuedPayload),
              status: const Value(OfflineSyncStatus.pending),
              syncStatus: const Value(OfflineSyncStatus.pending),
              recordId: Value(recordId),
              recordType: Value(normalizedType),
              createdBy: Value(workerId),
              fieldWorkerId: Value(workerId),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
    });

    return recordId;
  }

  /// Queues evidence for an existing record without creating a replacement
  /// field operation. The original record UUID remains the association key.
  Future<List<String>> queueAttachments({
    required String recordId,
    required String recordType,
    required List<String> filePaths,
  }) async {
    final normalizedRecordId = recordId.trim();
    final normalizedType = recordType.trim();
    final workerId = _fieldWorkerIdProvider().trim();
    if (normalizedRecordId.isEmpty) {
      throw ArgumentError.value(recordId, 'recordId', 'Record UUID is required.');
    }
    if (!OfflineRecordType.values.contains(normalizedType)) {
      throw ArgumentError.value(recordType, 'recordType', 'Unsupported record type.');
    }
    if (workerId.isEmpty || workerId == 'local-field-worker') {
      throw StateError('A signed-in field worker ID is required for attachments.');
    }
    if (filePaths.isEmpty) {
      throw ArgumentError.value(filePaths, 'filePaths', 'Select at least one file.');
    }

    final normalizedPaths = <String>[];
    for (final path in filePaths) {
      final value = path.trim();
      if (value.isEmpty || !await File(value).exists()) {
        throw ArgumentError.value(path, 'filePaths', 'A selected file could not be found.');
      }
      normalizedPaths.add(value);
    }

    final now = DateTime.now().toUtc();
    final photoIds = <String>[];
    await _database.transaction(() async {
      for (final path in normalizedPaths) {
        final photoId = _uuid.v4();
        photoIds.add(photoId);
        await _database.into(_database.offlinePhotos).insert(
          OfflinePhotosCompanion.insert(
            id: photoId,
            recordId: normalizedRecordId,
            recordType: Value(normalizedType),
            filePath: path,
            mimeType: _mimeTypeFor(path),
            createdAt: Value(now),
            updatedAt: Value(now),
            createdBy: workerId,
            fieldWorkerId: workerId,
            syncStatus: const Value(OfflineSyncStatus.pending),
            verificationStatus: const Value('verification_required'),
          ),
        );
      }
    });
    return photoIds;
  }

  String _mimeTypeFor(String path) {
    final extension = path.split('.').last.toLowerCase();
    return switch (extension) {
      'png' => 'image/png',
      'webp' => 'image/webp',
      'pdf' => 'application/pdf',
      'doc' => 'application/msword',
      'docx' =>
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      _ => 'image/jpeg',
    };
  }
}
