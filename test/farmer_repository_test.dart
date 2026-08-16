import 'dart:convert';

import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:da_field_app/domain/repositories/farmer_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late FarmerRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = FarmerRepository(database);
  });

  tearDown(() => database.close());

  test('registerFarmer saves the farmer and queue item atomically', () async {
    await repository.registerFarmer(
      'farmer-uuid',
      'Juan Dela Cruz',
      '09171234567',
      14.197,
      121.429,
    );

    final farmers = await database.select(database.farmers).get();
    final queueItems = await database.select(database.syncQueue).get();

    expect(farmers, hasLength(1));
    expect(farmers.single.id, 'farmer-uuid');
    expect(farmers.single.fullName, 'Juan Dela Cruz');
    expect(farmers.single.contactNumber, '09171234567');
    expect(farmers.single.latitude, 14.197);
    expect(farmers.single.longitude, 121.429);
    expect(farmers.single.isSynced, isFalse);

    expect(queueItems, hasLength(1));
    expect(queueItems.single.endpoint, '/pig-farmers');
    expect(queueItems.single.method, 'POST');
    expect(queueItems.single.status, 'pending');

    final payload =
        jsonDecode(queueItems.single.payload) as Map<String, dynamic>;
    expect(payload['farmer_id'], 'farmer-uuid');
    expect(payload['full_name'], 'Juan Dela Cruz');
    expect(payload['contact_number'], '09171234567');
    expect(payload['location'], {
      'type': 'Point',
      'coordinates': [121.429, 14.197],
    });
  });

  test('registerFarmer rolls back when the farmer ID already exists', () async {
    await repository.registerFarmer(
      'duplicate-id',
      'First Farmer',
      '09170000001',
      14.197,
      121.429,
    );

    await expectLater(
      repository.registerFarmer(
        'duplicate-id',
        'Second Farmer',
        '09170000002',
        14.198,
        121.430,
      ),
      throwsA(anything),
    );

    final farmers = await database.select(database.farmers).get();
    final queueItems = await database.select(database.syncQueue).get();

    expect(farmers, hasLength(1));
    expect(queueItems, hasLength(1));
  });
}
