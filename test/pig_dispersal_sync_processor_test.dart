import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/data/sync/sync_processor.dart';
import 'package:da_field_app/domain/repositories/dispersal_repository.dart';
import 'package:da_field_app/domain/repositories/pig_repository.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('processQueue syncs pig and dispersal JSON records', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requestsReceived = Completer<void>();
    final receivedPaths = <String>[];
    final receivedBodies = <Map<String, dynamic>>[];

    server.listen((request) async {
      receivedPaths.add(request.uri.path);
      receivedBodies.add(
        jsonDecode(await utf8.decoder.bind(request).join())
            as Map<String, dynamic>,
      );
      request.response
        ..statusCode = HttpStatus.created
        ..headers.contentType = ContentType.json
        ..write('{}');
      await request.response.close();
      if (receivedPaths.length == 2 && !requestsReceived.isCompleted) {
        requestsReceived.complete();
      }
    });

    try {
      await PigRepository(
        database,
      ).registerPig('pig-uuid', 'farmer-001', 'pen-001', 'Large White', 82.5);
      await DispersalRepository(database).submitDispersal(
        'dispersal-uuid',
        'farmer-001',
        'pig-uuid',
        'Healthy',
        'Eating normally.',
      );

      final processor = SyncProcessor(
        database,
        Dio(BaseOptions(baseUrl: 'http://127.0.0.1:${server.port}')),
        Connectivity(),
        connectivityCheck: () async => [ConnectivityResult.wifi],
        downloadChanges: false,
      );
      await processor.processQueue();
      await requestsReceived.future.timeout(const Duration(seconds: 5));

      expect(receivedPaths, ['/pigs', '/dispersals']);
      expect(receivedBodies[0]['pig_id'], 'pig-uuid');
      expect(receivedBodies[1]['dispersal_id'], 'dispersal-uuid');
      expect(
        (await database.select(database.pigs).get()).single.isSynced,
        isTrue,
      );
      expect(
        (await database.select(database.dispersals).get()).single.isSynced,
        isTrue,
      );
      final queue = await database.select(database.syncQueue).get();
      expect(queue, hasLength(2));
      expect(queue.map((item) => item.syncStatus), everyElement('synced'));
    } finally {
      await server.close(force: true);
      await database.close();
    }
  });
}
