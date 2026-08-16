import 'dart:io';

import 'package:da_field_app/data/local/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  test('schema v1 records migrate through schema v9', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'da-field-app-migration-',
    );
    final databaseFile = File(
      '${temporaryDirectory.path}${Platform.pathSeparator}migration.sqlite',
    );

    final legacyDatabase = sqlite3.open(databaseFile.path);
    legacyDatabase.execute('''
      CREATE TABLE farmers (
        id TEXT NOT NULL PRIMARY KEY,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        contact_number TEXT NOT NULL,
        is_synced INTEGER NOT NULL DEFAULT 0,
        created_at INTEGER NOT NULL
      )
    ''');
    legacyDatabase.execute(
      '''
        INSERT INTO farmers (
          id,
          first_name,
          last_name,
          contact_number,
          is_synced,
          created_at
        ) VALUES (?, ?, ?, ?, ?, ?)
      ''',
      ['legacy-id', 'Maria', 'Santos', '09171234567', 0, 1704067200],
    );
    legacyDatabase.execute('PRAGMA user_version = 1');
    legacyDatabase.close();

    final database = AppDatabase.forTesting(NativeDatabase(databaseFile));

    try {
      final farmers = await database.select(database.farmers).get();

      expect(farmers, hasLength(1));
      expect(farmers.single.id, 'legacy-id');
      expect(farmers.single.fullName, 'Maria Santos');
      expect(farmers.single.contactNumber, '09171234567');
      expect(farmers.single.latitude, 0);
      expect(farmers.single.longitude, 0);
      expect(farmers.single.isSynced, isFalse);
      expect(farmers.single.syncStatus, 'pending');
      expect(farmers.single.createdBy, 'legacy');
      expect(farmers.single.fieldWorkerId, 'legacy');
      expect(await database.select(database.diseaseReports).get(), isEmpty);
      expect(await database.select(database.inspections).get(), isEmpty);
      expect(await database.select(database.pigs).get(), isEmpty);
      expect(await database.select(database.dispersals).get(), isEmpty);
      expect(database.schemaVersion, 9);
    } finally {
      await database.close();
      await temporaryDirectory.delete(recursive: true);
    }
  });

  test('schema v5 migrates safely on Android-compatible SQLite', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'da-field-app-v5-migration-',
    );
    final databaseFile = File(
      '${temporaryDirectory.path}${Platform.pathSeparator}migration.sqlite',
    );
    final legacy = sqlite3.open(databaseFile.path);
    for (final statement in [
      '''CREATE TABLE farmers (
        id TEXT NOT NULL PRIMARY KEY, full_name TEXT NOT NULL,
        contact_number TEXT NOT NULL, latitude REAL NOT NULL,
        longitude REAL NOT NULL, is_synced INTEGER NOT NULL DEFAULT 0,
        created_at INTEGER NOT NULL)''',
      '''CREATE TABLE disease_reports (
        id TEXT NOT NULL PRIMARY KEY, pig_id TEXT NOT NULL,
        symptoms TEXT NOT NULL, latitude REAL NOT NULL,
        longitude REAL NOT NULL, photo_path TEXT NOT NULL,
        is_synced INTEGER NOT NULL DEFAULT 0, created_at INTEGER NOT NULL)''',
      '''CREATE TABLE inspections (
        id TEXT NOT NULL PRIMARY KEY, pen_id TEXT NOT NULL,
        waste_management_compliant INTEGER NOT NULL,
        wastewater_ph REAL NOT NULL, coliform_level REAL NOT NULL,
        latitude REAL NOT NULL, longitude REAL NOT NULL,
        photo_path TEXT NOT NULL, is_synced INTEGER NOT NULL DEFAULT 0,
        created_at INTEGER NOT NULL)''',
      '''CREATE TABLE pigs (
        id TEXT NOT NULL PRIMARY KEY, farmer_id TEXT NOT NULL,
        pen_id TEXT NOT NULL, breed TEXT NOT NULL, weight REAL NOT NULL,
        is_synced INTEGER NOT NULL DEFAULT 0, created_at INTEGER NOT NULL)''',
      '''CREATE TABLE dispersals (
        id TEXT NOT NULL PRIMARY KEY, farmer_id TEXT NOT NULL,
        pig_id TEXT NOT NULL, condition TEXT NOT NULL, remarks TEXT NOT NULL,
        is_synced INTEGER NOT NULL DEFAULT 0, created_at INTEGER NOT NULL)''',
      '''CREATE TABLE sync_queue (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        endpoint TEXT NOT NULL, method TEXT NOT NULL, payload TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'pending', created_at INTEGER NOT NULL)''',
    ]) {
      legacy.execute(statement);
    }
    legacy.execute('''
      INSERT INTO farmers VALUES (
        'v5-farmer', 'Existing Farmer', '09170000000', 14.2, 121.4, 0,
        1704067200
      )
    ''');
    legacy.execute('PRAGMA user_version = 5');
    legacy.close();

    final database = AppDatabase.forTesting(NativeDatabase(databaseFile));
    try {
      final farmer = await database.select(database.farmers).getSingle();
      expect(farmer.id, 'v5-farmer');
      expect(farmer.updatedAt, farmer.createdAt);
      expect(farmer.syncStatus, 'pending');
      expect(await database.select(database.offlineRecords).get(), isEmpty);
      expect(await database.select(database.syncLogs).get(), isEmpty);
      expect(database.schemaVersion, 9);
    } finally {
      await database.close();
      await temporaryDirectory.delete(recursive: true);
    }
  });
}
