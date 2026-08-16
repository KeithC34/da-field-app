import 'dart:convert';
import 'dart:io';

import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/domain/repositories/disease_report_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late DiseaseReportRepository repository;
  late Directory temporaryDirectory;
  late File photo;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DiseaseReportRepository(database);
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'disease-report-repository-',
    );
    photo = File(
      '${temporaryDirectory.path}${Platform.pathSeparator}symptoms.jpg',
    );
    await photo.writeAsBytes([0xFF, 0xD8, 0xFF, 0xD9]);
  });

  tearDown(() async {
    await database.close();
    await temporaryDirectory.delete(recursive: true);
  });

  test(
    'reportDisease saves the report and multipart queue atomically',
    () async {
      await repository.reportDisease(
        'disease-uuid',
        'pig-001',
        'Loss of appetite and coughing',
        14.197,
        121.429,
        photo.path,
      );

      final reports = await database.select(database.diseaseReports).get();
      final queueItems = await database.select(database.syncQueue).get();

      expect(reports, hasLength(1));
      expect(reports.single.id, 'disease-uuid');
      expect(reports.single.pigId, 'pig-001');
      expect(reports.single.symptoms, 'Loss of appetite and coughing');
      expect(reports.single.latitude, 14.197);
      expect(reports.single.longitude, 121.429);
      expect(reports.single.photoPath, photo.path);
      expect(reports.single.isSynced, isFalse);

      expect(queueItems, hasLength(1));
      expect(queueItems.single.endpoint, '/disease-reports');
      expect(queueItems.single.method, 'POST_MULTIPART');
      expect(queueItems.single.status, 'pending');

      final payload =
          jsonDecode(queueItems.single.payload) as Map<String, dynamic>;
      expect(payload, {
        'disease_id': 'disease-uuid',
        'pig_id': 'pig-001',
        'symptoms': 'Loss of appetite and coughing',
        'latitude': 14.197,
        'longitude': 121.429,
        'photoPath': photo.path,
      });
    },
  );

  test('reportDisease rejects a missing photo before writing data', () async {
    await photo.delete();

    await expectLater(
      repository.reportDisease(
        'disease-uuid',
        'pig-001',
        'Coughing',
        14.197,
        121.429,
        photo.path,
      ),
      throwsArgumentError,
    );

    expect(await database.select(database.diseaseReports).get(), isEmpty);
    expect(await database.select(database.syncQueue).get(), isEmpty);
  });
}
