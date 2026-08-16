import 'dart:convert';

import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/domain/repositories/pig_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late PigRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = PigRepository(database);
  });

  tearDown(() => database.close());

  test('registerPig saves pig and JSON queue item atomically', () async {
    await repository.registerPig(
      'pig-uuid',
      'farmer-001',
      'pen-001',
      'Large White',
      82.5,
    );

    final pigs = await database.select(database.pigs).get();
    final queueItems = await database.select(database.syncQueue).get();

    expect(pigs, hasLength(1));
    expect(pigs.single.id, 'pig-uuid');
    expect(pigs.single.farmerId, 'farmer-001');
    expect(pigs.single.penId, 'pen-001');
    expect(pigs.single.breed, 'Large White');
    expect(pigs.single.weight, 82.5);
    expect(pigs.single.isSynced, isFalse);

    expect(queueItems, hasLength(1));
    expect(queueItems.single.endpoint, '/pigs');
    expect(queueItems.single.method, 'POST');
    expect(queueItems.single.status, 'pending');
    expect(jsonDecode(queueItems.single.payload), {
      'pig_id': 'pig-uuid',
      'farmer_id': 'farmer-001',
      'pen_id': 'pen-001',
      'breed': 'Large White',
      'weight': 82.5,
    });
  });

  test('registerPig rejects a non-positive weight before writing', () async {
    await expectLater(
      repository.registerPig(
        'pig-uuid',
        'farmer-001',
        'pen-001',
        'Large White',
        0,
      ),
      throwsArgumentError,
    );

    expect(await database.select(database.pigs).get(), isEmpty);
    expect(await database.select(database.syncQueue).get(), isEmpty);
  });
}
