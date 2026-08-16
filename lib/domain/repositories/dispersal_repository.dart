import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/sync/offline_record_type.dart';
import '../../core/sync/offline_sync_status.dart';
import '../../data/local/database/app_database.dart';

class DispersalRepository {
  DispersalRepository(
    this._database, {
    String Function()? fieldWorkerIdProvider,
  }) : _fieldWorkerIdProvider =
           fieldWorkerIdProvider ?? (() => 'test-field-worker');

  final AppDatabase _database;
  final String Function() _fieldWorkerIdProvider;

  Future<void> submitDispersal(
    String id,
    String farmerId,
    String pigId,
    String condition,
    String remarks,
  ) async {
    final normalizedId = id.trim();
    final normalizedFarmerId = farmerId.trim();
    final normalizedPigId = pigId.trim();
    final normalizedCondition = condition.trim();
    final normalizedRemarks = remarks.trim();

    if (normalizedId.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Dispersal ID is required.');
    }
    if (normalizedFarmerId.isEmpty) {
      throw ArgumentError.value(farmerId, 'farmerId', 'Farmer ID is required.');
    }
    if (normalizedPigId.isEmpty) {
      throw ArgumentError.value(pigId, 'pigId', 'Pig ID is required.');
    }
    if (normalizedCondition.isEmpty) {
      throw ArgumentError.value(
        condition,
        'condition',
        'Condition is required.',
      );
    }
    if (normalizedRemarks.isEmpty) {
      throw ArgumentError.value(remarks, 'remarks', 'Remarks are required.');
    }

    final createdAt = DateTime.now().toUtc();
    final fieldWorkerId = _fieldWorkerIdProvider().trim();
    final payload = jsonEncode({
      'dispersal_id': normalizedId,
      'farmer_id': normalizedFarmerId,
      'pig_id': normalizedPigId,
      'condition': normalizedCondition,
      'remarks': normalizedRemarks,
    });

    await _database.transaction(() async {
      await _database
          .into(_database.dispersals)
          .insert(
            DispersalsCompanion.insert(
              id: normalizedId,
              farmerId: normalizedFarmerId,
              pigId: normalizedPigId,
              condition: normalizedCondition,
              remarks: normalizedRemarks,
              isSynced: const Value(false),
              createdAt: Value(createdAt),
              updatedAt: Value(createdAt),
              createdBy: Value(fieldWorkerId),
              fieldWorkerId: Value(fieldWorkerId),
              syncStatus: const Value(OfflineSyncStatus.pending),
            ),
          );

      await _database
          .into(_database.syncQueue)
          .insert(
            SyncQueueCompanion.insert(
              endpoint: '/dispersals',
              method: 'POST',
              payload: payload,
              status: const Value('pending'),
              syncStatus: const Value(OfflineSyncStatus.pending),
              recordId: Value(normalizedId),
              recordType: const Value(OfflineRecordType.dispersalMonitoring),
              createdBy: Value(fieldWorkerId),
              fieldWorkerId: Value(fieldWorkerId),
              createdAt: Value(createdAt),
              updatedAt: Value(createdAt),
            ),
          );
    });
  }
}
