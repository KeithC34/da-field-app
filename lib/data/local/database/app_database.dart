import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/disease_reports_table.dart';
import 'tables/dispersals_table.dart';
import 'tables/farmers_table.dart';
import 'tables/inspections_table.dart';
import 'tables/notifications_table.dart';
import 'tables/offline_photos_table.dart';
import 'tables/offline_records_table.dart';
import 'tables/pigs_table.dart';
import 'tables/sync_queue_table.dart';
import 'tables/sync_logs_table.dart';
import 'tables/sync_metadata_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Farmers,
    DiseaseReports,
    Inspections,
    Notifications,
    Pigs,
    Dispersals,
    OfflineRecords,
    OfflinePhotos,
    SyncQueue,
    SyncLogs,
    SyncMetadata,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await customStatement('ALTER TABLE farmers RENAME TO farmers_v1');
        await migrator.createTable(farmers);
        await customStatement('''
          INSERT INTO farmers (
            id,
            full_name,
            contact_number,
            latitude,
            longitude,
            is_synced,
            created_at
          )
          SELECT
            id,
            TRIM(first_name || ' ' || last_name),
            contact_number,
            0.0,
            0.0,
            is_synced,
            created_at
          FROM farmers_v1
        ''');
        await customStatement('DROP TABLE farmers_v1');
      }
      if (from < 3) {
        await migrator.createTable(diseaseReports);
      }
      if (from < 4) {
        await migrator.createTable(inspections);
      }
      if (from < 5) {
        await migrator.createTable(pigs);
        await migrator.createTable(dispersals);
      }
      if (from < 6) {
        await customStatement('''
          CREATE TABLE IF NOT EXISTS sync_queue (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            endpoint TEXT NOT NULL,
            method TEXT NOT NULL,
            payload TEXT NOT NULL,
            status TEXT NOT NULL DEFAULT 'pending',
            created_at INTEGER NOT NULL
          )
        ''');
        if (from >= 2) {
          await customStatement(
            'ALTER TABLE farmers ADD COLUMN updated_at INTEGER NOT NULL DEFAULT 0',
          );
          await customStatement(
            'UPDATE farmers SET updated_at = created_at WHERE updated_at = 0',
          );
          await migrator.addColumn(farmers, farmers.createdBy);
          await migrator.addColumn(farmers, farmers.fieldWorkerId);
          await migrator.addColumn(farmers, farmers.syncStatus);
        }
        if (from >= 3) {
          await customStatement(
            'ALTER TABLE disease_reports ADD COLUMN updated_at INTEGER NOT NULL DEFAULT 0',
          );
          await customStatement(
            'UPDATE disease_reports SET updated_at = created_at WHERE updated_at = 0',
          );
          await migrator.addColumn(diseaseReports, diseaseReports.createdBy);
          await migrator.addColumn(
            diseaseReports,
            diseaseReports.fieldWorkerId,
          );
          await migrator.addColumn(diseaseReports, diseaseReports.syncStatus);
        }
        if (from >= 4) {
          await customStatement(
            'ALTER TABLE inspections ADD COLUMN updated_at INTEGER NOT NULL DEFAULT 0',
          );
          await customStatement(
            'UPDATE inspections SET updated_at = created_at WHERE updated_at = 0',
          );
          await migrator.addColumn(inspections, inspections.createdBy);
          await migrator.addColumn(inspections, inspections.fieldWorkerId);
          await migrator.addColumn(inspections, inspections.syncStatus);
        }
        if (from >= 5) {
          await customStatement(
            'ALTER TABLE pigs ADD COLUMN updated_at INTEGER NOT NULL DEFAULT 0',
          );
          await customStatement(
            'UPDATE pigs SET updated_at = created_at WHERE updated_at = 0',
          );
          await migrator.addColumn(pigs, pigs.createdBy);
          await migrator.addColumn(pigs, pigs.fieldWorkerId);
          await migrator.addColumn(pigs, pigs.syncStatus);
          await customStatement(
            'ALTER TABLE dispersals ADD COLUMN updated_at INTEGER NOT NULL DEFAULT 0',
          );
          await customStatement(
            'UPDATE dispersals SET updated_at = created_at WHERE updated_at = 0',
          );
          await migrator.addColumn(dispersals, dispersals.createdBy);
          await migrator.addColumn(dispersals, dispersals.fieldWorkerId);
          await migrator.addColumn(dispersals, dispersals.syncStatus);
        }
        await migrator.addColumn(syncQueue, syncQueue.syncStatus);
        await migrator.addColumn(syncQueue, syncQueue.recordId);
        await migrator.addColumn(syncQueue, syncQueue.recordType);
        await migrator.addColumn(syncQueue, syncQueue.createdBy);
        await migrator.addColumn(syncQueue, syncQueue.fieldWorkerId);
        await migrator.addColumn(syncQueue, syncQueue.retryCount);
        await migrator.addColumn(syncQueue, syncQueue.lastError);
        await customStatement(
          'ALTER TABLE sync_queue ADD COLUMN updated_at INTEGER NOT NULL DEFAULT 0',
        );
        await customStatement(
          'UPDATE sync_queue SET updated_at = created_at WHERE updated_at = 0',
        );
        await migrator.createTable(offlineRecords);
        await migrator.createTable(offlinePhotos);

        await customStatement('''
          UPDATE farmers
          SET sync_status = CASE WHEN is_synced = 1 THEN 'synced' ELSE 'pending' END
        ''');
        await customStatement('''
          UPDATE disease_reports
          SET sync_status = CASE WHEN is_synced = 1 THEN 'synced' ELSE 'pending' END
        ''');
        await customStatement('''
          UPDATE inspections
          SET sync_status = CASE WHEN is_synced = 1 THEN 'synced' ELSE 'pending' END
        ''');
        await customStatement('''
          UPDATE pigs
          SET sync_status = CASE WHEN is_synced = 1 THEN 'synced' ELSE 'pending' END
        ''');
        await customStatement('''
          UPDATE dispersals
          SET sync_status = CASE WHEN is_synced = 1 THEN 'synced' ELSE 'pending' END
        ''');
        await customStatement('UPDATE sync_queue SET sync_status = status');
      }
      if (from < 7) {
        await migrator.addColumn(syncQueue, syncQueue.lastAttemptAt);
        await migrator.addColumn(syncQueue, syncQueue.nextAttemptAt);
        await migrator.addColumn(syncQueue, syncQueue.serverRecordId);
        // Pre-v6 upgrades create these tables above from their latest schema.
        if (from >= 6) {
          await migrator.addColumn(
            offlineRecords,
            offlineRecords.serverRecordId,
          );
          await migrator.addColumn(
            offlineRecords,
            offlineRecords.serverUpdatedAt,
          );
          await migrator.addColumn(offlinePhotos, offlinePhotos.serverFileId);
        }
        await migrator.createTable(syncLogs);
        await migrator.createTable(syncMetadata);

        // A process can be terminated while an item is marked as syncing.
        // Recover it as pending so reopening the app never strands the record.
        await customStatement('''
          UPDATE sync_queue
          SET status = 'pending', sync_status = 'pending'
          WHERE sync_status = 'syncing'
        ''');
        await customStatement('''
          UPDATE offline_records
          SET sync_status = 'pending'
          WHERE sync_status = 'syncing'
        ''');
        await customStatement('''
          UPDATE offline_photos
          SET sync_status = 'pending'
          WHERE sync_status = 'syncing'
        ''');
      }
      if (from < 8) {
        // Databases older than v7 create OfflinePhotos using the current
        // schema in the v6 migration, so only v7 needs ALTER statements.
        if (from >= 7) {
          await migrator.addColumn(offlinePhotos, offlinePhotos.recordType);
          await migrator.addColumn(offlinePhotos, offlinePhotos.serverFileUrl);
          await migrator.addColumn(
            offlinePhotos,
            offlinePhotos.verificationStatus,
          );
        }
      }
      if (from < 9) {
        await migrator.createTable(notifications);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final databaseDirectory = await getApplicationDocumentsDirectory();
    final databaseFile = File(
      p.join(databaseDirectory.path, 'da_field_app.sqlite'),
    );

    return NativeDatabase.createInBackground(databaseFile);
  });
}
