import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:da_field_app/core/sync/offline_record_type.dart';
import 'package:da_field_app/core/sync/offline_sync_status.dart';
import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/data/sync/sync_processor.dart';
import 'package:da_field_app/domain/repositories/offline_record_repository.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('interrupted pig health sync resumes, retries photo, logs, and stays idempotent', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'phase19-sync-',
    );
    final photo = File(
      '${temporaryDirectory.path}${Platform.pathSeparator}health.jpg',
    );
    await photo.writeAsBytes([0xFF, 0xD8, 0xFF, 0xD9]);
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    var recordUploads = 0;
    var photoAttempts = 0;
    var pulls = 0;
    String? idempotencyKey;
    final serverTime = DateTime.now().toUtc().toIso8601String();

    server.listen((request) async {
      if (request.method == 'POST' &&
          request.uri.path == '/mobile-sync/records') {
        recordUploads++;
        idempotencyKey = request.headers.value('Idempotency-Key');
        await request.drain<void>();
        request.response
          ..statusCode = HttpStatus.created
          ..headers.contentType = ContentType.json
          ..write(
            jsonEncode({'id': 'mongo-record-id', 'updated_at': serverTime}),
          );
      } else if (request.method == 'POST' &&
          request.uri.path.contains('/mobile-sync/records/')) {
        photoAttempts++;
        await request.drain<void>();
        request.response
          ..statusCode = photoAttempts == 1
              ? HttpStatus.serviceUnavailable
              : HttpStatus.created
          ..headers.contentType = ContentType.json
          ..write(
            jsonEncode({if (photoAttempts > 1) 'file_id': 'gridfs-file-id'}),
          );
      } else if (request.method == 'GET' &&
          request.uri.path == '/mobile-sync/changes') {
        pulls++;
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write(
            jsonEncode({
              'records': [
                {
                  'record_id': '9188345e-1e79-46e1-8396-967e9e6c0ba5',
                  'server_record_id': 'mongo-farmer-id',
                  'record_type': 'farmer',
                  'payload': {
                    'farmer_id': 'farmer-001',
                    'full_name': 'Server Farmer',
                    'location': {
                      'type': 'Point',
                      'coordinates': [121.4305869, 14.2031938],
                    },
                  },
                  'created_at': '2026-08-15T18:57:47.841000',
                  'updated_at': '2026-08-15T18:57:47.841000',
                  'created_by': 'field-worker-uuid',
                  'field_worker_id': 'field-worker-uuid',
                },
              ],
              'cursor': DateTime.now().toUtc().toIso8601String(),
              'has_more': false,
            }),
          );
      } else {
        request.response.statusCode = HttpStatus.notFound;
      }
      await request.response.close();
    });

    try {
      const recordId = '694a9196-1155-41fb-87e2-cb028a1936c7';
      final repository = OfflineRecordRepository(
        database,
        fieldWorkerIdProvider: () => 'field-worker-uuid',
      );
      await repository.saveRecord(
        id: recordId,
        recordType: OfflineRecordType.pigHealth,
        payload: {'pig_id': 'pig-001', 'assessment': 'Healthy'},
        endpoint: '/pig-health',
        method: 'POST',
        latitude: 14.203194,
        longitude: 121.430591,
        photoPaths: [photo.path],
      );

      // Simulate the OS terminating the process in the middle of a run.
      await database
          .update(database.syncQueue)
          .write(
            const SyncQueueCompanion(
              status: Value(OfflineSyncStatus.syncing),
              syncStatus: Value(OfflineSyncStatus.syncing),
            ),
          );
      await database
          .update(database.offlineRecords)
          .write(
            const OfflineRecordsCompanion(
              syncStatus: Value(OfflineSyncStatus.syncing),
            ),
          );

      final processor = SyncProcessor(
        database,
        Dio(BaseOptions(baseUrl: 'http://127.0.0.1:${server.port}')),
        Connectivity(),
        connectivityCheck: () async => [ConnectivityResult.wifi],
      );
      final first = await processor.processQueue(trigger: 'test', force: true);

      expect(first.status, 'completed');
      expect(first.uploaded, 1);
      expect(first.downloaded, 1);
      expect(recordUploads, 1);
      expect(photoAttempts, 2);
      expect(pulls, 1);
      expect(idempotencyKey, recordId);
      expect(
        (await database.select(database.syncQueue).getSingle()).syncStatus,
        OfflineSyncStatus.synced,
      );
      final storedPhoto = await database
          .select(database.offlinePhotos)
          .getSingle();
      expect(storedPhoto.syncStatus, OfflineSyncStatus.synced);
      expect(storedPhoto.serverFileId, 'gridfs-file-id');
      final log = await database.select(database.syncLogs).getSingle();
      expect(log.status, 'completed');
      expect(log.uploadedCount, 1);
      expect(log.downloadedCount, 1);
      expect(
        await database.select(database.offlineRecords).get(),
        hasLength(2),
      );

      // A second run pulls changes but never uploads the synced UUID again.
      await processor.processQueue(trigger: 'test-repeat', force: true);
      expect(recordUploads, 1);
      expect(photoAttempts, 2);
      expect(pulls, 2);
      expect(await database.select(database.syncQueue).get(), hasLength(1));
    } finally {
      await server.close(force: true);
      await database.close();
      await temporaryDirectory.delete(recursive: true);
    }
  });
}
