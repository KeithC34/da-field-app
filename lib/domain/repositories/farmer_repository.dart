import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/sync/offline_record_type.dart';
import '../../core/sync/offline_sync_status.dart';
import '../../data/local/database/app_database.dart';

class FarmerRepository {
  FarmerRepository(this._database, {String Function()? fieldWorkerIdProvider})
    : _fieldWorkerIdProvider =
          fieldWorkerIdProvider ?? (() => 'test-field-worker');

  final AppDatabase _database;
  final String Function() _fieldWorkerIdProvider;

  Future<void> registerFarmer(
    String id,
    String fullName,
    String contactNumber,
    double latitude,
    double longitude,
  ) async {
    final normalizedId = id.trim();
    final normalizedFullName = fullName.trim();
    final normalizedContactNumber = contactNumber.trim();

    if (normalizedId.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Farmer ID must not be empty.');
    }
    if (normalizedFullName.isEmpty) {
      throw ArgumentError.value(
        fullName,
        'fullName',
        'Full name must not be empty.',
      );
    }
    if (normalizedContactNumber.isEmpty) {
      throw ArgumentError.value(
        contactNumber,
        'contactNumber',
        'Contact number must not be empty.',
      );
    }
    if (!latitude.isFinite || latitude < -90 || latitude > 90) {
      throw ArgumentError.value(
        latitude,
        'latitude',
        'Latitude must be between -90 and 90.',
      );
    }
    if (!longitude.isFinite || longitude < -180 || longitude > 180) {
      throw ArgumentError.value(
        longitude,
        'longitude',
        'Longitude must be between -180 and 180.',
      );
    }

    final createdAt = DateTime.now().toUtc();
    final fieldWorkerId = _fieldWorkerIdProvider().trim();
    final payload = jsonEncode({
      'farmer_id': normalizedId,
      'full_name': normalizedFullName,
      'contact_number': normalizedContactNumber,
      'location': {
        'type': 'Point',
        'coordinates': [longitude, latitude],
      },
    });

    await _database.transaction(() async {
      await _database
          .into(_database.farmers)
          .insert(
            FarmersCompanion.insert(
              id: normalizedId,
              fullName: normalizedFullName,
              contactNumber: normalizedContactNumber,
              latitude: latitude,
              longitude: longitude,
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
              endpoint: '/pig-farmers',
              method: 'POST',
              payload: payload,
              status: const Value('pending'),
              syncStatus: const Value(OfflineSyncStatus.pending),
              recordId: Value(normalizedId),
              recordType: const Value(OfflineRecordType.farmer),
              createdBy: Value(fieldWorkerId),
              fieldWorkerId: Value(fieldWorkerId),
              createdAt: Value(createdAt),
              updatedAt: Value(createdAt),
            ),
          );
    });
  }
}
