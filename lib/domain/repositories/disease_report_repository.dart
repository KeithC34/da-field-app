import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';

import '../../core/sync/offline_record_type.dart';
import '../../core/sync/offline_sync_status.dart';
import '../../data/local/database/app_database.dart';

class DiseaseReportRepository {
  DiseaseReportRepository(
    this._database, {
    String Function()? fieldWorkerIdProvider,
  }) : _fieldWorkerIdProvider =
           fieldWorkerIdProvider ?? (() => 'test-field-worker');

  final AppDatabase _database;
  final String Function() _fieldWorkerIdProvider;

  Future<void> reportDisease(
    String id,
    String pigId,
    String symptoms,
    double latitude,
    double longitude,
    String photoPath,
  ) async {
    final normalizedId = id.trim();
    final normalizedPigId = pigId.trim();
    final normalizedSymptoms = symptoms.trim();
    final normalizedPhotoPath = photoPath.trim();

    if (normalizedId.isEmpty) {
      throw ArgumentError.value(id, 'id', 'Disease report ID is required.');
    }
    if (normalizedPigId.isEmpty) {
      throw ArgumentError.value(pigId, 'pigId', 'Pig ID is required.');
    }
    if (normalizedSymptoms.isEmpty) {
      throw ArgumentError.value(symptoms, 'symptoms', 'Symptoms are required.');
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
        'A disease report photo is required.',
      );
    }
    if (!await File(normalizedPhotoPath).exists()) {
      throw ArgumentError.value(
        photoPath,
        'photoPath',
        'The disease report photo could not be found.',
      );
    }

    final createdAt = DateTime.now().toUtc();
    final fieldWorkerId = _fieldWorkerIdProvider().trim();
    final payload = jsonEncode({
      'disease_id': normalizedId,
      'pig_id': normalizedPigId,
      'symptoms': normalizedSymptoms,
      'latitude': latitude,
      'longitude': longitude,
      'photoPath': normalizedPhotoPath,
    });

    await _database.transaction(() async {
      await _database
          .into(_database.diseaseReports)
          .insert(
            DiseaseReportsCompanion.insert(
              id: normalizedId,
              pigId: normalizedPigId,
              symptoms: normalizedSymptoms,
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
              endpoint: '/disease-reports',
              method: 'POST_MULTIPART',
              payload: payload,
              status: const Value('pending'),
              syncStatus: const Value(OfflineSyncStatus.pending),
              recordId: Value(normalizedId),
              recordType: const Value(OfflineRecordType.diseaseReport),
              createdBy: Value(fieldWorkerId),
              fieldWorkerId: Value(fieldWorkerId),
              createdAt: Value(createdAt),
              updatedAt: Value(createdAt),
            ),
          );
    });
  }
}
