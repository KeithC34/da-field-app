import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:da_field_app/core/sync/offline_record_type.dart';
import 'package:da_field_app/core/sync/offline_sync_status.dart';
import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/data/sync/sync_processor.dart';
import 'package:da_field_app/domain/repositories/offline_record_repository.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('supporting document persists offline, retries, and remains linked to its record UUID', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final directory = await Directory.systemTemp.createTemp('phase21-media-');
    final document = File('${directory.path}${Platform.pathSeparator}support.pdf');
    await document.writeAsBytes([37, 80, 68, 70]);
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    var attempts = 0;
    server.listen((request) async {
      if (request.method == 'POST' && request.uri.path == '/media') {
        attempts++;
        expect(request.uri.queryParameters['record_id'], 'existing-record-uuid');
        expect(request.uri.queryParameters['record_type'], 'field_verification');
        await request.drain<void>();
        request.response
          ..statusCode = attempts <= 2 ? HttpStatus.serviceUnavailable : HttpStatus.created
          ..headers.contentType = ContentType.json
          ..write(jsonEncode({'file_id': 'secure-file-id', 'file_url': 'https://storage.example/evidence.pdf'}));
      } else {
        request.response.statusCode = HttpStatus.notFound;
      }
      await request.response.close();
    });

    try {
      final repository = OfflineRecordRepository(database, fieldWorkerIdProvider: () => 'field-worker-uuid');
      final attachmentIds = await repository.queueAttachments(
        recordId: 'existing-record-uuid',
        recordType: OfflineRecordType.fieldVerification,
        filePaths: [document.path],
      );
      final queued = await database.select(database.offlinePhotos).getSingle();
      expect(attachmentIds, [queued.id]);
      expect(queued.recordId, 'existing-record-uuid');
      expect(queued.recordType, OfflineRecordType.fieldVerification);
      expect(queued.mimeType, 'application/pdf');
      expect(queued.syncStatus, OfflineSyncStatus.pending);
      expect(queued.verificationStatus, 'verification_required');

      final processor = SyncProcessor(
        database,
        Dio(BaseOptions(baseUrl: 'http://127.0.0.1:${server.port}')),
        Connectivity(),
        connectivityCheck: () async => [ConnectivityResult.wifi],
        downloadChanges: false,
      );
      final first = await processor.processQueue(force: true);
      expect(first.status, 'partial');
      expect((await database.select(database.offlinePhotos).getSingle()).syncStatus, OfflineSyncStatus.failed);
      expect(await document.exists(), isTrue);

      final second = await processor.processQueue(force: true);
      final uploaded = await database.select(database.offlinePhotos).getSingle();
      expect(second.status, 'completed');
      expect(attempts, 3); // one transient retry, then the manual retry.
      expect(uploaded.syncStatus, OfflineSyncStatus.synced);
      expect(uploaded.serverFileId, 'secure-file-id');
      expect(uploaded.serverFileUrl, 'https://storage.example/evidence.pdf');
      expect(uploaded.recordId, 'existing-record-uuid');
    } finally {
      await server.close(force: true);
      await database.close();
      await directory.delete(recursive: true);
    }
  });
}
