import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:da_field_app/core/sync/offline_record_type.dart';
import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/data/sync/sync_processor.dart';
import 'package:da_field_app/domain/repositories/offline_record_repository.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late OfflineRecordRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = OfflineRecordRepository(
      database,
      fieldWorkerIdProvider: () => 'field-worker-uuid',
    );
  });

  tearDown(() => database.close());

  test(
    'all Phase 18 operation types retain complete offline metadata',
    () async {
      for (final type in [
        OfflineRecordType.pigHealth,
        OfflineRecordType.diseaseReport,
        OfflineRecordType.piglet,
        OfflineRecordType.pigPenInspection,
        OfflineRecordType.wasteInspection,
        OfflineRecordType.wastewaterInspection,
        OfflineRecordType.fieldVerification,
        OfflineRecordType.dispersalMonitoring,
        OfflineRecordType.returnPigletVerification,
      ]) {
        await repository.saveRecord(
          id: 'record-$type',
          recordType: type,
          payload: {'sample': type},
          endpoint: '/$type',
          method: 'POST',
          latitude: 14.203194,
          longitude: 121.430591,
        );
      }

      final records = await database.select(database.offlineRecords).get();
      final queue = await database.select(database.syncQueue).get();

      expect(records, hasLength(9));
      expect(queue, hasLength(9));
      for (final record in records) {
        expect(record.id, startsWith('record-'));
        expect(record.createdAt, isNotNull);
        expect(record.updatedAt, isNotNull);
        expect(record.createdBy, 'field-worker-uuid');
        expect(record.fieldWorkerId, 'field-worker-uuid');
        expect(record.syncStatus, 'pending');
        expect(record.latitude, 14.203194);
        expect(record.longitude, 121.430591);
      }
      expect(queue.map((item) => item.syncStatus), everyElement('pending'));
    },
  );

  test(
    'generic records retain photos and sync state after a failed attempt',
    () async {
      final temporaryDirectory = await Directory.systemTemp.createTemp(
        'offline-record-photo-',
      );
      final photo = File(
        '${temporaryDirectory.path}${Platform.pathSeparator}photo.jpg',
      );
      await photo.writeAsBytes([0xFF, 0xD8, 0xFF, 0xD9]);

      try {
        final recordId = await repository.saveRecord(
          id: 'health-record',
          recordType: OfflineRecordType.pigHealth,
          payload: {'pig_id': 'pig-001', 'assessment': 'Healthy'},
          endpoint: '/unavailable',
          method: 'POST',
          latitude: 14.203194,
          longitude: 121.430591,
          photoPaths: [photo.path],
        );
        final processor = SyncProcessor(
          database,
          Dio(BaseOptions(baseUrl: 'http://127.0.0.1:1')),
          Connectivity(),
          connectivityCheck: () async => [ConnectivityResult.wifi],
          downloadChanges: false,
        );

        await processor.processQueue();

        final record = await (database.select(
          database.offlineRecords,
        )..where((table) => table.id.equals(recordId))).getSingle();
        final queue = await database.select(database.syncQueue).getSingle();
        final storedPhoto = await database
            .select(database.offlinePhotos)
            .getSingle();

        expect(record.syncStatus, 'failed');
        expect(queue.syncStatus, 'failed');
        expect(queue.retryCount, 1);
        expect(queue.lastError, isNotEmpty);
        expect(storedPhoto.filePath, photo.path);
        expect(storedPhoto.syncStatus, 'failed');
      } finally {
        await temporaryDirectory.delete(recursive: true);
      }
    },
  );
}
