import 'dart:convert';
import 'dart:io';

import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/domain/repositories/inspection_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late InspectionRepository repository;
  late Directory temporaryDirectory;
  late File photo;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = InspectionRepository(database);
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'inspection-repository-',
    );
    photo = File(
      '${temporaryDirectory.path}${Platform.pathSeparator}pen-condition.jpg',
    );
    await photo.writeAsBytes([0xFF, 0xD8, 0xFF, 0xD9]);
  });

  tearDown(() async {
    await database.close();
    await temporaryDirectory.delete(recursive: true);
  });

  test(
    'submitInspection saves inspection and multipart queue atomically',
    () async {
      await repository.submitInspection(
        'inspection-uuid',
        'pen-001',
        true,
        7.2,
        15,
        14.197,
        121.429,
        photo.path,
      );

      final inspections = await database.select(database.inspections).get();
      final queueItems = await database.select(database.syncQueue).get();

      expect(inspections, hasLength(1));
      expect(inspections.single.id, 'inspection-uuid');
      expect(inspections.single.penId, 'pen-001');
      expect(inspections.single.wasteManagementCompliant, isTrue);
      expect(inspections.single.wastewaterPh, 7.2);
      expect(inspections.single.coliformLevel, 15);
      expect(inspections.single.latitude, 14.197);
      expect(inspections.single.longitude, 121.429);
      expect(inspections.single.photoPath, photo.path);
      expect(inspections.single.isSynced, isFalse);

      expect(queueItems, hasLength(1));
      expect(queueItems.single.endpoint, '/inspections');
      expect(queueItems.single.method, 'POST_MULTIPART');
      expect(queueItems.single.status, 'pending');

      final payload =
          jsonDecode(queueItems.single.payload) as Map<String, dynamic>;
      expect(payload, {
        'inspection_id': 'inspection-uuid',
        'pen_id': 'pen-001',
        'waste_management_compliant': true,
        'wastewater_ph': 7.2,
        'coliform_level': 15.0,
        'latitude': 14.197,
        'longitude': 121.429,
        'photoPath': photo.path,
      });
    },
  );

  test('submitInspection rejects an invalid pH before writing data', () async {
    await expectLater(
      repository.submitInspection(
        'inspection-uuid',
        'pen-001',
        false,
        14.1,
        15,
        14.197,
        121.429,
        photo.path,
      ),
      throwsArgumentError,
    );

    expect(await database.select(database.inspections).get(), isEmpty);
    expect(await database.select(database.syncQueue).get(), isEmpty);
  });
}
