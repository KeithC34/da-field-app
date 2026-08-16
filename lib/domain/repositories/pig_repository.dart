import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/sync/offline_record_type.dart';
import '../../core/sync/offline_sync_status.dart';
import '../../data/local/database/app_database.dart';

class PigRepository {
  PigRepository(this._database, {String Function()? fieldWorkerIdProvider})
    : _fieldWorkerIdProvider =
          fieldWorkerIdProvider ?? (() => 'test-field-worker');

  final AppDatabase _database;
  final String Function() _fieldWorkerIdProvider;

  Future<void> registerPig(
    String id,
    String farmerId,
    String penId,
    String breed,
    double weight,
  ) async {
    final normalizedId = id.trim();
    final normalizedFarmerId = farmerId.trim();
    final normalizedPenId = penId.trim();
    final normalizedBreed = breed.trim();

    if (normalizedId.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Pig ID is required.');
    }
    if (normalizedFarmerId.isEmpty) {
      throw ArgumentError.value(farmerId, 'farmerId', 'Farmer ID is required.');
    }
    if (normalizedPenId.isEmpty) {
      throw ArgumentError.value(penId, 'penId', 'Pen ID is required.');
    }
    if (normalizedBreed.isEmpty) {
      throw ArgumentError.value(breed, 'breed', 'Breed is required.');
    }
    if (!weight.isFinite || weight <= 0) {
      throw ArgumentError.value(
        weight,
        'weight',
        'Weight must be greater than zero.',
      );
    }

    final createdAt = DateTime.now().toUtc();
    final fieldWorkerId = _fieldWorkerIdProvider().trim();
    final payload = jsonEncode({
      'pig_id': normalizedId,
      'farmer_id': normalizedFarmerId,
      'pen_id': normalizedPenId,
      'breed': normalizedBreed,
      'weight': weight,
    });

    await _database.transaction(() async {
      await _database
          .into(_database.pigs)
          .insert(
            PigsCompanion.insert(
              id: normalizedId,
              farmerId: normalizedFarmerId,
              penId: normalizedPenId,
              breed: normalizedBreed,
              weight: weight,
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
              endpoint: '/pigs',
              method: 'POST',
              payload: payload,
              status: const Value('pending'),
              syncStatus: const Value(OfflineSyncStatus.pending),
              recordId: Value(normalizedId),
              recordType: const Value(OfflineRecordType.pig),
              createdBy: Value(fieldWorkerId),
              fieldWorkerId: Value(fieldWorkerId),
              createdAt: Value(createdAt),
              updatedAt: Value(createdAt),
            ),
          );
    });
  }
}
