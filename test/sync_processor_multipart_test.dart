import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/data/sync/sync_processor.dart';
import 'package:da_field_app/domain/repositories/disease_report_repository.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('processQueue uploads disease reports as multipart data', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'disease-report-sync-',
    );
    final photo = File(
      '${temporaryDirectory.path}${Platform.pathSeparator}symptoms.jpg',
    );
    await photo.writeAsBytes([0xFF, 0xD8, 0xFF, 0xD9]);
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requestReceived = Completer<void>();

    server.listen((request) async {
      expect(request.method, 'POST');
      expect(request.uri.path, '/disease-reports');
      expect(request.headers.contentType?.mimeType, 'multipart/form-data');

      final body = latin1.decode(
        await request.fold<List<int>>(<int>[], (bytes, chunk) {
          bytes.addAll(chunk);
          return bytes;
        }),
      );
      expect(body, contains('name="disease_id"'));
      expect(body, contains('disease-uuid'));
      expect(body, contains('name="pig_id"'));
      expect(body, contains('pig-001'));
      expect(body, contains('name="symptoms"'));
      expect(body, contains('Loss of appetite and coughing'));
      expect(body, contains('name="latitude"'));
      expect(body, contains('14.197'));
      expect(body, contains('name="longitude"'));
      expect(body, contains('121.429'));
      expect(body, contains('name="photo"'));
      expect(body, contains('filename="symptoms.jpg"'));
      expect(body, isNot(contains('photoPath')));

      request.response
        ..statusCode = HttpStatus.created
        ..headers.contentType = ContentType.json
        ..write('{}');
      await request.response.close();
      requestReceived.complete();
    });

    try {
      await DiseaseReportRepository(database).reportDisease(
        'disease-uuid',
        'pig-001',
        'Loss of appetite and coughing',
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

      final reports = await database.select(database.diseaseReports).get();
      expect(reports.single.isSynced, isTrue);
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
