import 'dart:convert';

import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/domain/repositories/dispersal_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late DispersalRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DispersalRepository(database);
  });

  tearDown(() => database.close());

  test('submitDispersal saves monitoring and queue item atomically', () async {
    await repository.submitDispersal(
      'dispersal-uuid',
      'farmer-001',
      'pig-001',
      'Healthy',
      'Eating normally and gaining weight.',
    );

    final dispersals = await database.select(database.dispersals).get();
    final queueItems = await database.select(database.syncQueue).get();

    expect(dispersals, hasLength(1));
    expect(dispersals.single.id, 'dispersal-uuid');
    expect(dispersals.single.farmerId, 'farmer-001');
    expect(dispersals.single.pigId, 'pig-001');
    expect(dispersals.single.condition, 'Healthy');
    expect(dispersals.single.remarks, 'Eating normally and gaining weight.');
    expect(dispersals.single.isSynced, isFalse);

    expect(queueItems, hasLength(1));
    expect(queueItems.single.endpoint, '/dispersals');
    expect(queueItems.single.method, 'POST');
    expect(queueItems.single.status, 'pending');
    expect(jsonDecode(queueItems.single.payload), {
      'dispersal_id': 'dispersal-uuid',
      'farmer_id': 'farmer-001',
      'pig_id': 'pig-001',
      'condition': 'Healthy',
      'remarks': 'Eating normally and gaining weight.',
    });
  });

  test('submitDispersal rejects blank remarks before writing', () async {
    await expectLater(
      repository.submitDispersal(
        'dispersal-uuid',
        'farmer-001',
        'pig-001',
        'Healthy',
        '  ',
      ),
      throwsArgumentError,
    );

    expect(await database.select(database.dispersals).get(), isEmpty);
    expect(await database.select(database.syncQueue).get(), isEmpty);
  });
}
