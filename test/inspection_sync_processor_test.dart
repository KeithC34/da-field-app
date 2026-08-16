import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/data/sync/sync_processor.dart';
import 'package:da_field_app/domain/repositories/inspection_repository.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('processQueue uploads inspections as multipart data', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'inspection-sync-',
    );
    final photo = File(
      '${temporaryDirectory.path}${Platform.pathSeparator}pen-condition.jpg',
    );
    await photo.writeAsBytes([0xFF, 0xD8, 0xFF, 0xD9]);
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requestReceived = Completer<void>();

    server.listen((request) async {
      expect(request.method, 'POST');
      expect(request.uri.path, '/inspections');
      expect(request.headers.contentType?.mimeType, 'multipart/form-data');

      final body = latin1.decode(
        await request.fold<List<int>>(<int>[], (bytes, chunk) {
          bytes.addAll(chunk);
          return bytes;
        }),
      );
      expect(body, contains('name="inspection_id"'));
      expect(body, contains('inspection-uuid'));
      expect(body, contains('name="pen_id"'));
      expect(body, contains('pen-001'));
      expect(body, contains('name="waste_management_compliant"'));
      expect(body, contains('true'));
      expect(body, contains('name="wastewater_ph"'));
      expect(body, contains('7.2'));
      expect(body, contains('name="coliform_level"'));
      expect(body, contains('15.0'));
      expect(body, contains('name="latitude"'));
      expect(body, contains('14.197'));
      expect(body, contains('name="longitude"'));
      expect(body, contains('121.429'));
      expect(body, contains('name="photo"'));
      expect(body, contains('filename="pen-condition.jpg"'));
      expect(body, isNot(contains('photoPath')));

      request.response
        ..statusCode = HttpStatus.created
        ..headers.contentType = ContentType.json
        ..write('{}');
      await request.response.close();
      requestReceived.complete();
    });

    try {
      await InspectionRepository(database).submitInspection(
        'inspection-uuid',
        'pen-001',
        true,
        7.2,
        15,
        14.197,
        121.429,
        photo.path,
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

      final inspections = await database.select(database.inspections).get();
      expect(inspections.single.isSynced, isTrue);
      final queue = await database.select(database.syncQueue).getSingle();
      expect(queue.syncStatus, 'synced');
      expect(queue.status, 'synced');
    } finally {
      await server.close(force: true);
      await database.close();
      await temporaryDirectory.delete(recursive: true);
    }
  });
}
