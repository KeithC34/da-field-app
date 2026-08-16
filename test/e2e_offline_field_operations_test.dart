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
  test('E2E mock: every field workflow survives offline restart and uploads GPS and photo evidence once', () async {
    final directory = await Directory.systemTemp.createTemp('da-e2e-');
    final dbFile = File('${directory.path}${Platform.pathSeparator}offline.sqlite');
    final photo = File('${directory.path}${Platform.pathSeparator}mock-camera.jpg');
    // Small valid JPEG envelope representing a camera capture.
    await photo.writeAsBytes([0xff, 0xd8, 0xff, 0xe0, 0, 16, 0x4a, 0x46, 0x49, 0x46, 0, 1, 0xff, 0xd9]);
    final types = [
      OfflineRecordType.pigHealth, OfflineRecordType.diseaseReport,
      OfflineRecordType.piglet, OfflineRecordType.pigPenInspection,
      OfflineRecordType.wasteInspection, OfflineRecordType.wastewaterInspection,
      OfflineRecordType.fieldVerification, OfflineRecordType.dispersalMonitoring,
      OfflineRecordType.returnPigletVerification,
    ];
    final recordsReceived = <String>[];
    final photosReceived = <String>[];
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((request) async {
      if (request.uri.path == '/mobile-sync/records' && request.method == 'POST') {
        final body = jsonDecode(await utf8.decoder.bind(request).join()) as Map<String, dynamic>;
        recordsReceived.add(body['record_id'] as String);
        expect(body['latitude'], 14.203194); expect(body['longitude'], 121.430591);
        request.response.headers.contentType = ContentType.json;
        request.response.write(jsonEncode({'id': 'server-${body['record_id']}', 'updated_at': DateTime.now().toUtc().toIso8601String()}));
      } else if (request.uri.path.startsWith('/mobile-sync/records/') && request.uri.path.endsWith('/photos')) {
        final parts = request.uri.path.split('/'); photosReceived.add(parts[3]);
        await request.drain<void>(); request.response.headers.contentType = ContentType.json;
        request.response.write(jsonEncode({'media_file_id': 'secure-${parts[3]}', 'file_url': 'https://object.example/${parts[3]}.jpg'}));
      } else { request.response.statusCode = HttpStatus.notFound; }
      await request.response.close();
    });
    AppDatabase? database;
    try {
      database = AppDatabase.forTesting(NativeDatabase(dbFile));
      final writer = OfflineRecordRepository(database, fieldWorkerIdProvider: () => 'mock-field-worker');
      for (final type in types) {
        await writer.saveRecord(id: 'mock-$type', recordType: type, endpoint: '/$type', method: 'POST', latitude: 14.203194, longitude: 121.430591, photoPaths: [photo.path], payload: {'farmer_id': 'farmer-e2e', 'pig_id': 'pig-e2e', 'source': 'mock-e2e'});
      }
      expect(await database.select(database.offlineRecords).get(), hasLength(types.length));
      expect(await database.select(database.offlinePhotos).get(), hasLength(types.length));
      await database.close(); // Simulates closing the app while offline.

      database = AppDatabase.forTesting(NativeDatabase(dbFile));
      final processor = SyncProcessor(database, Dio(BaseOptions(baseUrl: 'http://127.0.0.1:${server.port}')), Connectivity(), connectivityCheck: () async => [ConnectivityResult.wifi], downloadChanges: false);
      final result = await processor.processQueue(force: true);
      expect(result.status, 'completed'); expect(result.uploaded, types.length);
      expect(recordsReceived.toSet(), {for (final type in types) 'mock-$type'});
      expect(photosReceived.toSet(), recordsReceived.toSet());
      expect((await database.select(database.offlineRecords).get()).map((r) => r.syncStatus), everyElement(OfflineSyncStatus.synced));
      expect((await database.select(database.offlinePhotos).get()).map((p) => p.syncStatus), everyElement(OfflineSyncStatus.synced));
      expect(await photo.exists(), isTrue); // Local evidence is retained after upload.
    } finally {
      await database?.close(); await server.close(force: true); await directory.delete(recursive: true);
    }
  });
}
