import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/data/sync/sync_processor.dart';
import 'package:da_field_app/domain/repositories/farmer_repository.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('processQueue syncs a farmer JSON record', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requestReceived = Completer<void>();

    server.listen((request) async {
      expect(request.method, 'POST');
      expect(request.uri.path, '/pig-farmers');
      final payload = jsonDecode(
        await utf8.decoder.bind(request).join(),
      ) as Map<String, dynamic>;
      expect(payload['farmer_id'], 'farmer-uuid');
      expect(payload['full_name'], 'Maria Santos');
      expect(payload['contact_number'], '09171234567');
      expect(payload['location'], {
        'type': 'Point',
        'coordinates': [121.429, 14.197],
      });

      request.response
        ..statusCode = HttpStatus.created
        ..headers.contentType = ContentType.json
        ..write('{}');
      await request.response.close();
      requestReceived.complete();
    });

    try {
      await FarmerRepository(database).registerFarmer(
        'farmer-uuid',
        'Maria Santos',
        '09171234567',
        14.197,
        121.429,
      );
      final processor = SyncProcessor(
        database,
        Dio(BaseOptions(baseUrl: 'http://127.0.0.1:${server.port}')),
        Connectivity(),
        connectivityCheck: () async => [ConnectivityResult.wifi],
        downloadChanges: false,
      );

      await processor.processQueue();
      await requestReceived.future.timeout(const Duration(seconds: 5));

      expect(
        (await database.select(database.farmers).get()).single.isSynced,
        isTrue,
      );
      final queue = await database.select(database.syncQueue).getSingle();
      expect(queue.syncStatus, 'synced');
      expect(queue.status, 'synced');
    } finally {
      await server.close(force: true);
      await database.close();
    }
  });

  test('processQueue leaves records pending while offline', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());

    try {
      await FarmerRepository(database).registerFarmer(
        'farmer-uuid',
        'Maria Santos',
        '09171234567',
        14.197,
        121.429,
      );
      final processor = SyncProcessor(
        database,
        Dio(BaseOptions(baseUrl: 'http://127.0.0.1:1')),
        Connectivity(),
        connectivityCheck: () async => [ConnectivityResult.none],
        downloadChanges: false,
      );

      await processor.processQueue();

      expect(
        (await database.select(database.farmers).get()).single.isSynced,
        isFalse,
      );
      expect(await database.select(database.syncQueue).get(), hasLength(1));
    } finally {
      await database.close();
    }
  });
}
