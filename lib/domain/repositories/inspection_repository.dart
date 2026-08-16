import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';

import '../../core/sync/offline_record_type.dart';
import '../../core/sync/offline_sync_status.dart';
import '../../data/local/database/app_database.dart';

class InspectionRepository {
  InspectionRepository(
    this._database, {
    String Function()? fieldWorkerIdProvider,
  }) : _fieldWorkerIdProvider =
           fieldWorkerIdProvider ?? (() => 'test-field-worker');

  final AppDatabase _database;
  final String Function() _fieldWorkerIdProvider;

  Future<void> submitInspection(
    String id,
    String penId,
    bool wasteManagementCompliant,
    double wastewaterPh,
    double coliformLevel,
    double latitude,
    double longitude,
    String photoPath,
  ) async {
    final normalizedId = id.trim();
    final normalizedPenId = penId.trim();
    final normalizedPhotoPath = photoPath.trim();

    if (normalizedId.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Inspection ID is required.');
    }
    if (normalizedPenId.isEmpty) {
      throw ArgumentError.value(penId, 'penId', 'Pen ID is required.');
    }
    if (!wastewaterPh.isFinite || wastewaterPh < 0 || wastewaterPh > 14) {
      throw ArgumentError.value(
        wastewaterPh,
        'wastewaterPh',
        'Wastewater pH must be between 0 and 14.',
      );
    }
    if (!coliformLevel.isFinite || coliformLevel < 0) {
      throw ArgumentError.value(
        coliformLevel,
        'coliformLevel',
        'Coliform level must be zero or greater.',
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
    if (normalizedPhotoPath.isEmpty) {
      throw ArgumentError.value(
        photoPath,
        'photoPath',
        'An inspection photo is required.',
      );
    }
    if (!await File(normalizedPhotoPath).exists()) {
      throw ArgumentError.value(
        photoPath,
        'photoPath',
        'The inspection photo could not be found.',
      );
    }

    final createdAt = DateTime.now().toUtc();
    final fieldWorkerId = _fieldWorkerIdProvider().trim();
    final payload = jsonEncode({
      'inspection_id': normalizedId,
      'pen_id': normalizedPenId,
      'waste_management_compliant': wasteManagementCompliant,
      'wastewater_ph': wastewaterPh,
      'coliform_level': coliformLevel,
      'latitude': latitude,
      'longitude': longitude,
      'photoPath': normalizedPhotoPath,
    });

    await _database.transaction(() async {
      await _database
          .into(_database.inspections)
          .insert(
            InspectionsCompanion.insert(
              id: normalizedId,
              penId: normalizedPenId,
              wasteManagementCompliant: wasteManagementCompliant,
              wastewaterPh: wastewaterPh,
              coliformLevel: coliformLevel,
              latitude: latitude,
              longitude: longitude,
              photoPath: normalizedPhotoPath,
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
              endpoint: '/inspections',
              method: 'POST_MULTIPART',
              payload: payload,
              status: const Value('pending'),
              syncStatus: const Value(OfflineSyncStatus.pending),
              recordId: Value(normalizedId),
              recordType: const Value(OfflineRecordType.inspection),
              createdBy: Value(fieldWorkerId),
              fieldWorkerId: Value(fieldWorkerId),
              createdAt: Value(createdAt),
              updatedAt: Value(createdAt),
            ),
          );
    });
  }
}
