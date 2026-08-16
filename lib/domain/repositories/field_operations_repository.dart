import '../../core/sync/offline_record_type.dart';
import 'offline_record_repository.dart';

/// Validates and delegates the Phase 21.5 operations to the shared durable
/// offline record and sync queue implementation.
class FieldOperationsRepository {
  FieldOperationsRepository(this._offlineRecords);

  final OfflineRecordRepository _offlineRecords;

  Future<String> saveOperation({
    required String recordType,
    required Map<String, dynamic> payload,
    required double latitude,
    required double longitude,
    List<String> photoPaths = const [],
    String? id,
  }) {
    final endpoint = switch (recordType) {
      OfflineRecordType.piglet => '/piglets',
      OfflineRecordType.wasteInspection => '/waste-compliance-records',
      OfflineRecordType.wastewaterInspection => '/wastewater-discharge',
      OfflineRecordType.returnPigletVerification => '/return-piglets',
      OfflineRecordType.fieldVerification => '/field-verifications',
      _ => throw ArgumentError.value(recordType, 'recordType', 'Unsupported field operation.'),
    };
    final operationPayload = <String, dynamic>{
      ...payload,
      'location': payload['location'] ?? {
        'latitude': latitude,
        'longitude': longitude,
      },
    };
    return _offlineRecords.saveRecord(
      recordType: recordType,
      payload: operationPayload,
      endpoint: endpoint,
      method: 'POST',
      latitude: latitude,
      longitude: longitude,
      photoPaths: photoPaths,
      id: id,
    );
  }
}
