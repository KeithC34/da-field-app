import 'dart:convert';
import 'dart:io';

import 'package:da_field_app/core/sync/offline_record_type.dart';
import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/data/sync/sync_processor.dart';
import 'package:da_field_app/domain/repositories/field_operations_repository.dart';
import 'package:da_field_app/domain/repositories/offline_record_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

void main() {
  late AppDatabase database;
  late FieldOperationsRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = FieldOperationsRepository(OfflineRecordRepository(database, fieldWorkerIdProvider: () => 'worker-1'));
  });
  tearDown(() => database.close());

  test('piglet retains farmer, sow, and pen relationships offline', () async {
    await repository.saveOperation(recordType: OfflineRecordType.piglet, id: 'piglet-1', latitude: 14.2, longitude: 121.4, payload: {'piglet_id': 'piglet-1', 'farmer_id': 'farmer-1', 'mother_sow_id': 'sow-1', 'pen_id': 'pen-1'});
    final record = await database.select(database.offlineRecords).getSingle();
    final payload = jsonDecode(record.payload) as Map<String, dynamic>;
    expect(payload['farmer_id'], 'farmer-1');
    expect(payload['mother_sow_id'], 'sow-1');
    expect(payload['pen_id'], 'pen-1');
    expect(record.syncStatus, 'pending');
  });

  test('wastewater preserves GPS and return verification stays linked to dispersal', () async {
    final temp = await Directory.systemTemp.createTemp('phase215-');
    final photo = File('${temp.path}${Platform.pathSeparator}return.jpg');
    await photo.writeAsBytes([0xff, 0xd8, 0xff, 0xd9]);
    try {
      await repository.saveOperation(recordType: OfflineRecordType.wastewaterInspection, id: 'water-1', latitude: 14.234, longitude: 121.456, payload: {'farmer_id': 'farmer-1', 'pen_id': 'pen-1'});
      await repository.saveOperation(recordType: OfflineRecordType.returnPigletVerification, id: 'return-1', latitude: 14.235, longitude: 121.457, photoPaths: [photo.path], payload: {'dispersal_id': 'distribution-1', 'piglet_id': 'piglet-1'});
      final records = await database.select(database.offlineRecords).get();
      final water = records.firstWhere((record) => record.id == 'water-1');
      final returned = records.firstWhere((record) => record.id == 'return-1');
      expect((jsonDecode(water.payload) as Map)['location'], {'latitude': 14.234, 'longitude': 121.456});
      expect((jsonDecode(returned.payload) as Map)['dispersal_id'], 'distribution-1');
      expect((await database.select(database.offlinePhotos).getSingle()).recordId, 'return-1');
    } finally {
      await temp.delete(recursive: true);
    }
  });

  test('duplicate record UUID is rejected instead of producing a second queue item', () async {
    await repository.saveOperation(recordType: OfflineRecordType.wasteInspection, id: 'fixed-id', latitude: 14.2, longitude: 121.4, payload: {'farmer_id': 'farmer-1'});
    await expectLater(repository.saveOperation(recordType: OfflineRecordType.wasteInspection, id: 'fixed-id', latitude: 14.2, longitude: 121.4, payload: {'farmer_id': 'farmer-1'}), throwsA(isA<Object>()));
    expect(await database.select(database.syncQueue).get(), hasLength(1));
  });

  test('GPS verification synchronizes as one UUID-addressable mobile record', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    Map<String, dynamic>? uploaded;
    server.listen((request) async {
      if (request.uri.path == '/mobile-sync/records') {
        uploaded = jsonDecode(await utf8.decoder.bind(request).join()) as Map<String, dynamic>;
        request.response
          ..statusCode = HttpStatus.created
          ..headers.contentType = ContentType.json
          ..write(jsonEncode({'id': 'server-verification', 'updated_at': DateTime.now().toUtc().toIso8601String()}));
      } else {
        request.response.statusCode = HttpStatus.notFound;
      }
      await request.response.close();
    });
    try {
      await repository.saveOperation(recordType: OfflineRecordType.fieldVerification, id: 'verification-1', latitude: 14.201, longitude: 121.401, payload: {'verification_type': 'pig_pen_coordinate', 'pen_id': 'pen-1'});
      final processor = SyncProcessor(database, Dio(BaseOptions(baseUrl: 'http://${server.address.address}:${server.port}')), Connectivity(), connectivityCheck: () async => [ConnectivityResult.wifi], downloadChanges: false);
      await processor.processQueue();
      expect(uploaded?['record_id'], 'verification-1');
      expect(uploaded?['longitude'], 121.401);
      expect(uploaded?['latitude'], 14.201);
      expect((uploaded?['payload'] as Map)['location'], {'latitude': 14.201, 'longitude': 121.401});
      expect((await database.select(database.offlineRecords).getSingle()).syncStatus, 'synced');
    } finally {
      await server.close(force: true);
    }
  });
}
