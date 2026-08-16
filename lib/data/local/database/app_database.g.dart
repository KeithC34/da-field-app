// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FarmersTable extends Farmers with TableInfo<$FarmersTable, Farmer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FarmersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactNumberMeta = const VerificationMeta(
    'contactNumber',
  );
  @override
  late final GeneratedColumn<String> contactNumber = GeneratedColumn<String>(
    'contact_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('legacy'),
  );
  static const VerificationMeta _fieldWorkerIdMeta = const VerificationMeta(
    'fieldWorkerId',
  );
  @override
  late final GeneratedColumn<String> fieldWorkerId = GeneratedColumn<String>(
    'field_worker_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('legacy'),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fullName,
    contactNumber,
    latitude,
    longitude,
    isSynced,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'farmers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Farmer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('contact_number')) {
      context.handle(
        _contactNumberMeta,
        contactNumber.isAcceptableOrUnknown(
          data['contact_number']!,
          _contactNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactNumberMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('field_worker_id')) {
      context.handle(
        _fieldWorkerIdMeta,
        fieldWorkerId.isAcceptableOrUnknown(
          data['field_worker_id']!,
          _fieldWorkerIdMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Farmer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Farmer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      contactNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_number'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      fieldWorkerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_worker_id'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $FarmersTable createAlias(String alias) {
    return $FarmersTable(attachedDatabase, alias);
  }
}

class Farmer extends DataClass implements Insertable<Farmer> {
  final String id;
  final String fullName;
  final String contactNumber;
  final double latitude;
  final double longitude;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String fieldWorkerId;
  final String syncStatus;
  const Farmer({
    required this.id,
    required this.fullName,
    required this.contactNumber,
    required this.latitude,
    required this.longitude,
    required this.isSynced,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.fieldWorkerId,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['full_name'] = Variable<String>(fullName);
    map['contact_number'] = Variable<String>(contactNumber);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['is_synced'] = Variable<bool>(isSynced);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_by'] = Variable<String>(createdBy);
    map['field_worker_id'] = Variable<String>(fieldWorkerId);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  FarmersCompanion toCompanion(bool nullToAbsent) {
    return FarmersCompanion(
      id: Value(id),
      fullName: Value(fullName),
      contactNumber: Value(contactNumber),
      latitude: Value(latitude),
      longitude: Value(longitude),
      isSynced: Value(isSynced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      createdBy: Value(createdBy),
      fieldWorkerId: Value(fieldWorkerId),
      syncStatus: Value(syncStatus),
    );
  }

  factory Farmer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Farmer(
      id: serializer.fromJson<String>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      contactNumber: serializer.fromJson<String>(json['contactNumber']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      fieldWorkerId: serializer.fromJson<String>(json['fieldWorkerId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fullName': serializer.toJson<String>(fullName),
      'contactNumber': serializer.toJson<String>(contactNumber),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'isSynced': serializer.toJson<bool>(isSynced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdBy': serializer.toJson<String>(createdBy),
      'fieldWorkerId': serializer.toJson<String>(fieldWorkerId),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  Farmer copyWith({
    String? id,
    String? fullName,
    String? contactNumber,
    double? latitude,
    double? longitude,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? fieldWorkerId,
    String? syncStatus,
  }) => Farmer(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    contactNumber: contactNumber ?? this.contactNumber,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    isSynced: isSynced ?? this.isSynced,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    createdBy: createdBy ?? this.createdBy,
    fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  Farmer copyWithCompanion(FarmersCompanion data) {
    return Farmer(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      contactNumber: data.contactNumber.present
          ? data.contactNumber.value
          : this.contactNumber,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      fieldWorkerId: data.fieldWorkerId.present
          ? data.fieldWorkerId.value
          : this.fieldWorkerId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Farmer(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fullName,
    contactNumber,
    latitude,
    longitude,
    isSynced,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Farmer &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.contactNumber == this.contactNumber &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.isSynced == this.isSynced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.createdBy == this.createdBy &&
          other.fieldWorkerId == this.fieldWorkerId &&
          other.syncStatus == this.syncStatus);
}

class FarmersCompanion extends UpdateCompanion<Farmer> {
  final Value<String> id;
  final Value<String> fullName;
  final Value<String> contactNumber;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<bool> isSynced;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> createdBy;
  final Value<String> fieldWorkerId;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const FarmersCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.contactNumber = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FarmersCompanion.insert({
    required String id,
    required String fullName,
    required String contactNumber,
    required double latitude,
    required double longitude,
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fullName = Value(fullName),
       contactNumber = Value(contactNumber),
       latitude = Value(latitude),
       longitude = Value(longitude);
  static Insertable<Farmer> custom({
    Expression<String>? id,
    Expression<String>? fullName,
    Expression<String>? contactNumber,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<bool>? isSynced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? createdBy,
    Expression<String>? fieldWorkerId,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (contactNumber != null) 'contact_number': contactNumber,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdBy != null) 'created_by': createdBy,
      if (fieldWorkerId != null) 'field_worker_id': fieldWorkerId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FarmersCompanion copyWith({
    Value<String>? id,
    Value<String>? fullName,
    Value<String>? contactNumber,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<bool>? isSynced,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? createdBy,
    Value<String>? fieldWorkerId,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return FarmersCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      contactNumber: contactNumber ?? this.contactNumber,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (contactNumber.present) {
      map['contact_number'] = Variable<String>(contactNumber.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (fieldWorkerId.present) {
      map['field_worker_id'] = Variable<String>(fieldWorkerId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FarmersCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DiseaseReportsTable extends DiseaseReports
    with TableInfo<$DiseaseReportsTable, DiseaseReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiseaseReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pigIdMeta = const VerificationMeta('pigId');
  @override
  late final GeneratedColumn<String> pigId = GeneratedColumn<String>(
    'pig_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symptomsMeta = const VerificationMeta(
    'symptoms',
  );
  @override
  late final GeneratedColumn<String> symptoms = GeneratedColumn<String>(
    'symptoms',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('legacy'),
  );
  static const VerificationMeta _fieldWorkerIdMeta = const VerificationMeta(
    'fieldWorkerId',
  );
  @override
  late final GeneratedColumn<String> fieldWorkerId = GeneratedColumn<String>(
    'field_worker_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('legacy'),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pigId,
    symptoms,
    latitude,
    longitude,
    photoPath,
    isSynced,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'disease_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiseaseReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pig_id')) {
      context.handle(
        _pigIdMeta,
        pigId.isAcceptableOrUnknown(data['pig_id']!, _pigIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pigIdMeta);
    }
    if (data.containsKey('symptoms')) {
      context.handle(
        _symptomsMeta,
        symptoms.isAcceptableOrUnknown(data['symptoms']!, _symptomsMeta),
      );
    } else if (isInserting) {
      context.missing(_symptomsMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    } else if (isInserting) {
      context.missing(_photoPathMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('field_worker_id')) {
      context.handle(
        _fieldWorkerIdMeta,
        fieldWorkerId.isAcceptableOrUnknown(
          data['field_worker_id']!,
          _fieldWorkerIdMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiseaseReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiseaseReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pigId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pig_id'],
      )!,
      symptoms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptoms'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      fieldWorkerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_worker_id'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $DiseaseReportsTable createAlias(String alias) {
    return $DiseaseReportsTable(attachedDatabase, alias);
  }
}

class DiseaseReport extends DataClass implements Insertable<DiseaseReport> {
  final String id;
  final String pigId;
  final String symptoms;
  final double latitude;
  final double longitude;
  final String photoPath;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String fieldWorkerId;
  final String syncStatus;
  const DiseaseReport({
    required this.id,
    required this.pigId,
    required this.symptoms,
    required this.latitude,
    required this.longitude,
    required this.photoPath,
    required this.isSynced,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.fieldWorkerId,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pig_id'] = Variable<String>(pigId);
    map['symptoms'] = Variable<String>(symptoms);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['photo_path'] = Variable<String>(photoPath);
    map['is_synced'] = Variable<bool>(isSynced);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_by'] = Variable<String>(createdBy);
    map['field_worker_id'] = Variable<String>(fieldWorkerId);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  DiseaseReportsCompanion toCompanion(bool nullToAbsent) {
    return DiseaseReportsCompanion(
      id: Value(id),
      pigId: Value(pigId),
      symptoms: Value(symptoms),
      latitude: Value(latitude),
      longitude: Value(longitude),
      photoPath: Value(photoPath),
      isSynced: Value(isSynced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      createdBy: Value(createdBy),
      fieldWorkerId: Value(fieldWorkerId),
      syncStatus: Value(syncStatus),
    );
  }

  factory DiseaseReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiseaseReport(
      id: serializer.fromJson<String>(json['id']),
      pigId: serializer.fromJson<String>(json['pigId']),
      symptoms: serializer.fromJson<String>(json['symptoms']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      photoPath: serializer.fromJson<String>(json['photoPath']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      fieldWorkerId: serializer.fromJson<String>(json['fieldWorkerId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pigId': serializer.toJson<String>(pigId),
      'symptoms': serializer.toJson<String>(symptoms),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'photoPath': serializer.toJson<String>(photoPath),
      'isSynced': serializer.toJson<bool>(isSynced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdBy': serializer.toJson<String>(createdBy),
      'fieldWorkerId': serializer.toJson<String>(fieldWorkerId),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  DiseaseReport copyWith({
    String? id,
    String? pigId,
    String? symptoms,
    double? latitude,
    double? longitude,
    String? photoPath,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? fieldWorkerId,
    String? syncStatus,
  }) => DiseaseReport(
    id: id ?? this.id,
    pigId: pigId ?? this.pigId,
    symptoms: symptoms ?? this.symptoms,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    photoPath: photoPath ?? this.photoPath,
    isSynced: isSynced ?? this.isSynced,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    createdBy: createdBy ?? this.createdBy,
    fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  DiseaseReport copyWithCompanion(DiseaseReportsCompanion data) {
    return DiseaseReport(
      id: data.id.present ? data.id.value : this.id,
      pigId: data.pigId.present ? data.pigId.value : this.pigId,
      symptoms: data.symptoms.present ? data.symptoms.value : this.symptoms,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      fieldWorkerId: data.fieldWorkerId.present
          ? data.fieldWorkerId.value
          : this.fieldWorkerId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiseaseReport(')
          ..write('id: $id, ')
          ..write('pigId: $pigId, ')
          ..write('symptoms: $symptoms, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('photoPath: $photoPath, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pigId,
    symptoms,
    latitude,
    longitude,
    photoPath,
    isSynced,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiseaseReport &&
          other.id == this.id &&
          other.pigId == this.pigId &&
          other.symptoms == this.symptoms &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.photoPath == this.photoPath &&
          other.isSynced == this.isSynced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.createdBy == this.createdBy &&
          other.fieldWorkerId == this.fieldWorkerId &&
          other.syncStatus == this.syncStatus);
}

class DiseaseReportsCompanion extends UpdateCompanion<DiseaseReport> {
  final Value<String> id;
  final Value<String> pigId;
  final Value<String> symptoms;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> photoPath;
  final Value<bool> isSynced;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> createdBy;
  final Value<String> fieldWorkerId;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const DiseaseReportsCompanion({
    this.id = const Value.absent(),
    this.pigId = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiseaseReportsCompanion.insert({
    required String id,
    required String pigId,
    required String symptoms,
    required double latitude,
    required double longitude,
    required String photoPath,
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pigId = Value(pigId),
       symptoms = Value(symptoms),
       latitude = Value(latitude),
       longitude = Value(longitude),
       photoPath = Value(photoPath);
  static Insertable<DiseaseReport> custom({
    Expression<String>? id,
    Expression<String>? pigId,
    Expression<String>? symptoms,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? photoPath,
    Expression<bool>? isSynced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? createdBy,
    Expression<String>? fieldWorkerId,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pigId != null) 'pig_id': pigId,
      if (symptoms != null) 'symptoms': symptoms,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (photoPath != null) 'photo_path': photoPath,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdBy != null) 'created_by': createdBy,
      if (fieldWorkerId != null) 'field_worker_id': fieldWorkerId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiseaseReportsCompanion copyWith({
    Value<String>? id,
    Value<String>? pigId,
    Value<String>? symptoms,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String>? photoPath,
    Value<bool>? isSynced,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? createdBy,
    Value<String>? fieldWorkerId,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return DiseaseReportsCompanion(
      id: id ?? this.id,
      pigId: pigId ?? this.pigId,
      symptoms: symptoms ?? this.symptoms,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      photoPath: photoPath ?? this.photoPath,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pigId.present) {
      map['pig_id'] = Variable<String>(pigId.value);
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<String>(symptoms.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (fieldWorkerId.present) {
      map['field_worker_id'] = Variable<String>(fieldWorkerId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiseaseReportsCompanion(')
          ..write('id: $id, ')
          ..write('pigId: $pigId, ')
          ..write('symptoms: $symptoms, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('photoPath: $photoPath, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InspectionsTable extends Inspections
    with TableInfo<$InspectionsTable, Inspection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _penIdMeta = const VerificationMeta('penId');
  @override
  late final GeneratedColumn<String> penId = GeneratedColumn<String>(
    'pen_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wasteManagementCompliantMeta =
      const VerificationMeta('wasteManagementCompliant');
  @override
  late final GeneratedColumn<bool> wasteManagementCompliant =
      GeneratedColumn<bool>(
        'waste_management_compliant',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("waste_management_compliant" IN (0, 1))',
        ),
      );
  static const VerificationMeta _wastewaterPhMeta = const VerificationMeta(
    'wastewaterPh',
  );
  @override
  late final GeneratedColumn<double> wastewaterPh = GeneratedColumn<double>(
    'wastewater_ph',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coliformLevelMeta = const VerificationMeta(
    'coliformLevel',
  );
  @override
  late final GeneratedColumn<double> coliformLevel = GeneratedColumn<double>(
    'coliform_level',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('legacy'),
  );
  static const VerificationMeta _fieldWorkerIdMeta = const VerificationMeta(
    'fieldWorkerId',
  );
  @override
  late final GeneratedColumn<String> fieldWorkerId = GeneratedColumn<String>(
    'field_worker_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('legacy'),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    penId,
    wasteManagementCompliant,
    wastewaterPh,
    coliformLevel,
    latitude,
    longitude,
    photoPath,
    isSynced,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspections';
  @override
  VerificationContext validateIntegrity(
    Insertable<Inspection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pen_id')) {
      context.handle(
        _penIdMeta,
        penId.isAcceptableOrUnknown(data['pen_id']!, _penIdMeta),
      );
    } else if (isInserting) {
      context.missing(_penIdMeta);
    }
    if (data.containsKey('waste_management_compliant')) {
      context.handle(
        _wasteManagementCompliantMeta,
        wasteManagementCompliant.isAcceptableOrUnknown(
          data['waste_management_compliant']!,
          _wasteManagementCompliantMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wasteManagementCompliantMeta);
    }
    if (data.containsKey('wastewater_ph')) {
      context.handle(
        _wastewaterPhMeta,
        wastewaterPh.isAcceptableOrUnknown(
          data['wastewater_ph']!,
          _wastewaterPhMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wastewaterPhMeta);
    }
    if (data.containsKey('coliform_level')) {
      context.handle(
        _coliformLevelMeta,
        coliformLevel.isAcceptableOrUnknown(
          data['coliform_level']!,
          _coliformLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coliformLevelMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    } else if (isInserting) {
      context.missing(_photoPathMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('field_worker_id')) {
      context.handle(
        _fieldWorkerIdMeta,
        fieldWorkerId.isAcceptableOrUnknown(
          data['field_worker_id']!,
          _fieldWorkerIdMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Inspection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Inspection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      penId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pen_id'],
      )!,
      wasteManagementCompliant: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}waste_management_compliant'],
      )!,
      wastewaterPh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wastewater_ph'],
      )!,
      coliformLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}coliform_level'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      fieldWorkerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_worker_id'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $InspectionsTable createAlias(String alias) {
    return $InspectionsTable(attachedDatabase, alias);
  }
}

class Inspection extends DataClass implements Insertable<Inspection> {
  final String id;
  final String penId;
  final bool wasteManagementCompliant;
  final double wastewaterPh;
  final double coliformLevel;
  final double latitude;
  final double longitude;
  final String photoPath;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String fieldWorkerId;
  final String syncStatus;
  const Inspection({
    required this.id,
    required this.penId,
    required this.wasteManagementCompliant,
    required this.wastewaterPh,
    required this.coliformLevel,
    required this.latitude,
    required this.longitude,
    required this.photoPath,
    required this.isSynced,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.fieldWorkerId,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pen_id'] = Variable<String>(penId);
    map['waste_management_compliant'] = Variable<bool>(
      wasteManagementCompliant,
    );
    map['wastewater_ph'] = Variable<double>(wastewaterPh);
    map['coliform_level'] = Variable<double>(coliformLevel);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['photo_path'] = Variable<String>(photoPath);
    map['is_synced'] = Variable<bool>(isSynced);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_by'] = Variable<String>(createdBy);
    map['field_worker_id'] = Variable<String>(fieldWorkerId);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  InspectionsCompanion toCompanion(bool nullToAbsent) {
    return InspectionsCompanion(
      id: Value(id),
      penId: Value(penId),
      wasteManagementCompliant: Value(wasteManagementCompliant),
      wastewaterPh: Value(wastewaterPh),
      coliformLevel: Value(coliformLevel),
      latitude: Value(latitude),
      longitude: Value(longitude),
      photoPath: Value(photoPath),
      isSynced: Value(isSynced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      createdBy: Value(createdBy),
      fieldWorkerId: Value(fieldWorkerId),
      syncStatus: Value(syncStatus),
    );
  }

  factory Inspection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Inspection(
      id: serializer.fromJson<String>(json['id']),
      penId: serializer.fromJson<String>(json['penId']),
      wasteManagementCompliant: serializer.fromJson<bool>(
        json['wasteManagementCompliant'],
      ),
      wastewaterPh: serializer.fromJson<double>(json['wastewaterPh']),
      coliformLevel: serializer.fromJson<double>(json['coliformLevel']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      photoPath: serializer.fromJson<String>(json['photoPath']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      fieldWorkerId: serializer.fromJson<String>(json['fieldWorkerId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'penId': serializer.toJson<String>(penId),
      'wasteManagementCompliant': serializer.toJson<bool>(
        wasteManagementCompliant,
      ),
      'wastewaterPh': serializer.toJson<double>(wastewaterPh),
      'coliformLevel': serializer.toJson<double>(coliformLevel),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'photoPath': serializer.toJson<String>(photoPath),
      'isSynced': serializer.toJson<bool>(isSynced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdBy': serializer.toJson<String>(createdBy),
      'fieldWorkerId': serializer.toJson<String>(fieldWorkerId),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  Inspection copyWith({
    String? id,
    String? penId,
    bool? wasteManagementCompliant,
    double? wastewaterPh,
    double? coliformLevel,
    double? latitude,
    double? longitude,
    String? photoPath,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? fieldWorkerId,
    String? syncStatus,
  }) => Inspection(
    id: id ?? this.id,
    penId: penId ?? this.penId,
    wasteManagementCompliant:
        wasteManagementCompliant ?? this.wasteManagementCompliant,
    wastewaterPh: wastewaterPh ?? this.wastewaterPh,
    coliformLevel: coliformLevel ?? this.coliformLevel,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    photoPath: photoPath ?? this.photoPath,
    isSynced: isSynced ?? this.isSynced,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    createdBy: createdBy ?? this.createdBy,
    fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  Inspection copyWithCompanion(InspectionsCompanion data) {
    return Inspection(
      id: data.id.present ? data.id.value : this.id,
      penId: data.penId.present ? data.penId.value : this.penId,
      wasteManagementCompliant: data.wasteManagementCompliant.present
          ? data.wasteManagementCompliant.value
          : this.wasteManagementCompliant,
      wastewaterPh: data.wastewaterPh.present
          ? data.wastewaterPh.value
          : this.wastewaterPh,
      coliformLevel: data.coliformLevel.present
          ? data.coliformLevel.value
          : this.coliformLevel,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      fieldWorkerId: data.fieldWorkerId.present
          ? data.fieldWorkerId.value
          : this.fieldWorkerId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Inspection(')
          ..write('id: $id, ')
          ..write('penId: $penId, ')
          ..write('wasteManagementCompliant: $wasteManagementCompliant, ')
          ..write('wastewaterPh: $wastewaterPh, ')
          ..write('coliformLevel: $coliformLevel, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('photoPath: $photoPath, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    penId,
    wasteManagementCompliant,
    wastewaterPh,
    coliformLevel,
    latitude,
    longitude,
    photoPath,
    isSynced,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Inspection &&
          other.id == this.id &&
          other.penId == this.penId &&
          other.wasteManagementCompliant == this.wasteManagementCompliant &&
          other.wastewaterPh == this.wastewaterPh &&
          other.coliformLevel == this.coliformLevel &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.photoPath == this.photoPath &&
          other.isSynced == this.isSynced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.createdBy == this.createdBy &&
          other.fieldWorkerId == this.fieldWorkerId &&
          other.syncStatus == this.syncStatus);
}

class InspectionsCompanion extends UpdateCompanion<Inspection> {
  final Value<String> id;
  final Value<String> penId;
  final Value<bool> wasteManagementCompliant;
  final Value<double> wastewaterPh;
  final Value<double> coliformLevel;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> photoPath;
  final Value<bool> isSynced;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> createdBy;
  final Value<String> fieldWorkerId;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const InspectionsCompanion({
    this.id = const Value.absent(),
    this.penId = const Value.absent(),
    this.wasteManagementCompliant = const Value.absent(),
    this.wastewaterPh = const Value.absent(),
    this.coliformLevel = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InspectionsCompanion.insert({
    required String id,
    required String penId,
    required bool wasteManagementCompliant,
    required double wastewaterPh,
    required double coliformLevel,
    required double latitude,
    required double longitude,
    required String photoPath,
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       penId = Value(penId),
       wasteManagementCompliant = Value(wasteManagementCompliant),
       wastewaterPh = Value(wastewaterPh),
       coliformLevel = Value(coliformLevel),
       latitude = Value(latitude),
       longitude = Value(longitude),
       photoPath = Value(photoPath);
  static Insertable<Inspection> custom({
    Expression<String>? id,
    Expression<String>? penId,
    Expression<bool>? wasteManagementCompliant,
    Expression<double>? wastewaterPh,
    Expression<double>? coliformLevel,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? photoPath,
    Expression<bool>? isSynced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? createdBy,
    Expression<String>? fieldWorkerId,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (penId != null) 'pen_id': penId,
      if (wasteManagementCompliant != null)
        'waste_management_compliant': wasteManagementCompliant,
      if (wastewaterPh != null) 'wastewater_ph': wastewaterPh,
      if (coliformLevel != null) 'coliform_level': coliformLevel,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (photoPath != null) 'photo_path': photoPath,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdBy != null) 'created_by': createdBy,
      if (fieldWorkerId != null) 'field_worker_id': fieldWorkerId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InspectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? penId,
    Value<bool>? wasteManagementCompliant,
    Value<double>? wastewaterPh,
    Value<double>? coliformLevel,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String>? photoPath,
    Value<bool>? isSynced,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? createdBy,
    Value<String>? fieldWorkerId,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return InspectionsCompanion(
      id: id ?? this.id,
      penId: penId ?? this.penId,
      wasteManagementCompliant:
          wasteManagementCompliant ?? this.wasteManagementCompliant,
      wastewaterPh: wastewaterPh ?? this.wastewaterPh,
      coliformLevel: coliformLevel ?? this.coliformLevel,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      photoPath: photoPath ?? this.photoPath,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (penId.present) {
      map['pen_id'] = Variable<String>(penId.value);
    }
    if (wasteManagementCompliant.present) {
      map['waste_management_compliant'] = Variable<bool>(
        wasteManagementCompliant.value,
      );
    }
    if (wastewaterPh.present) {
      map['wastewater_ph'] = Variable<double>(wastewaterPh.value);
    }
    if (coliformLevel.present) {
      map['coliform_level'] = Variable<double>(coliformLevel.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (fieldWorkerId.present) {
      map['field_worker_id'] = Variable<String>(fieldWorkerId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspectionsCompanion(')
          ..write('id: $id, ')
          ..write('penId: $penId, ')
          ..write('wasteManagementCompliant: $wasteManagementCompliant, ')
          ..write('wastewaterPh: $wastewaterPh, ')
          ..write('coliformLevel: $coliformLevel, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('photoPath: $photoPath, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('normal'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relatedRecordIdMeta = const VerificationMeta(
    'relatedRecordId',
  );
  @override
  late final GeneratedColumn<String> relatedRecordId = GeneratedColumn<String>(
    'related_record_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relatedRecordTypeMeta = const VerificationMeta(
    'relatedRecordType',
  );
  @override
  late final GeneratedColumn<String> relatedRecordType =
      GeneratedColumn<String>(
        'related_record_type',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _readAtMeta = const VerificationMeta('readAt');
  @override
  late final GeneratedColumn<DateTime> readAt = GeneratedColumn<DateTime>(
    'read_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    category,
    priority,
    title,
    message,
    relatedRecordId,
    relatedRecordType,
    isRead,
    readAt,
    createdAt,
    scheduledAt,
    syncStatus,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<Notification> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('related_record_id')) {
      context.handle(
        _relatedRecordIdMeta,
        relatedRecordId.isAcceptableOrUnknown(
          data['related_record_id']!,
          _relatedRecordIdMeta,
        ),
      );
    }
    if (data.containsKey('related_record_type')) {
      context.handle(
        _relatedRecordTypeMeta,
        relatedRecordType.isAcceptableOrUnknown(
          data['related_record_type']!,
          _relatedRecordTypeMeta,
        ),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('read_at')) {
      context.handle(
        _readAtMeta,
        readAt.isAcceptableOrUnknown(data['read_at']!, _readAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      relatedRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_record_id'],
      ),
      relatedRecordType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_record_type'],
      ),
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      readAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}read_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final String id;
  final String category;
  final String priority;
  final String title;
  final String message;
  final String? relatedRecordId;
  final String? relatedRecordType;
  final bool isRead;
  final DateTime? readAt;
  final DateTime createdAt;
  final DateTime? scheduledAt;
  final String syncStatus;
  final String? lastError;
  const Notification({
    required this.id,
    required this.category,
    required this.priority,
    required this.title,
    required this.message,
    this.relatedRecordId,
    this.relatedRecordType,
    required this.isRead,
    this.readAt,
    required this.createdAt,
    this.scheduledAt,
    required this.syncStatus,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category'] = Variable<String>(category);
    map['priority'] = Variable<String>(priority);
    map['title'] = Variable<String>(title);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || relatedRecordId != null) {
      map['related_record_id'] = Variable<String>(relatedRecordId);
    }
    if (!nullToAbsent || relatedRecordType != null) {
      map['related_record_type'] = Variable<String>(relatedRecordType);
    }
    map['is_read'] = Variable<bool>(isRead);
    if (!nullToAbsent || readAt != null) {
      map['read_at'] = Variable<DateTime>(readAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || scheduledAt != null) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      category: Value(category),
      priority: Value(priority),
      title: Value(title),
      message: Value(message),
      relatedRecordId: relatedRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedRecordId),
      relatedRecordType: relatedRecordType == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedRecordType),
      isRead: Value(isRead),
      readAt: readAt == null && nullToAbsent
          ? const Value.absent()
          : Value(readAt),
      createdAt: Value(createdAt),
      scheduledAt: scheduledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledAt),
      syncStatus: Value(syncStatus),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory Notification.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<String>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      priority: serializer.fromJson<String>(json['priority']),
      title: serializer.fromJson<String>(json['title']),
      message: serializer.fromJson<String>(json['message']),
      relatedRecordId: serializer.fromJson<String?>(json['relatedRecordId']),
      relatedRecordType: serializer.fromJson<String?>(
        json['relatedRecordType'],
      ),
      isRead: serializer.fromJson<bool>(json['isRead']),
      readAt: serializer.fromJson<DateTime?>(json['readAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      scheduledAt: serializer.fromJson<DateTime?>(json['scheduledAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'category': serializer.toJson<String>(category),
      'priority': serializer.toJson<String>(priority),
      'title': serializer.toJson<String>(title),
      'message': serializer.toJson<String>(message),
      'relatedRecordId': serializer.toJson<String?>(relatedRecordId),
      'relatedRecordType': serializer.toJson<String?>(relatedRecordType),
      'isRead': serializer.toJson<bool>(isRead),
      'readAt': serializer.toJson<DateTime?>(readAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'scheduledAt': serializer.toJson<DateTime?>(scheduledAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  Notification copyWith({
    String? id,
    String? category,
    String? priority,
    String? title,
    String? message,
    Value<String?> relatedRecordId = const Value.absent(),
    Value<String?> relatedRecordType = const Value.absent(),
    bool? isRead,
    Value<DateTime?> readAt = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> scheduledAt = const Value.absent(),
    String? syncStatus,
    Value<String?> lastError = const Value.absent(),
  }) => Notification(
    id: id ?? this.id,
    category: category ?? this.category,
    priority: priority ?? this.priority,
    title: title ?? this.title,
    message: message ?? this.message,
    relatedRecordId: relatedRecordId.present
        ? relatedRecordId.value
        : this.relatedRecordId,
    relatedRecordType: relatedRecordType.present
        ? relatedRecordType.value
        : this.relatedRecordType,
    isRead: isRead ?? this.isRead,
    readAt: readAt.present ? readAt.value : this.readAt,
    createdAt: createdAt ?? this.createdAt,
    scheduledAt: scheduledAt.present ? scheduledAt.value : this.scheduledAt,
    syncStatus: syncStatus ?? this.syncStatus,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  Notification copyWithCompanion(NotificationsCompanion data) {
    return Notification(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      priority: data.priority.present ? data.priority.value : this.priority,
      title: data.title.present ? data.title.value : this.title,
      message: data.message.present ? data.message.value : this.message,
      relatedRecordId: data.relatedRecordId.present
          ? data.relatedRecordId.value
          : this.relatedRecordId,
      relatedRecordType: data.relatedRecordType.present
          ? data.relatedRecordType.value
          : this.relatedRecordType,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      readAt: data.readAt.present ? data.readAt.value : this.readAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('priority: $priority, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('relatedRecordId: $relatedRecordId, ')
          ..write('relatedRecordType: $relatedRecordType, ')
          ..write('isRead: $isRead, ')
          ..write('readAt: $readAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    category,
    priority,
    title,
    message,
    relatedRecordId,
    relatedRecordType,
    isRead,
    readAt,
    createdAt,
    scheduledAt,
    syncStatus,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.category == this.category &&
          other.priority == this.priority &&
          other.title == this.title &&
          other.message == this.message &&
          other.relatedRecordId == this.relatedRecordId &&
          other.relatedRecordType == this.relatedRecordType &&
          other.isRead == this.isRead &&
          other.readAt == this.readAt &&
          other.createdAt == this.createdAt &&
          other.scheduledAt == this.scheduledAt &&
          other.syncStatus == this.syncStatus &&
          other.lastError == this.lastError);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<String> id;
  final Value<String> category;
  final Value<String> priority;
  final Value<String> title;
  final Value<String> message;
  final Value<String?> relatedRecordId;
  final Value<String?> relatedRecordType;
  final Value<bool> isRead;
  final Value<DateTime?> readAt;
  final Value<DateTime> createdAt;
  final Value<DateTime?> scheduledAt;
  final Value<String> syncStatus;
  final Value<String?> lastError;
  final Value<int> rowid;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.priority = const Value.absent(),
    this.title = const Value.absent(),
    this.message = const Value.absent(),
    this.relatedRecordId = const Value.absent(),
    this.relatedRecordType = const Value.absent(),
    this.isRead = const Value.absent(),
    this.readAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationsCompanion.insert({
    required String id,
    this.category = const Value.absent(),
    this.priority = const Value.absent(),
    required String title,
    required String message,
    this.relatedRecordId = const Value.absent(),
    this.relatedRecordType = const Value.absent(),
    this.isRead = const Value.absent(),
    this.readAt = const Value.absent(),
    required DateTime createdAt,
    this.scheduledAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       message = Value(message),
       createdAt = Value(createdAt);
  static Insertable<Notification> custom({
    Expression<String>? id,
    Expression<String>? category,
    Expression<String>? priority,
    Expression<String>? title,
    Expression<String>? message,
    Expression<String>? relatedRecordId,
    Expression<String>? relatedRecordType,
    Expression<bool>? isRead,
    Expression<DateTime>? readAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? scheduledAt,
    Expression<String>? syncStatus,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (priority != null) 'priority': priority,
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (relatedRecordId != null) 'related_record_id': relatedRecordId,
      if (relatedRecordType != null) 'related_record_type': relatedRecordType,
      if (isRead != null) 'is_read': isRead,
      if (readAt != null) 'read_at': readAt,
      if (createdAt != null) 'created_at': createdAt,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationsCompanion copyWith({
    Value<String>? id,
    Value<String>? category,
    Value<String>? priority,
    Value<String>? title,
    Value<String>? message,
    Value<String?>? relatedRecordId,
    Value<String?>? relatedRecordType,
    Value<bool>? isRead,
    Value<DateTime?>? readAt,
    Value<DateTime>? createdAt,
    Value<DateTime?>? scheduledAt,
    Value<String>? syncStatus,
    Value<String?>? lastError,
    Value<int>? rowid,
  }) {
    return NotificationsCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      title: title ?? this.title,
      message: message ?? this.message,
      relatedRecordId: relatedRecordId ?? this.relatedRecordId,
      relatedRecordType: relatedRecordType ?? this.relatedRecordType,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      syncStatus: syncStatus ?? this.syncStatus,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (relatedRecordId.present) {
      map['related_record_id'] = Variable<String>(relatedRecordId.value);
    }
    if (relatedRecordType.present) {
      map['related_record_type'] = Variable<String>(relatedRecordType.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (readAt.present) {
      map['read_at'] = Variable<DateTime>(readAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('priority: $priority, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('relatedRecordId: $relatedRecordId, ')
          ..write('relatedRecordType: $relatedRecordType, ')
          ..write('isRead: $isRead, ')
          ..write('readAt: $readAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PigsTable extends Pigs with TableInfo<$PigsTable, Pig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _farmerIdMeta = const VerificationMeta(
    'farmerId',
  );
  @override
  late final GeneratedColumn<String> farmerId = GeneratedColumn<String>(
    'farmer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _penIdMeta = const VerificationMeta('penId');
  @override
  late final GeneratedColumn<String> penId = GeneratedColumn<String>(
    'pen_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
    'breed',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('legacy'),
  );
  static const VerificationMeta _fieldWorkerIdMeta = const VerificationMeta(
    'fieldWorkerId',
  );
  @override
  late final GeneratedColumn<String> fieldWorkerId = GeneratedColumn<String>(
    'field_worker_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('legacy'),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    farmerId,
    penId,
    breed,
    weight,
    isSynced,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pigs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('farmer_id')) {
      context.handle(
        _farmerIdMeta,
        farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_farmerIdMeta);
    }
    if (data.containsKey('pen_id')) {
      context.handle(
        _penIdMeta,
        penId.isAcceptableOrUnknown(data['pen_id']!, _penIdMeta),
      );
    } else if (isInserting) {
      context.missing(_penIdMeta);
    }
    if (data.containsKey('breed')) {
      context.handle(
        _breedMeta,
        breed.isAcceptableOrUnknown(data['breed']!, _breedMeta),
      );
    } else if (isInserting) {
      context.missing(_breedMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('field_worker_id')) {
      context.handle(
        _fieldWorkerIdMeta,
        fieldWorkerId.isAcceptableOrUnknown(
          data['field_worker_id']!,
          _fieldWorkerIdMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      farmerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farmer_id'],
      )!,
      penId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pen_id'],
      )!,
      breed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}breed'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      fieldWorkerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_worker_id'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $PigsTable createAlias(String alias) {
    return $PigsTable(attachedDatabase, alias);
  }
}

class Pig extends DataClass implements Insertable<Pig> {
  final String id;
  final String farmerId;
  final String penId;
  final String breed;
  final double weight;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String fieldWorkerId;
  final String syncStatus;
  const Pig({
    required this.id,
    required this.farmerId,
    required this.penId,
    required this.breed,
    required this.weight,
    required this.isSynced,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.fieldWorkerId,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['farmer_id'] = Variable<String>(farmerId);
    map['pen_id'] = Variable<String>(penId);
    map['breed'] = Variable<String>(breed);
    map['weight'] = Variable<double>(weight);
    map['is_synced'] = Variable<bool>(isSynced);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_by'] = Variable<String>(createdBy);
    map['field_worker_id'] = Variable<String>(fieldWorkerId);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  PigsCompanion toCompanion(bool nullToAbsent) {
    return PigsCompanion(
      id: Value(id),
      farmerId: Value(farmerId),
      penId: Value(penId),
      breed: Value(breed),
      weight: Value(weight),
      isSynced: Value(isSynced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      createdBy: Value(createdBy),
      fieldWorkerId: Value(fieldWorkerId),
      syncStatus: Value(syncStatus),
    );
  }

  factory Pig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pig(
      id: serializer.fromJson<String>(json['id']),
      farmerId: serializer.fromJson<String>(json['farmerId']),
      penId: serializer.fromJson<String>(json['penId']),
      breed: serializer.fromJson<String>(json['breed']),
      weight: serializer.fromJson<double>(json['weight']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      fieldWorkerId: serializer.fromJson<String>(json['fieldWorkerId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'farmerId': serializer.toJson<String>(farmerId),
      'penId': serializer.toJson<String>(penId),
      'breed': serializer.toJson<String>(breed),
      'weight': serializer.toJson<double>(weight),
      'isSynced': serializer.toJson<bool>(isSynced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdBy': serializer.toJson<String>(createdBy),
      'fieldWorkerId': serializer.toJson<String>(fieldWorkerId),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  Pig copyWith({
    String? id,
    String? farmerId,
    String? penId,
    String? breed,
    double? weight,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? fieldWorkerId,
    String? syncStatus,
  }) => Pig(
    id: id ?? this.id,
    farmerId: farmerId ?? this.farmerId,
    penId: penId ?? this.penId,
    breed: breed ?? this.breed,
    weight: weight ?? this.weight,
    isSynced: isSynced ?? this.isSynced,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    createdBy: createdBy ?? this.createdBy,
    fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  Pig copyWithCompanion(PigsCompanion data) {
    return Pig(
      id: data.id.present ? data.id.value : this.id,
      farmerId: data.farmerId.present ? data.farmerId.value : this.farmerId,
      penId: data.penId.present ? data.penId.value : this.penId,
      breed: data.breed.present ? data.breed.value : this.breed,
      weight: data.weight.present ? data.weight.value : this.weight,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      fieldWorkerId: data.fieldWorkerId.present
          ? data.fieldWorkerId.value
          : this.fieldWorkerId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pig(')
          ..write('id: $id, ')
          ..write('farmerId: $farmerId, ')
          ..write('penId: $penId, ')
          ..write('breed: $breed, ')
          ..write('weight: $weight, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    farmerId,
    penId,
    breed,
    weight,
    isSynced,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pig &&
          other.id == this.id &&
          other.farmerId == this.farmerId &&
          other.penId == this.penId &&
          other.breed == this.breed &&
          other.weight == this.weight &&
          other.isSynced == this.isSynced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.createdBy == this.createdBy &&
          other.fieldWorkerId == this.fieldWorkerId &&
          other.syncStatus == this.syncStatus);
}

class PigsCompanion extends UpdateCompanion<Pig> {
  final Value<String> id;
  final Value<String> farmerId;
  final Value<String> penId;
  final Value<String> breed;
  final Value<double> weight;
  final Value<bool> isSynced;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> createdBy;
  final Value<String> fieldWorkerId;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const PigsCompanion({
    this.id = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.penId = const Value.absent(),
    this.breed = const Value.absent(),
    this.weight = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PigsCompanion.insert({
    required String id,
    required String farmerId,
    required String penId,
    required String breed,
    required double weight,
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       farmerId = Value(farmerId),
       penId = Value(penId),
       breed = Value(breed),
       weight = Value(weight);
  static Insertable<Pig> custom({
    Expression<String>? id,
    Expression<String>? farmerId,
    Expression<String>? penId,
    Expression<String>? breed,
    Expression<double>? weight,
    Expression<bool>? isSynced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? createdBy,
    Expression<String>? fieldWorkerId,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (farmerId != null) 'farmer_id': farmerId,
      if (penId != null) 'pen_id': penId,
      if (breed != null) 'breed': breed,
      if (weight != null) 'weight': weight,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdBy != null) 'created_by': createdBy,
      if (fieldWorkerId != null) 'field_worker_id': fieldWorkerId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PigsCompanion copyWith({
    Value<String>? id,
    Value<String>? farmerId,
    Value<String>? penId,
    Value<String>? breed,
    Value<double>? weight,
    Value<bool>? isSynced,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? createdBy,
    Value<String>? fieldWorkerId,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return PigsCompanion(
      id: id ?? this.id,
      farmerId: farmerId ?? this.farmerId,
      penId: penId ?? this.penId,
      breed: breed ?? this.breed,
      weight: weight ?? this.weight,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (farmerId.present) {
      map['farmer_id'] = Variable<String>(farmerId.value);
    }
    if (penId.present) {
      map['pen_id'] = Variable<String>(penId.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (fieldWorkerId.present) {
      map['field_worker_id'] = Variable<String>(fieldWorkerId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PigsCompanion(')
          ..write('id: $id, ')
          ..write('farmerId: $farmerId, ')
          ..write('penId: $penId, ')
          ..write('breed: $breed, ')
          ..write('weight: $weight, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DispersalsTable extends Dispersals
    with TableInfo<$DispersalsTable, Dispersal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DispersalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _farmerIdMeta = const VerificationMeta(
    'farmerId',
  );
  @override
  late final GeneratedColumn<String> farmerId = GeneratedColumn<String>(
    'farmer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pigIdMeta = const VerificationMeta('pigId');
  @override
  late final GeneratedColumn<String> pigId = GeneratedColumn<String>(
    'pig_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conditionMeta = const VerificationMeta(
    'condition',
  );
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
    'condition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('legacy'),
  );
  static const VerificationMeta _fieldWorkerIdMeta = const VerificationMeta(
    'fieldWorkerId',
  );
  @override
  late final GeneratedColumn<String> fieldWorkerId = GeneratedColumn<String>(
    'field_worker_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('legacy'),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    farmerId,
    pigId,
    condition,
    remarks,
    isSynced,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dispersals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Dispersal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('farmer_id')) {
      context.handle(
        _farmerIdMeta,
        farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_farmerIdMeta);
    }
    if (data.containsKey('pig_id')) {
      context.handle(
        _pigIdMeta,
        pigId.isAcceptableOrUnknown(data['pig_id']!, _pigIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pigIdMeta);
    }
    if (data.containsKey('condition')) {
      context.handle(
        _conditionMeta,
        condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta),
      );
    } else if (isInserting) {
      context.missing(_conditionMeta);
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    } else if (isInserting) {
      context.missing(_remarksMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('field_worker_id')) {
      context.handle(
        _fieldWorkerIdMeta,
        fieldWorkerId.isAcceptableOrUnknown(
          data['field_worker_id']!,
          _fieldWorkerIdMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Dispersal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Dispersal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      farmerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farmer_id'],
      )!,
      pigId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pig_id'],
      )!,
      condition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition'],
      )!,
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      fieldWorkerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_worker_id'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $DispersalsTable createAlias(String alias) {
    return $DispersalsTable(attachedDatabase, alias);
  }
}

class Dispersal extends DataClass implements Insertable<Dispersal> {
  final String id;
  final String farmerId;
  final String pigId;
  final String condition;
  final String remarks;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String fieldWorkerId;
  final String syncStatus;
  const Dispersal({
    required this.id,
    required this.farmerId,
    required this.pigId,
    required this.condition,
    required this.remarks,
    required this.isSynced,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.fieldWorkerId,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['farmer_id'] = Variable<String>(farmerId);
    map['pig_id'] = Variable<String>(pigId);
    map['condition'] = Variable<String>(condition);
    map['remarks'] = Variable<String>(remarks);
    map['is_synced'] = Variable<bool>(isSynced);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_by'] = Variable<String>(createdBy);
    map['field_worker_id'] = Variable<String>(fieldWorkerId);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  DispersalsCompanion toCompanion(bool nullToAbsent) {
    return DispersalsCompanion(
      id: Value(id),
      farmerId: Value(farmerId),
      pigId: Value(pigId),
      condition: Value(condition),
      remarks: Value(remarks),
      isSynced: Value(isSynced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      createdBy: Value(createdBy),
      fieldWorkerId: Value(fieldWorkerId),
      syncStatus: Value(syncStatus),
    );
  }

  factory Dispersal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dispersal(
      id: serializer.fromJson<String>(json['id']),
      farmerId: serializer.fromJson<String>(json['farmerId']),
      pigId: serializer.fromJson<String>(json['pigId']),
      condition: serializer.fromJson<String>(json['condition']),
      remarks: serializer.fromJson<String>(json['remarks']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      fieldWorkerId: serializer.fromJson<String>(json['fieldWorkerId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'farmerId': serializer.toJson<String>(farmerId),
      'pigId': serializer.toJson<String>(pigId),
      'condition': serializer.toJson<String>(condition),
      'remarks': serializer.toJson<String>(remarks),
      'isSynced': serializer.toJson<bool>(isSynced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdBy': serializer.toJson<String>(createdBy),
      'fieldWorkerId': serializer.toJson<String>(fieldWorkerId),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  Dispersal copyWith({
    String? id,
    String? farmerId,
    String? pigId,
    String? condition,
    String? remarks,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? fieldWorkerId,
    String? syncStatus,
  }) => Dispersal(
    id: id ?? this.id,
    farmerId: farmerId ?? this.farmerId,
    pigId: pigId ?? this.pigId,
    condition: condition ?? this.condition,
    remarks: remarks ?? this.remarks,
    isSynced: isSynced ?? this.isSynced,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    createdBy: createdBy ?? this.createdBy,
    fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  Dispersal copyWithCompanion(DispersalsCompanion data) {
    return Dispersal(
      id: data.id.present ? data.id.value : this.id,
      farmerId: data.farmerId.present ? data.farmerId.value : this.farmerId,
      pigId: data.pigId.present ? data.pigId.value : this.pigId,
      condition: data.condition.present ? data.condition.value : this.condition,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      fieldWorkerId: data.fieldWorkerId.present
          ? data.fieldWorkerId.value
          : this.fieldWorkerId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dispersal(')
          ..write('id: $id, ')
          ..write('farmerId: $farmerId, ')
          ..write('pigId: $pigId, ')
          ..write('condition: $condition, ')
          ..write('remarks: $remarks, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    farmerId,
    pigId,
    condition,
    remarks,
    isSynced,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dispersal &&
          other.id == this.id &&
          other.farmerId == this.farmerId &&
          other.pigId == this.pigId &&
          other.condition == this.condition &&
          other.remarks == this.remarks &&
          other.isSynced == this.isSynced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.createdBy == this.createdBy &&
          other.fieldWorkerId == this.fieldWorkerId &&
          other.syncStatus == this.syncStatus);
}

class DispersalsCompanion extends UpdateCompanion<Dispersal> {
  final Value<String> id;
  final Value<String> farmerId;
  final Value<String> pigId;
  final Value<String> condition;
  final Value<String> remarks;
  final Value<bool> isSynced;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> createdBy;
  final Value<String> fieldWorkerId;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const DispersalsCompanion({
    this.id = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.pigId = const Value.absent(),
    this.condition = const Value.absent(),
    this.remarks = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DispersalsCompanion.insert({
    required String id,
    required String farmerId,
    required String pigId,
    required String condition,
    required String remarks,
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       farmerId = Value(farmerId),
       pigId = Value(pigId),
       condition = Value(condition),
       remarks = Value(remarks);
  static Insertable<Dispersal> custom({
    Expression<String>? id,
    Expression<String>? farmerId,
    Expression<String>? pigId,
    Expression<String>? condition,
    Expression<String>? remarks,
    Expression<bool>? isSynced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? createdBy,
    Expression<String>? fieldWorkerId,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (farmerId != null) 'farmer_id': farmerId,
      if (pigId != null) 'pig_id': pigId,
      if (condition != null) 'condition': condition,
      if (remarks != null) 'remarks': remarks,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdBy != null) 'created_by': createdBy,
      if (fieldWorkerId != null) 'field_worker_id': fieldWorkerId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DispersalsCompanion copyWith({
    Value<String>? id,
    Value<String>? farmerId,
    Value<String>? pigId,
    Value<String>? condition,
    Value<String>? remarks,
    Value<bool>? isSynced,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? createdBy,
    Value<String>? fieldWorkerId,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return DispersalsCompanion(
      id: id ?? this.id,
      farmerId: farmerId ?? this.farmerId,
      pigId: pigId ?? this.pigId,
      condition: condition ?? this.condition,
      remarks: remarks ?? this.remarks,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (farmerId.present) {
      map['farmer_id'] = Variable<String>(farmerId.value);
    }
    if (pigId.present) {
      map['pig_id'] = Variable<String>(pigId.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (fieldWorkerId.present) {
      map['field_worker_id'] = Variable<String>(fieldWorkerId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DispersalsCompanion(')
          ..write('id: $id, ')
          ..write('farmerId: $farmerId, ')
          ..write('pigId: $pigId, ')
          ..write('condition: $condition, ')
          ..write('remarks: $remarks, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OfflineRecordsTable extends OfflineRecords
    with TableInfo<$OfflineRecordsTable, OfflineRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OfflineRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordTypeMeta = const VerificationMeta(
    'recordType',
  );
  @override
  late final GeneratedColumn<String> recordType = GeneratedColumn<String>(
    'record_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldWorkerIdMeta = const VerificationMeta(
    'fieldWorkerId',
  );
  @override
  late final GeneratedColumn<String> fieldWorkerId = GeneratedColumn<String>(
    'field_worker_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _syncErrorMeta = const VerificationMeta(
    'syncError',
  );
  @override
  late final GeneratedColumn<String> syncError = GeneratedColumn<String>(
    'sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverRecordIdMeta = const VerificationMeta(
    'serverRecordId',
  );
  @override
  late final GeneratedColumn<String> serverRecordId = GeneratedColumn<String>(
    'server_record_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverUpdatedAtMeta = const VerificationMeta(
    'serverUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> serverUpdatedAt =
      GeneratedColumn<DateTime>(
        'server_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recordType,
    payload,
    latitude,
    longitude,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
    syncError,
    serverRecordId,
    serverUpdatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'offline_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<OfflineRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('record_type')) {
      context.handle(
        _recordTypeMeta,
        recordType.isAcceptableOrUnknown(data['record_type']!, _recordTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_recordTypeMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('field_worker_id')) {
      context.handle(
        _fieldWorkerIdMeta,
        fieldWorkerId.isAcceptableOrUnknown(
          data['field_worker_id']!,
          _fieldWorkerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fieldWorkerIdMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('sync_error')) {
      context.handle(
        _syncErrorMeta,
        syncError.isAcceptableOrUnknown(data['sync_error']!, _syncErrorMeta),
      );
    }
    if (data.containsKey('server_record_id')) {
      context.handle(
        _serverRecordIdMeta,
        serverRecordId.isAcceptableOrUnknown(
          data['server_record_id']!,
          _serverRecordIdMeta,
        ),
      );
    }
    if (data.containsKey('server_updated_at')) {
      context.handle(
        _serverUpdatedAtMeta,
        serverUpdatedAt.isAcceptableOrUnknown(
          data['server_updated_at']!,
          _serverUpdatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OfflineRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OfflineRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      recordType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_type'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      fieldWorkerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_worker_id'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      syncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_error'],
      ),
      serverRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_record_id'],
      ),
      serverUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}server_updated_at'],
      ),
    );
  }

  @override
  $OfflineRecordsTable createAlias(String alias) {
    return $OfflineRecordsTable(attachedDatabase, alias);
  }
}

class OfflineRecord extends DataClass implements Insertable<OfflineRecord> {
  final String id;
  final String recordType;
  final String payload;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String fieldWorkerId;
  final String syncStatus;
  final String? syncError;
  final String? serverRecordId;
  final DateTime? serverUpdatedAt;
  const OfflineRecord({
    required this.id,
    required this.recordType,
    required this.payload,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.fieldWorkerId,
    required this.syncStatus,
    this.syncError,
    this.serverRecordId,
    this.serverUpdatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['record_type'] = Variable<String>(recordType);
    map['payload'] = Variable<String>(payload);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_by'] = Variable<String>(createdBy);
    map['field_worker_id'] = Variable<String>(fieldWorkerId);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || syncError != null) {
      map['sync_error'] = Variable<String>(syncError);
    }
    if (!nullToAbsent || serverRecordId != null) {
      map['server_record_id'] = Variable<String>(serverRecordId);
    }
    if (!nullToAbsent || serverUpdatedAt != null) {
      map['server_updated_at'] = Variable<DateTime>(serverUpdatedAt);
    }
    return map;
  }

  OfflineRecordsCompanion toCompanion(bool nullToAbsent) {
    return OfflineRecordsCompanion(
      id: Value(id),
      recordType: Value(recordType),
      payload: Value(payload),
      latitude: Value(latitude),
      longitude: Value(longitude),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      createdBy: Value(createdBy),
      fieldWorkerId: Value(fieldWorkerId),
      syncStatus: Value(syncStatus),
      syncError: syncError == null && nullToAbsent
          ? const Value.absent()
          : Value(syncError),
      serverRecordId: serverRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverRecordId),
      serverUpdatedAt: serverUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUpdatedAt),
    );
  }

  factory OfflineRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OfflineRecord(
      id: serializer.fromJson<String>(json['id']),
      recordType: serializer.fromJson<String>(json['recordType']),
      payload: serializer.fromJson<String>(json['payload']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      fieldWorkerId: serializer.fromJson<String>(json['fieldWorkerId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      syncError: serializer.fromJson<String?>(json['syncError']),
      serverRecordId: serializer.fromJson<String?>(json['serverRecordId']),
      serverUpdatedAt: serializer.fromJson<DateTime?>(json['serverUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recordType': serializer.toJson<String>(recordType),
      'payload': serializer.toJson<String>(payload),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdBy': serializer.toJson<String>(createdBy),
      'fieldWorkerId': serializer.toJson<String>(fieldWorkerId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'syncError': serializer.toJson<String?>(syncError),
      'serverRecordId': serializer.toJson<String?>(serverRecordId),
      'serverUpdatedAt': serializer.toJson<DateTime?>(serverUpdatedAt),
    };
  }

  OfflineRecord copyWith({
    String? id,
    String? recordType,
    String? payload,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? fieldWorkerId,
    String? syncStatus,
    Value<String?> syncError = const Value.absent(),
    Value<String?> serverRecordId = const Value.absent(),
    Value<DateTime?> serverUpdatedAt = const Value.absent(),
  }) => OfflineRecord(
    id: id ?? this.id,
    recordType: recordType ?? this.recordType,
    payload: payload ?? this.payload,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    createdBy: createdBy ?? this.createdBy,
    fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
    syncStatus: syncStatus ?? this.syncStatus,
    syncError: syncError.present ? syncError.value : this.syncError,
    serverRecordId: serverRecordId.present
        ? serverRecordId.value
        : this.serverRecordId,
    serverUpdatedAt: serverUpdatedAt.present
        ? serverUpdatedAt.value
        : this.serverUpdatedAt,
  );
  OfflineRecord copyWithCompanion(OfflineRecordsCompanion data) {
    return OfflineRecord(
      id: data.id.present ? data.id.value : this.id,
      recordType: data.recordType.present
          ? data.recordType.value
          : this.recordType,
      payload: data.payload.present ? data.payload.value : this.payload,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      fieldWorkerId: data.fieldWorkerId.present
          ? data.fieldWorkerId.value
          : this.fieldWorkerId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      syncError: data.syncError.present ? data.syncError.value : this.syncError,
      serverRecordId: data.serverRecordId.present
          ? data.serverRecordId.value
          : this.serverRecordId,
      serverUpdatedAt: data.serverUpdatedAt.present
          ? data.serverUpdatedAt.value
          : this.serverUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OfflineRecord(')
          ..write('id: $id, ')
          ..write('recordType: $recordType, ')
          ..write('payload: $payload, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('serverRecordId: $serverRecordId, ')
          ..write('serverUpdatedAt: $serverUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recordType,
    payload,
    latitude,
    longitude,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
    syncError,
    serverRecordId,
    serverUpdatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OfflineRecord &&
          other.id == this.id &&
          other.recordType == this.recordType &&
          other.payload == this.payload &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.createdBy == this.createdBy &&
          other.fieldWorkerId == this.fieldWorkerId &&
          other.syncStatus == this.syncStatus &&
          other.syncError == this.syncError &&
          other.serverRecordId == this.serverRecordId &&
          other.serverUpdatedAt == this.serverUpdatedAt);
}

class OfflineRecordsCompanion extends UpdateCompanion<OfflineRecord> {
  final Value<String> id;
  final Value<String> recordType;
  final Value<String> payload;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> createdBy;
  final Value<String> fieldWorkerId;
  final Value<String> syncStatus;
  final Value<String?> syncError;
  final Value<String?> serverRecordId;
  final Value<DateTime?> serverUpdatedAt;
  final Value<int> rowid;
  const OfflineRecordsCompanion({
    this.id = const Value.absent(),
    this.recordType = const Value.absent(),
    this.payload = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.syncError = const Value.absent(),
    this.serverRecordId = const Value.absent(),
    this.serverUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OfflineRecordsCompanion.insert({
    required String id,
    required String recordType,
    required String payload,
    required double latitude,
    required double longitude,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String createdBy,
    required String fieldWorkerId,
    this.syncStatus = const Value.absent(),
    this.syncError = const Value.absent(),
    this.serverRecordId = const Value.absent(),
    this.serverUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       recordType = Value(recordType),
       payload = Value(payload),
       latitude = Value(latitude),
       longitude = Value(longitude),
       createdBy = Value(createdBy),
       fieldWorkerId = Value(fieldWorkerId);
  static Insertable<OfflineRecord> custom({
    Expression<String>? id,
    Expression<String>? recordType,
    Expression<String>? payload,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? createdBy,
    Expression<String>? fieldWorkerId,
    Expression<String>? syncStatus,
    Expression<String>? syncError,
    Expression<String>? serverRecordId,
    Expression<DateTime>? serverUpdatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordType != null) 'record_type': recordType,
      if (payload != null) 'payload': payload,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdBy != null) 'created_by': createdBy,
      if (fieldWorkerId != null) 'field_worker_id': fieldWorkerId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (syncError != null) 'sync_error': syncError,
      if (serverRecordId != null) 'server_record_id': serverRecordId,
      if (serverUpdatedAt != null) 'server_updated_at': serverUpdatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OfflineRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? recordType,
    Value<String>? payload,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? createdBy,
    Value<String>? fieldWorkerId,
    Value<String>? syncStatus,
    Value<String?>? syncError,
    Value<String?>? serverRecordId,
    Value<DateTime?>? serverUpdatedAt,
    Value<int>? rowid,
  }) {
    return OfflineRecordsCompanion(
      id: id ?? this.id,
      recordType: recordType ?? this.recordType,
      payload: payload ?? this.payload,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
      syncStatus: syncStatus ?? this.syncStatus,
      syncError: syncError ?? this.syncError,
      serverRecordId: serverRecordId ?? this.serverRecordId,
      serverUpdatedAt: serverUpdatedAt ?? this.serverUpdatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recordType.present) {
      map['record_type'] = Variable<String>(recordType.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (fieldWorkerId.present) {
      map['field_worker_id'] = Variable<String>(fieldWorkerId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (syncError.present) {
      map['sync_error'] = Variable<String>(syncError.value);
    }
    if (serverRecordId.present) {
      map['server_record_id'] = Variable<String>(serverRecordId.value);
    }
    if (serverUpdatedAt.present) {
      map['server_updated_at'] = Variable<DateTime>(serverUpdatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OfflineRecordsCompanion(')
          ..write('id: $id, ')
          ..write('recordType: $recordType, ')
          ..write('payload: $payload, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('serverRecordId: $serverRecordId, ')
          ..write('serverUpdatedAt: $serverUpdatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OfflinePhotosTable extends OfflinePhotos
    with TableInfo<$OfflinePhotosTable, OfflinePhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OfflinePhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordTypeMeta = const VerificationMeta(
    'recordType',
  );
  @override
  late final GeneratedColumn<String> recordType = GeneratedColumn<String>(
    'record_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldWorkerIdMeta = const VerificationMeta(
    'fieldWorkerId',
  );
  @override
  late final GeneratedColumn<String> fieldWorkerId = GeneratedColumn<String>(
    'field_worker_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _syncErrorMeta = const VerificationMeta(
    'syncError',
  );
  @override
  late final GeneratedColumn<String> syncError = GeneratedColumn<String>(
    'sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverFileIdMeta = const VerificationMeta(
    'serverFileId',
  );
  @override
  late final GeneratedColumn<String> serverFileId = GeneratedColumn<String>(
    'server_file_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverFileUrlMeta = const VerificationMeta(
    'serverFileUrl',
  );
  @override
  late final GeneratedColumn<String> serverFileUrl = GeneratedColumn<String>(
    'server_file_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _verificationStatusMeta =
      const VerificationMeta('verificationStatus');
  @override
  late final GeneratedColumn<String> verificationStatus =
      GeneratedColumn<String>(
        'verification_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('verification_required'),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recordId,
    recordType,
    filePath,
    mimeType,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
    syncError,
    serverFileId,
    serverFileUrl,
    verificationStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'offline_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<OfflinePhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('record_type')) {
      context.handle(
        _recordTypeMeta,
        recordType.isAcceptableOrUnknown(data['record_type']!, _recordTypeMeta),
      );
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('field_worker_id')) {
      context.handle(
        _fieldWorkerIdMeta,
        fieldWorkerId.isAcceptableOrUnknown(
          data['field_worker_id']!,
          _fieldWorkerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fieldWorkerIdMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('sync_error')) {
      context.handle(
        _syncErrorMeta,
        syncError.isAcceptableOrUnknown(data['sync_error']!, _syncErrorMeta),
      );
    }
    if (data.containsKey('server_file_id')) {
      context.handle(
        _serverFileIdMeta,
        serverFileId.isAcceptableOrUnknown(
          data['server_file_id']!,
          _serverFileIdMeta,
        ),
      );
    }
    if (data.containsKey('server_file_url')) {
      context.handle(
        _serverFileUrlMeta,
        serverFileUrl.isAcceptableOrUnknown(
          data['server_file_url']!,
          _serverFileUrlMeta,
        ),
      );
    }
    if (data.containsKey('verification_status')) {
      context.handle(
        _verificationStatusMeta,
        verificationStatus.isAcceptableOrUnknown(
          data['verification_status']!,
          _verificationStatusMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OfflinePhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OfflinePhoto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      )!,
      recordType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_type'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      fieldWorkerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_worker_id'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      syncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_error'],
      ),
      serverFileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_file_id'],
      ),
      serverFileUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_file_url'],
      ),
      verificationStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verification_status'],
      )!,
    );
  }

  @override
  $OfflinePhotosTable createAlias(String alias) {
    return $OfflinePhotosTable(attachedDatabase, alias);
  }
}

class OfflinePhoto extends DataClass implements Insertable<OfflinePhoto> {
  final String id;
  final String recordId;

  /// The owning domain record type, used when evidence is queued separately
  /// from the original field record.
  final String recordType;
  final String filePath;
  final String mimeType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String fieldWorkerId;
  final String syncStatus;
  final String? syncError;
  final String? serverFileId;
  final String? serverFileUrl;

  /// Review workflow state from the secure media service. Sync status remains
  /// independent so pending uploads are never confused with review decisions.
  final String verificationStatus;
  const OfflinePhoto({
    required this.id,
    required this.recordId,
    required this.recordType,
    required this.filePath,
    required this.mimeType,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.fieldWorkerId,
    required this.syncStatus,
    this.syncError,
    this.serverFileId,
    this.serverFileUrl,
    required this.verificationStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['record_id'] = Variable<String>(recordId);
    map['record_type'] = Variable<String>(recordType);
    map['file_path'] = Variable<String>(filePath);
    map['mime_type'] = Variable<String>(mimeType);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_by'] = Variable<String>(createdBy);
    map['field_worker_id'] = Variable<String>(fieldWorkerId);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || syncError != null) {
      map['sync_error'] = Variable<String>(syncError);
    }
    if (!nullToAbsent || serverFileId != null) {
      map['server_file_id'] = Variable<String>(serverFileId);
    }
    if (!nullToAbsent || serverFileUrl != null) {
      map['server_file_url'] = Variable<String>(serverFileUrl);
    }
    map['verification_status'] = Variable<String>(verificationStatus);
    return map;
  }

  OfflinePhotosCompanion toCompanion(bool nullToAbsent) {
    return OfflinePhotosCompanion(
      id: Value(id),
      recordId: Value(recordId),
      recordType: Value(recordType),
      filePath: Value(filePath),
      mimeType: Value(mimeType),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      createdBy: Value(createdBy),
      fieldWorkerId: Value(fieldWorkerId),
      syncStatus: Value(syncStatus),
      syncError: syncError == null && nullToAbsent
          ? const Value.absent()
          : Value(syncError),
      serverFileId: serverFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverFileId),
      serverFileUrl: serverFileUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(serverFileUrl),
      verificationStatus: Value(verificationStatus),
    );
  }

  factory OfflinePhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OfflinePhoto(
      id: serializer.fromJson<String>(json['id']),
      recordId: serializer.fromJson<String>(json['recordId']),
      recordType: serializer.fromJson<String>(json['recordType']),
      filePath: serializer.fromJson<String>(json['filePath']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      fieldWorkerId: serializer.fromJson<String>(json['fieldWorkerId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      syncError: serializer.fromJson<String?>(json['syncError']),
      serverFileId: serializer.fromJson<String?>(json['serverFileId']),
      serverFileUrl: serializer.fromJson<String?>(json['serverFileUrl']),
      verificationStatus: serializer.fromJson<String>(
        json['verificationStatus'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recordId': serializer.toJson<String>(recordId),
      'recordType': serializer.toJson<String>(recordType),
      'filePath': serializer.toJson<String>(filePath),
      'mimeType': serializer.toJson<String>(mimeType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdBy': serializer.toJson<String>(createdBy),
      'fieldWorkerId': serializer.toJson<String>(fieldWorkerId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'syncError': serializer.toJson<String?>(syncError),
      'serverFileId': serializer.toJson<String?>(serverFileId),
      'serverFileUrl': serializer.toJson<String?>(serverFileUrl),
      'verificationStatus': serializer.toJson<String>(verificationStatus),
    };
  }

  OfflinePhoto copyWith({
    String? id,
    String? recordId,
    String? recordType,
    String? filePath,
    String? mimeType,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? fieldWorkerId,
    String? syncStatus,
    Value<String?> syncError = const Value.absent(),
    Value<String?> serverFileId = const Value.absent(),
    Value<String?> serverFileUrl = const Value.absent(),
    String? verificationStatus,
  }) => OfflinePhoto(
    id: id ?? this.id,
    recordId: recordId ?? this.recordId,
    recordType: recordType ?? this.recordType,
    filePath: filePath ?? this.filePath,
    mimeType: mimeType ?? this.mimeType,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    createdBy: createdBy ?? this.createdBy,
    fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
    syncStatus: syncStatus ?? this.syncStatus,
    syncError: syncError.present ? syncError.value : this.syncError,
    serverFileId: serverFileId.present ? serverFileId.value : this.serverFileId,
    serverFileUrl: serverFileUrl.present
        ? serverFileUrl.value
        : this.serverFileUrl,
    verificationStatus: verificationStatus ?? this.verificationStatus,
  );
  OfflinePhoto copyWithCompanion(OfflinePhotosCompanion data) {
    return OfflinePhoto(
      id: data.id.present ? data.id.value : this.id,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      recordType: data.recordType.present
          ? data.recordType.value
          : this.recordType,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      fieldWorkerId: data.fieldWorkerId.present
          ? data.fieldWorkerId.value
          : this.fieldWorkerId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      syncError: data.syncError.present ? data.syncError.value : this.syncError,
      serverFileId: data.serverFileId.present
          ? data.serverFileId.value
          : this.serverFileId,
      serverFileUrl: data.serverFileUrl.present
          ? data.serverFileUrl.value
          : this.serverFileUrl,
      verificationStatus: data.verificationStatus.present
          ? data.verificationStatus.value
          : this.verificationStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OfflinePhoto(')
          ..write('id: $id, ')
          ..write('recordId: $recordId, ')
          ..write('recordType: $recordType, ')
          ..write('filePath: $filePath, ')
          ..write('mimeType: $mimeType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('serverFileId: $serverFileId, ')
          ..write('serverFileUrl: $serverFileUrl, ')
          ..write('verificationStatus: $verificationStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recordId,
    recordType,
    filePath,
    mimeType,
    createdAt,
    updatedAt,
    createdBy,
    fieldWorkerId,
    syncStatus,
    syncError,
    serverFileId,
    serverFileUrl,
    verificationStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OfflinePhoto &&
          other.id == this.id &&
          other.recordId == this.recordId &&
          other.recordType == this.recordType &&
          other.filePath == this.filePath &&
          other.mimeType == this.mimeType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.createdBy == this.createdBy &&
          other.fieldWorkerId == this.fieldWorkerId &&
          other.syncStatus == this.syncStatus &&
          other.syncError == this.syncError &&
          other.serverFileId == this.serverFileId &&
          other.serverFileUrl == this.serverFileUrl &&
          other.verificationStatus == this.verificationStatus);
}

class OfflinePhotosCompanion extends UpdateCompanion<OfflinePhoto> {
  final Value<String> id;
  final Value<String> recordId;
  final Value<String> recordType;
  final Value<String> filePath;
  final Value<String> mimeType;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> createdBy;
  final Value<String> fieldWorkerId;
  final Value<String> syncStatus;
  final Value<String?> syncError;
  final Value<String?> serverFileId;
  final Value<String?> serverFileUrl;
  final Value<String> verificationStatus;
  final Value<int> rowid;
  const OfflinePhotosCompanion({
    this.id = const Value.absent(),
    this.recordId = const Value.absent(),
    this.recordType = const Value.absent(),
    this.filePath = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.syncError = const Value.absent(),
    this.serverFileId = const Value.absent(),
    this.serverFileUrl = const Value.absent(),
    this.verificationStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OfflinePhotosCompanion.insert({
    required String id,
    required String recordId,
    this.recordType = const Value.absent(),
    required String filePath,
    required String mimeType,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String createdBy,
    required String fieldWorkerId,
    this.syncStatus = const Value.absent(),
    this.syncError = const Value.absent(),
    this.serverFileId = const Value.absent(),
    this.serverFileUrl = const Value.absent(),
    this.verificationStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       recordId = Value(recordId),
       filePath = Value(filePath),
       mimeType = Value(mimeType),
       createdBy = Value(createdBy),
       fieldWorkerId = Value(fieldWorkerId);
  static Insertable<OfflinePhoto> custom({
    Expression<String>? id,
    Expression<String>? recordId,
    Expression<String>? recordType,
    Expression<String>? filePath,
    Expression<String>? mimeType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? createdBy,
    Expression<String>? fieldWorkerId,
    Expression<String>? syncStatus,
    Expression<String>? syncError,
    Expression<String>? serverFileId,
    Expression<String>? serverFileUrl,
    Expression<String>? verificationStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordId != null) 'record_id': recordId,
      if (recordType != null) 'record_type': recordType,
      if (filePath != null) 'file_path': filePath,
      if (mimeType != null) 'mime_type': mimeType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdBy != null) 'created_by': createdBy,
      if (fieldWorkerId != null) 'field_worker_id': fieldWorkerId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (syncError != null) 'sync_error': syncError,
      if (serverFileId != null) 'server_file_id': serverFileId,
      if (serverFileUrl != null) 'server_file_url': serverFileUrl,
      if (verificationStatus != null) 'verification_status': verificationStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OfflinePhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? recordId,
    Value<String>? recordType,
    Value<String>? filePath,
    Value<String>? mimeType,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? createdBy,
    Value<String>? fieldWorkerId,
    Value<String>? syncStatus,
    Value<String?>? syncError,
    Value<String?>? serverFileId,
    Value<String?>? serverFileUrl,
    Value<String>? verificationStatus,
    Value<int>? rowid,
  }) {
    return OfflinePhotosCompanion(
      id: id ?? this.id,
      recordId: recordId ?? this.recordId,
      recordType: recordType ?? this.recordType,
      filePath: filePath ?? this.filePath,
      mimeType: mimeType ?? this.mimeType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
      syncStatus: syncStatus ?? this.syncStatus,
      syncError: syncError ?? this.syncError,
      serverFileId: serverFileId ?? this.serverFileId,
      serverFileUrl: serverFileUrl ?? this.serverFileUrl,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (recordType.present) {
      map['record_type'] = Variable<String>(recordType.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (fieldWorkerId.present) {
      map['field_worker_id'] = Variable<String>(fieldWorkerId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (syncError.present) {
      map['sync_error'] = Variable<String>(syncError.value);
    }
    if (serverFileId.present) {
      map['server_file_id'] = Variable<String>(serverFileId.value);
    }
    if (serverFileUrl.present) {
      map['server_file_url'] = Variable<String>(serverFileUrl.value);
    }
    if (verificationStatus.present) {
      map['verification_status'] = Variable<String>(verificationStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OfflinePhotosCompanion(')
          ..write('id: $id, ')
          ..write('recordId: $recordId, ')
          ..write('recordType: $recordType, ')
          ..write('filePath: $filePath, ')
          ..write('mimeType: $mimeType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('syncError: $syncError, ')
          ..write('serverFileId: $serverFileId, ')
          ..write('serverFileUrl: $serverFileUrl, ')
          ..write('verificationStatus: $verificationStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _endpointMeta = const VerificationMeta(
    'endpoint',
  );
  @override
  late final GeneratedColumn<String> endpoint = GeneratedColumn<String>(
    'endpoint',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordTypeMeta = const VerificationMeta(
    'recordType',
  );
  @override
  late final GeneratedColumn<String> recordType = GeneratedColumn<String>(
    'record_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('legacy'),
  );
  static const VerificationMeta _fieldWorkerIdMeta = const VerificationMeta(
    'fieldWorkerId',
  );
  @override
  late final GeneratedColumn<String> fieldWorkerId = GeneratedColumn<String>(
    'field_worker_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('legacy'),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextAttemptAtMeta = const VerificationMeta(
    'nextAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextAttemptAt =
      GeneratedColumn<DateTime>(
        'next_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _serverRecordIdMeta = const VerificationMeta(
    'serverRecordId',
  );
  @override
  late final GeneratedColumn<String> serverRecordId = GeneratedColumn<String>(
    'server_record_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    endpoint,
    method,
    payload,
    status,
    syncStatus,
    recordId,
    recordType,
    createdBy,
    fieldWorkerId,
    retryCount,
    lastError,
    lastAttemptAt,
    nextAttemptAt,
    serverRecordId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('endpoint')) {
      context.handle(
        _endpointMeta,
        endpoint.isAcceptableOrUnknown(data['endpoint']!, _endpointMeta),
      );
    } else if (isInserting) {
      context.missing(_endpointMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    }
    if (data.containsKey('record_type')) {
      context.handle(
        _recordTypeMeta,
        recordType.isAcceptableOrUnknown(data['record_type']!, _recordTypeMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('field_worker_id')) {
      context.handle(
        _fieldWorkerIdMeta,
        fieldWorkerId.isAcceptableOrUnknown(
          data['field_worker_id']!,
          _fieldWorkerIdMeta,
        ),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
        _nextAttemptAtMeta,
        nextAttemptAt.isAcceptableOrUnknown(
          data['next_attempt_at']!,
          _nextAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('server_record_id')) {
      context.handle(
        _serverRecordIdMeta,
        serverRecordId.isAcceptableOrUnknown(
          data['server_record_id']!,
          _serverRecordIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      endpoint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}endpoint'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      ),
      recordType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_type'],
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      fieldWorkerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_worker_id'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      nextAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_attempt_at'],
      ),
      serverRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_record_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String endpoint;
  final String method;
  final String payload;
  final String status;
  final String syncStatus;
  final String? recordId;
  final String? recordType;
  final String createdBy;
  final String fieldWorkerId;
  final int retryCount;
  final String? lastError;
  final DateTime? lastAttemptAt;
  final DateTime? nextAttemptAt;
  final String? serverRecordId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SyncQueueData({
    required this.id,
    required this.endpoint,
    required this.method,
    required this.payload,
    required this.status,
    required this.syncStatus,
    this.recordId,
    this.recordType,
    required this.createdBy,
    required this.fieldWorkerId,
    required this.retryCount,
    this.lastError,
    this.lastAttemptAt,
    this.nextAttemptAt,
    this.serverRecordId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['endpoint'] = Variable<String>(endpoint);
    map['method'] = Variable<String>(method);
    map['payload'] = Variable<String>(payload);
    map['status'] = Variable<String>(status);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || recordId != null) {
      map['record_id'] = Variable<String>(recordId);
    }
    if (!nullToAbsent || recordType != null) {
      map['record_type'] = Variable<String>(recordType);
    }
    map['created_by'] = Variable<String>(createdBy);
    map['field_worker_id'] = Variable<String>(fieldWorkerId);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || nextAttemptAt != null) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt);
    }
    if (!nullToAbsent || serverRecordId != null) {
      map['server_record_id'] = Variable<String>(serverRecordId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      endpoint: Value(endpoint),
      method: Value(method),
      payload: Value(payload),
      status: Value(status),
      syncStatus: Value(syncStatus),
      recordId: recordId == null && nullToAbsent
          ? const Value.absent()
          : Value(recordId),
      recordType: recordType == null && nullToAbsent
          ? const Value.absent()
          : Value(recordType),
      createdBy: Value(createdBy),
      fieldWorkerId: Value(fieldWorkerId),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      nextAttemptAt: nextAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextAttemptAt),
      serverRecordId: serverRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverRecordId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      endpoint: serializer.fromJson<String>(json['endpoint']),
      method: serializer.fromJson<String>(json['method']),
      payload: serializer.fromJson<String>(json['payload']),
      status: serializer.fromJson<String>(json['status']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      recordId: serializer.fromJson<String?>(json['recordId']),
      recordType: serializer.fromJson<String?>(json['recordType']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      fieldWorkerId: serializer.fromJson<String>(json['fieldWorkerId']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      nextAttemptAt: serializer.fromJson<DateTime?>(json['nextAttemptAt']),
      serverRecordId: serializer.fromJson<String?>(json['serverRecordId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'endpoint': serializer.toJson<String>(endpoint),
      'method': serializer.toJson<String>(method),
      'payload': serializer.toJson<String>(payload),
      'status': serializer.toJson<String>(status),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'recordId': serializer.toJson<String?>(recordId),
      'recordType': serializer.toJson<String?>(recordType),
      'createdBy': serializer.toJson<String>(createdBy),
      'fieldWorkerId': serializer.toJson<String>(fieldWorkerId),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'nextAttemptAt': serializer.toJson<DateTime?>(nextAttemptAt),
      'serverRecordId': serializer.toJson<String?>(serverRecordId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyncQueueData copyWith({
    int? id,
    String? endpoint,
    String? method,
    String? payload,
    String? status,
    String? syncStatus,
    Value<String?> recordId = const Value.absent(),
    Value<String?> recordType = const Value.absent(),
    String? createdBy,
    String? fieldWorkerId,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    Value<DateTime?> nextAttemptAt = const Value.absent(),
    Value<String?> serverRecordId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SyncQueueData(
    id: id ?? this.id,
    endpoint: endpoint ?? this.endpoint,
    method: method ?? this.method,
    payload: payload ?? this.payload,
    status: status ?? this.status,
    syncStatus: syncStatus ?? this.syncStatus,
    recordId: recordId.present ? recordId.value : this.recordId,
    recordType: recordType.present ? recordType.value : this.recordType,
    createdBy: createdBy ?? this.createdBy,
    fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    nextAttemptAt: nextAttemptAt.present
        ? nextAttemptAt.value
        : this.nextAttemptAt,
    serverRecordId: serverRecordId.present
        ? serverRecordId.value
        : this.serverRecordId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      endpoint: data.endpoint.present ? data.endpoint.value : this.endpoint,
      method: data.method.present ? data.method.value : this.method,
      payload: data.payload.present ? data.payload.value : this.payload,
      status: data.status.present ? data.status.value : this.status,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      recordType: data.recordType.present
          ? data.recordType.value
          : this.recordType,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      fieldWorkerId: data.fieldWorkerId.present
          ? data.fieldWorkerId.value
          : this.fieldWorkerId,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      nextAttemptAt: data.nextAttemptAt.present
          ? data.nextAttemptAt.value
          : this.nextAttemptAt,
      serverRecordId: data.serverRecordId.present
          ? data.serverRecordId.value
          : this.serverRecordId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('endpoint: $endpoint, ')
          ..write('method: $method, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('recordId: $recordId, ')
          ..write('recordType: $recordType, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('serverRecordId: $serverRecordId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    endpoint,
    method,
    payload,
    status,
    syncStatus,
    recordId,
    recordType,
    createdBy,
    fieldWorkerId,
    retryCount,
    lastError,
    lastAttemptAt,
    nextAttemptAt,
    serverRecordId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.endpoint == this.endpoint &&
          other.method == this.method &&
          other.payload == this.payload &&
          other.status == this.status &&
          other.syncStatus == this.syncStatus &&
          other.recordId == this.recordId &&
          other.recordType == this.recordType &&
          other.createdBy == this.createdBy &&
          other.fieldWorkerId == this.fieldWorkerId &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.nextAttemptAt == this.nextAttemptAt &&
          other.serverRecordId == this.serverRecordId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> endpoint;
  final Value<String> method;
  final Value<String> payload;
  final Value<String> status;
  final Value<String> syncStatus;
  final Value<String?> recordId;
  final Value<String?> recordType;
  final Value<String> createdBy;
  final Value<String> fieldWorkerId;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime?> nextAttemptAt;
  final Value<String?> serverRecordId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.endpoint = const Value.absent(),
    this.method = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.recordId = const Value.absent(),
    this.recordType = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.serverRecordId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String endpoint,
    required String method,
    required String payload,
    this.status = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.recordId = const Value.absent(),
    this.recordType = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.fieldWorkerId = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.serverRecordId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : endpoint = Value(endpoint),
       method = Value(method),
       payload = Value(payload);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? endpoint,
    Expression<String>? method,
    Expression<String>? payload,
    Expression<String>? status,
    Expression<String>? syncStatus,
    Expression<String>? recordId,
    Expression<String>? recordType,
    Expression<String>? createdBy,
    Expression<String>? fieldWorkerId,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? nextAttemptAt,
    Expression<String>? serverRecordId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (endpoint != null) 'endpoint': endpoint,
      if (method != null) 'method': method,
      if (payload != null) 'payload': payload,
      if (status != null) 'status': status,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (recordId != null) 'record_id': recordId,
      if (recordType != null) 'record_type': recordType,
      if (createdBy != null) 'created_by': createdBy,
      if (fieldWorkerId != null) 'field_worker_id': fieldWorkerId,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (serverRecordId != null) 'server_record_id': serverRecordId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? endpoint,
    Value<String>? method,
    Value<String>? payload,
    Value<String>? status,
    Value<String>? syncStatus,
    Value<String?>? recordId,
    Value<String?>? recordType,
    Value<String>? createdBy,
    Value<String>? fieldWorkerId,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<DateTime?>? lastAttemptAt,
    Value<DateTime?>? nextAttemptAt,
    Value<String?>? serverRecordId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      endpoint: endpoint ?? this.endpoint,
      method: method ?? this.method,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      syncStatus: syncStatus ?? this.syncStatus,
      recordId: recordId ?? this.recordId,
      recordType: recordType ?? this.recordType,
      createdBy: createdBy ?? this.createdBy,
      fieldWorkerId: fieldWorkerId ?? this.fieldWorkerId,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      serverRecordId: serverRecordId ?? this.serverRecordId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (endpoint.present) {
      map['endpoint'] = Variable<String>(endpoint.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (recordType.present) {
      map['record_type'] = Variable<String>(recordType.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (fieldWorkerId.present) {
      map['field_worker_id'] = Variable<String>(fieldWorkerId.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt.value);
    }
    if (serverRecordId.present) {
      map['server_record_id'] = Variable<String>(serverRecordId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('endpoint: $endpoint, ')
          ..write('method: $method, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('recordId: $recordId, ')
          ..write('recordType: $recordType, ')
          ..write('createdBy: $createdBy, ')
          ..write('fieldWorkerId: $fieldWorkerId, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('serverRecordId: $serverRecordId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncLogsTable extends SyncLogs with TableInfo<$SyncLogsTable, SyncLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _triggerMeta = const VerificationMeta(
    'trigger',
  );
  @override
  late final GeneratedColumn<String> trigger = GeneratedColumn<String>(
    'trigger',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uploadedCountMeta = const VerificationMeta(
    'uploadedCount',
  );
  @override
  late final GeneratedColumn<int> uploadedCount = GeneratedColumn<int>(
    'uploaded_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _downloadedCountMeta = const VerificationMeta(
    'downloadedCount',
  );
  @override
  late final GeneratedColumn<int> downloadedCount = GeneratedColumn<int>(
    'downloaded_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _failedCountMeta = const VerificationMeta(
    'failedCount',
  );
  @override
  late final GeneratedColumn<int> failedCount = GeneratedColumn<int>(
    'failed_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _conflictCountMeta = const VerificationMeta(
    'conflictCount',
  );
  @override
  late final GeneratedColumn<int> conflictCount = GeneratedColumn<int>(
    'conflict_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trigger,
    status,
    uploadedCount,
    downloadedCount,
    failedCount,
    conflictCount,
    message,
    startedAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('trigger')) {
      context.handle(
        _triggerMeta,
        trigger.isAcceptableOrUnknown(data['trigger']!, _triggerMeta),
      );
    } else if (isInserting) {
      context.missing(_triggerMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('uploaded_count')) {
      context.handle(
        _uploadedCountMeta,
        uploadedCount.isAcceptableOrUnknown(
          data['uploaded_count']!,
          _uploadedCountMeta,
        ),
      );
    }
    if (data.containsKey('downloaded_count')) {
      context.handle(
        _downloadedCountMeta,
        downloadedCount.isAcceptableOrUnknown(
          data['downloaded_count']!,
          _downloadedCountMeta,
        ),
      );
    }
    if (data.containsKey('failed_count')) {
      context.handle(
        _failedCountMeta,
        failedCount.isAcceptableOrUnknown(
          data['failed_count']!,
          _failedCountMeta,
        ),
      );
    }
    if (data.containsKey('conflict_count')) {
      context.handle(
        _conflictCountMeta,
        conflictCount.isAcceptableOrUnknown(
          data['conflict_count']!,
          _conflictCountMeta,
        ),
      );
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      trigger: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      uploadedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}uploaded_count'],
      )!,
      downloadedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}downloaded_count'],
      )!,
      failedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}failed_count'],
      )!,
      conflictCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}conflict_count'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $SyncLogsTable createAlias(String alias) {
    return $SyncLogsTable(attachedDatabase, alias);
  }
}

class SyncLog extends DataClass implements Insertable<SyncLog> {
  final String id;
  final String trigger;
  final String status;
  final int uploadedCount;
  final int downloadedCount;
  final int failedCount;
  final int conflictCount;
  final String? message;
  final DateTime startedAt;
  final DateTime? completedAt;
  const SyncLog({
    required this.id,
    required this.trigger,
    required this.status,
    required this.uploadedCount,
    required this.downloadedCount,
    required this.failedCount,
    required this.conflictCount,
    this.message,
    required this.startedAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['trigger'] = Variable<String>(trigger);
    map['status'] = Variable<String>(status);
    map['uploaded_count'] = Variable<int>(uploadedCount);
    map['downloaded_count'] = Variable<int>(downloadedCount);
    map['failed_count'] = Variable<int>(failedCount);
    map['conflict_count'] = Variable<int>(conflictCount);
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  SyncLogsCompanion toCompanion(bool nullToAbsent) {
    return SyncLogsCompanion(
      id: Value(id),
      trigger: Value(trigger),
      status: Value(status),
      uploadedCount: Value(uploadedCount),
      downloadedCount: Value(downloadedCount),
      failedCount: Value(failedCount),
      conflictCount: Value(conflictCount),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory SyncLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncLog(
      id: serializer.fromJson<String>(json['id']),
      trigger: serializer.fromJson<String>(json['trigger']),
      status: serializer.fromJson<String>(json['status']),
      uploadedCount: serializer.fromJson<int>(json['uploadedCount']),
      downloadedCount: serializer.fromJson<int>(json['downloadedCount']),
      failedCount: serializer.fromJson<int>(json['failedCount']),
      conflictCount: serializer.fromJson<int>(json['conflictCount']),
      message: serializer.fromJson<String?>(json['message']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'trigger': serializer.toJson<String>(trigger),
      'status': serializer.toJson<String>(status),
      'uploadedCount': serializer.toJson<int>(uploadedCount),
      'downloadedCount': serializer.toJson<int>(downloadedCount),
      'failedCount': serializer.toJson<int>(failedCount),
      'conflictCount': serializer.toJson<int>(conflictCount),
      'message': serializer.toJson<String?>(message),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  SyncLog copyWith({
    String? id,
    String? trigger,
    String? status,
    int? uploadedCount,
    int? downloadedCount,
    int? failedCount,
    int? conflictCount,
    Value<String?> message = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => SyncLog(
    id: id ?? this.id,
    trigger: trigger ?? this.trigger,
    status: status ?? this.status,
    uploadedCount: uploadedCount ?? this.uploadedCount,
    downloadedCount: downloadedCount ?? this.downloadedCount,
    failedCount: failedCount ?? this.failedCount,
    conflictCount: conflictCount ?? this.conflictCount,
    message: message.present ? message.value : this.message,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  SyncLog copyWithCompanion(SyncLogsCompanion data) {
    return SyncLog(
      id: data.id.present ? data.id.value : this.id,
      trigger: data.trigger.present ? data.trigger.value : this.trigger,
      status: data.status.present ? data.status.value : this.status,
      uploadedCount: data.uploadedCount.present
          ? data.uploadedCount.value
          : this.uploadedCount,
      downloadedCount: data.downloadedCount.present
          ? data.downloadedCount.value
          : this.downloadedCount,
      failedCount: data.failedCount.present
          ? data.failedCount.value
          : this.failedCount,
      conflictCount: data.conflictCount.present
          ? data.conflictCount.value
          : this.conflictCount,
      message: data.message.present ? data.message.value : this.message,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncLog(')
          ..write('id: $id, ')
          ..write('trigger: $trigger, ')
          ..write('status: $status, ')
          ..write('uploadedCount: $uploadedCount, ')
          ..write('downloadedCount: $downloadedCount, ')
          ..write('failedCount: $failedCount, ')
          ..write('conflictCount: $conflictCount, ')
          ..write('message: $message, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    trigger,
    status,
    uploadedCount,
    downloadedCount,
    failedCount,
    conflictCount,
    message,
    startedAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncLog &&
          other.id == this.id &&
          other.trigger == this.trigger &&
          other.status == this.status &&
          other.uploadedCount == this.uploadedCount &&
          other.downloadedCount == this.downloadedCount &&
          other.failedCount == this.failedCount &&
          other.conflictCount == this.conflictCount &&
          other.message == this.message &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt);
}

class SyncLogsCompanion extends UpdateCompanion<SyncLog> {
  final Value<String> id;
  final Value<String> trigger;
  final Value<String> status;
  final Value<int> uploadedCount;
  final Value<int> downloadedCount;
  final Value<int> failedCount;
  final Value<int> conflictCount;
  final Value<String?> message;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const SyncLogsCompanion({
    this.id = const Value.absent(),
    this.trigger = const Value.absent(),
    this.status = const Value.absent(),
    this.uploadedCount = const Value.absent(),
    this.downloadedCount = const Value.absent(),
    this.failedCount = const Value.absent(),
    this.conflictCount = const Value.absent(),
    this.message = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncLogsCompanion.insert({
    required String id,
    required String trigger,
    required String status,
    this.uploadedCount = const Value.absent(),
    this.downloadedCount = const Value.absent(),
    this.failedCount = const Value.absent(),
    this.conflictCount = const Value.absent(),
    this.message = const Value.absent(),
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       trigger = Value(trigger),
       status = Value(status),
       startedAt = Value(startedAt);
  static Insertable<SyncLog> custom({
    Expression<String>? id,
    Expression<String>? trigger,
    Expression<String>? status,
    Expression<int>? uploadedCount,
    Expression<int>? downloadedCount,
    Expression<int>? failedCount,
    Expression<int>? conflictCount,
    Expression<String>? message,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trigger != null) 'trigger': trigger,
      if (status != null) 'status': status,
      if (uploadedCount != null) 'uploaded_count': uploadedCount,
      if (downloadedCount != null) 'downloaded_count': downloadedCount,
      if (failedCount != null) 'failed_count': failedCount,
      if (conflictCount != null) 'conflict_count': conflictCount,
      if (message != null) 'message': message,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? trigger,
    Value<String>? status,
    Value<int>? uploadedCount,
    Value<int>? downloadedCount,
    Value<int>? failedCount,
    Value<int>? conflictCount,
    Value<String?>? message,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return SyncLogsCompanion(
      id: id ?? this.id,
      trigger: trigger ?? this.trigger,
      status: status ?? this.status,
      uploadedCount: uploadedCount ?? this.uploadedCount,
      downloadedCount: downloadedCount ?? this.downloadedCount,
      failedCount: failedCount ?? this.failedCount,
      conflictCount: conflictCount ?? this.conflictCount,
      message: message ?? this.message,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (trigger.present) {
      map['trigger'] = Variable<String>(trigger.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (uploadedCount.present) {
      map['uploaded_count'] = Variable<int>(uploadedCount.value);
    }
    if (downloadedCount.present) {
      map['downloaded_count'] = Variable<int>(downloadedCount.value);
    }
    if (failedCount.present) {
      map['failed_count'] = Variable<int>(failedCount.value);
    }
    if (conflictCount.present) {
      map['conflict_count'] = Variable<int>(conflictCount.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogsCompanion(')
          ..write('id: $id, ')
          ..write('trigger: $trigger, ')
          ..write('status: $status, ')
          ..write('uploadedCount: $uploadedCount, ')
          ..write('downloadedCount: $downloadedCount, ')
          ..write('failedCount: $failedCount, ')
          ..write('conflictCount: $conflictCount, ')
          ..write('message: $message, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTable extends SyncMetadata
    with TableInfo<$SyncMetadataTable, SyncMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SyncMetadataTable createAlias(String alias) {
    return $SyncMetadataTable(attachedDatabase, alias);
  }
}

class SyncMetadataData extends DataClass
    implements Insertable<SyncMetadataData> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const SyncMetadataData({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyncMetadataData copyWith({
    String? key,
    String? value,
    DateTime? updatedAt,
  }) => SyncMetadataData(
    key: key ?? this.key,
    value: value ?? this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SyncMetadataData copyWithCompanion(SyncMetadataCompanion data) {
    return SyncMetadataData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataData &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SyncMetadataCompanion extends UpdateCompanion<SyncMetadataData> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SyncMetadataCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataCompanion.insert({
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SyncMetadataData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SyncMetadataCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FarmersTable farmers = $FarmersTable(this);
  late final $DiseaseReportsTable diseaseReports = $DiseaseReportsTable(this);
  late final $InspectionsTable inspections = $InspectionsTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  late final $PigsTable pigs = $PigsTable(this);
  late final $DispersalsTable dispersals = $DispersalsTable(this);
  late final $OfflineRecordsTable offlineRecords = $OfflineRecordsTable(this);
  late final $OfflinePhotosTable offlinePhotos = $OfflinePhotosTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $SyncLogsTable syncLogs = $SyncLogsTable(this);
  late final $SyncMetadataTable syncMetadata = $SyncMetadataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    farmers,
    diseaseReports,
    inspections,
    notifications,
    pigs,
    dispersals,
    offlineRecords,
    offlinePhotos,
    syncQueue,
    syncLogs,
    syncMetadata,
  ];
}

typedef $$FarmersTableCreateCompanionBuilder = FarmersCompanion Function({
  required String id,
  required String fullName,
  required String contactNumber,
  required double latitude,
  required double longitude,
  Value<bool> isSynced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> createdBy,
  Value<String> fieldWorkerId,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$FarmersTableUpdateCompanionBuilder = FarmersCompanion Function({
  Value<String> id,
  Value<String> fullName,
  Value<String> contactNumber,
  Value<double> latitude,
  Value<double> longitude,
  Value<bool> isSynced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> createdBy,
  Value<String> fieldWorkerId,
  Value<String> syncStatus,
  Value<int> rowid,
});

class $$FarmersTableFilterComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FarmersTableOrderingComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FarmersTableAnnotationComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$FarmersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FarmersTable,
          Farmer,
          $$FarmersTableFilterComposer,
          $$FarmersTableOrderingComposer,
          $$FarmersTableAnnotationComposer,
          $$FarmersTableCreateCompanionBuilder,
          $$FarmersTableUpdateCompanionBuilder,
          (Farmer, BaseReferences<_$AppDatabase, $FarmersTable, Farmer>),
          Farmer,
          PrefetchHooks Function()
        > {
  $$FarmersTableTableManager(_$AppDatabase db, $FarmersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FarmersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FarmersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FarmersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> contactNumber = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FarmersCompanion(
                id: id,
                fullName: fullName,
                contactNumber: contactNumber,
                latitude: latitude,
                longitude: longitude,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fullName,
                required String contactNumber,
                required double latitude,
                required double longitude,
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FarmersCompanion.insert(
                id: id,
                fullName: fullName,
                contactNumber: contactNumber,
                latitude: latitude,
                longitude: longitude,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FarmersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FarmersTable,
      Farmer,
      $$FarmersTableFilterComposer,
      $$FarmersTableOrderingComposer,
      $$FarmersTableAnnotationComposer,
      $$FarmersTableCreateCompanionBuilder,
      $$FarmersTableUpdateCompanionBuilder,
      (Farmer, BaseReferences<_$AppDatabase, $FarmersTable, Farmer>),
      Farmer,
      PrefetchHooks Function()
    >;
typedef $$DiseaseReportsTableCreateCompanionBuilder =
    DiseaseReportsCompanion Function({
      required String id,
      required String pigId,
      required String symptoms,
      required double latitude,
      required double longitude,
      required String photoPath,
      Value<bool> isSynced,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> createdBy,
      Value<String> fieldWorkerId,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$DiseaseReportsTableUpdateCompanionBuilder =
    DiseaseReportsCompanion Function({
      Value<String> id,
      Value<String> pigId,
      Value<String> symptoms,
      Value<double> latitude,
      Value<double> longitude,
      Value<String> photoPath,
      Value<bool> isSynced,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> createdBy,
      Value<String> fieldWorkerId,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$DiseaseReportsTableFilterComposer
    extends Composer<_$AppDatabase, $DiseaseReportsTable> {
  $$DiseaseReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pigId => $composableBuilder(
    column: $table.pigId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DiseaseReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $DiseaseReportsTable> {
  $$DiseaseReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pigId => $composableBuilder(
    column: $table.pigId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DiseaseReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiseaseReportsTable> {
  $$DiseaseReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pigId =>
      $composableBuilder(column: $table.pigId, builder: (column) => column);

  GeneratedColumn<String> get symptoms =>
      $composableBuilder(column: $table.symptoms, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$DiseaseReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiseaseReportsTable,
          DiseaseReport,
          $$DiseaseReportsTableFilterComposer,
          $$DiseaseReportsTableOrderingComposer,
          $$DiseaseReportsTableAnnotationComposer,
          $$DiseaseReportsTableCreateCompanionBuilder,
          $$DiseaseReportsTableUpdateCompanionBuilder,
          (
            DiseaseReport,
            BaseReferences<_$AppDatabase, $DiseaseReportsTable, DiseaseReport>,
          ),
          DiseaseReport,
          PrefetchHooks Function()
        > {
  $$DiseaseReportsTableTableManager(
    _$AppDatabase db,
    $DiseaseReportsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiseaseReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiseaseReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiseaseReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> pigId = const Value.absent(),
                Value<String> symptoms = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String> photoPath = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiseaseReportsCompanion(
                id: id,
                pigId: pigId,
                symptoms: symptoms,
                latitude: latitude,
                longitude: longitude,
                photoPath: photoPath,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pigId,
                required String symptoms,
                required double latitude,
                required double longitude,
                required String photoPath,
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiseaseReportsCompanion.insert(
                id: id,
                pigId: pigId,
                symptoms: symptoms,
                latitude: latitude,
                longitude: longitude,
                photoPath: photoPath,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DiseaseReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiseaseReportsTable,
      DiseaseReport,
      $$DiseaseReportsTableFilterComposer,
      $$DiseaseReportsTableOrderingComposer,
      $$DiseaseReportsTableAnnotationComposer,
      $$DiseaseReportsTableCreateCompanionBuilder,
      $$DiseaseReportsTableUpdateCompanionBuilder,
      (
        DiseaseReport,
        BaseReferences<_$AppDatabase, $DiseaseReportsTable, DiseaseReport>,
      ),
      DiseaseReport,
      PrefetchHooks Function()
    >;
typedef $$InspectionsTableCreateCompanionBuilder =
    InspectionsCompanion Function({
      required String id,
      required String penId,
      required bool wasteManagementCompliant,
      required double wastewaterPh,
      required double coliformLevel,
      required double latitude,
      required double longitude,
      required String photoPath,
      Value<bool> isSynced,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> createdBy,
      Value<String> fieldWorkerId,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$InspectionsTableUpdateCompanionBuilder =
    InspectionsCompanion Function({
      Value<String> id,
      Value<String> penId,
      Value<bool> wasteManagementCompliant,
      Value<double> wastewaterPh,
      Value<double> coliformLevel,
      Value<double> latitude,
      Value<double> longitude,
      Value<String> photoPath,
      Value<bool> isSynced,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> createdBy,
      Value<String> fieldWorkerId,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$InspectionsTableFilterComposer
    extends Composer<_$AppDatabase, $InspectionsTable> {
  $$InspectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get penId => $composableBuilder(
    column: $table.penId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wasteManagementCompliant => $composableBuilder(
    column: $table.wasteManagementCompliant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wastewaterPh => $composableBuilder(
    column: $table.wastewaterPh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get coliformLevel => $composableBuilder(
    column: $table.coliformLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InspectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $InspectionsTable> {
  $$InspectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get penId => $composableBuilder(
    column: $table.penId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wasteManagementCompliant => $composableBuilder(
    column: $table.wasteManagementCompliant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wastewaterPh => $composableBuilder(
    column: $table.wastewaterPh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get coliformLevel => $composableBuilder(
    column: $table.coliformLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InspectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspectionsTable> {
  $$InspectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get penId =>
      $composableBuilder(column: $table.penId, builder: (column) => column);

  GeneratedColumn<bool> get wasteManagementCompliant => $composableBuilder(
    column: $table.wasteManagementCompliant,
    builder: (column) => column,
  );

  GeneratedColumn<double> get wastewaterPh => $composableBuilder(
    column: $table.wastewaterPh,
    builder: (column) => column,
  );

  GeneratedColumn<double> get coliformLevel => $composableBuilder(
    column: $table.coliformLevel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$InspectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InspectionsTable,
          Inspection,
          $$InspectionsTableFilterComposer,
          $$InspectionsTableOrderingComposer,
          $$InspectionsTableAnnotationComposer,
          $$InspectionsTableCreateCompanionBuilder,
          $$InspectionsTableUpdateCompanionBuilder,
          (
            Inspection,
            BaseReferences<_$AppDatabase, $InspectionsTable, Inspection>,
          ),
          Inspection,
          PrefetchHooks Function()
        > {
  $$InspectionsTableTableManager(_$AppDatabase db, $InspectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InspectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InspectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> penId = const Value.absent(),
                Value<bool> wasteManagementCompliant = const Value.absent(),
                Value<double> wastewaterPh = const Value.absent(),
                Value<double> coliformLevel = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String> photoPath = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InspectionsCompanion(
                id: id,
                penId: penId,
                wasteManagementCompliant: wasteManagementCompliant,
                wastewaterPh: wastewaterPh,
                coliformLevel: coliformLevel,
                latitude: latitude,
                longitude: longitude,
                photoPath: photoPath,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String penId,
                required bool wasteManagementCompliant,
                required double wastewaterPh,
                required double coliformLevel,
                required double latitude,
                required double longitude,
                required String photoPath,
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InspectionsCompanion.insert(
                id: id,
                penId: penId,
                wasteManagementCompliant: wasteManagementCompliant,
                wastewaterPh: wastewaterPh,
                coliformLevel: coliformLevel,
                latitude: latitude,
                longitude: longitude,
                photoPath: photoPath,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InspectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InspectionsTable,
      Inspection,
      $$InspectionsTableFilterComposer,
      $$InspectionsTableOrderingComposer,
      $$InspectionsTableAnnotationComposer,
      $$InspectionsTableCreateCompanionBuilder,
      $$InspectionsTableUpdateCompanionBuilder,
      (
        Inspection,
        BaseReferences<_$AppDatabase, $InspectionsTable, Inspection>,
      ),
      Inspection,
      PrefetchHooks Function()
    >;
typedef $$NotificationsTableCreateCompanionBuilder =
    NotificationsCompanion Function({
      required String id,
      Value<String> category,
      Value<String> priority,
      required String title,
      required String message,
      Value<String?> relatedRecordId,
      Value<String?> relatedRecordType,
      Value<bool> isRead,
      Value<DateTime?> readAt,
      required DateTime createdAt,
      Value<DateTime?> scheduledAt,
      Value<String> syncStatus,
      Value<String?> lastError,
      Value<int> rowid,
    });
typedef $$NotificationsTableUpdateCompanionBuilder =
    NotificationsCompanion Function({
      Value<String> id,
      Value<String> category,
      Value<String> priority,
      Value<String> title,
      Value<String> message,
      Value<String?> relatedRecordId,
      Value<String?> relatedRecordType,
      Value<bool> isRead,
      Value<DateTime?> readAt,
      Value<DateTime> createdAt,
      Value<DateTime?> scheduledAt,
      Value<String> syncStatus,
      Value<String?> lastError,
      Value<int> rowid,
    });

class $$NotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relatedRecordId => $composableBuilder(
    column: $table.relatedRecordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relatedRecordType => $composableBuilder(
    column: $table.relatedRecordType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relatedRecordId => $composableBuilder(
    column: $table.relatedRecordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relatedRecordType => $composableBuilder(
    column: $table.relatedRecordType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get relatedRecordId => $composableBuilder(
    column: $table.relatedRecordId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relatedRecordType => $composableBuilder(
    column: $table.relatedRecordType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<DateTime> get readAt =>
      $composableBuilder(column: $table.readAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$NotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationsTable,
          Notification,
          $$NotificationsTableFilterComposer,
          $$NotificationsTableOrderingComposer,
          $$NotificationsTableAnnotationComposer,
          $$NotificationsTableCreateCompanionBuilder,
          $$NotificationsTableUpdateCompanionBuilder,
          (
            Notification,
            BaseReferences<_$AppDatabase, $NotificationsTable, Notification>,
          ),
          Notification,
          PrefetchHooks Function()
        > {
  $$NotificationsTableTableManager(_$AppDatabase db, $NotificationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String?> relatedRecordId = const Value.absent(),
                Value<String?> relatedRecordType = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime?> readAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> scheduledAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationsCompanion(
                id: id,
                category: category,
                priority: priority,
                title: title,
                message: message,
                relatedRecordId: relatedRecordId,
                relatedRecordType: relatedRecordType,
                isRead: isRead,
                readAt: readAt,
                createdAt: createdAt,
                scheduledAt: scheduledAt,
                syncStatus: syncStatus,
                lastError: lastError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> category = const Value.absent(),
                Value<String> priority = const Value.absent(),
                required String title,
                required String message,
                Value<String?> relatedRecordId = const Value.absent(),
                Value<String?> relatedRecordType = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime?> readAt = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> scheduledAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationsCompanion.insert(
                id: id,
                category: category,
                priority: priority,
                title: title,
                message: message,
                relatedRecordId: relatedRecordId,
                relatedRecordType: relatedRecordType,
                isRead: isRead,
                readAt: readAt,
                createdAt: createdAt,
                scheduledAt: scheduledAt,
                syncStatus: syncStatus,
                lastError: lastError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationsTable,
      Notification,
      $$NotificationsTableFilterComposer,
      $$NotificationsTableOrderingComposer,
      $$NotificationsTableAnnotationComposer,
      $$NotificationsTableCreateCompanionBuilder,
      $$NotificationsTableUpdateCompanionBuilder,
      (
        Notification,
        BaseReferences<_$AppDatabase, $NotificationsTable, Notification>,
      ),
      Notification,
      PrefetchHooks Function()
    >;
typedef $$PigsTableCreateCompanionBuilder = PigsCompanion Function({
  required String id,
  required String farmerId,
  required String penId,
  required String breed,
  required double weight,
  Value<bool> isSynced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> createdBy,
  Value<String> fieldWorkerId,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$PigsTableUpdateCompanionBuilder = PigsCompanion Function({
  Value<String> id,
  Value<String> farmerId,
  Value<String> penId,
  Value<String> breed,
  Value<double> weight,
  Value<bool> isSynced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> createdBy,
  Value<String> fieldWorkerId,
  Value<String> syncStatus,
  Value<int> rowid,
});

class $$PigsTableFilterComposer extends Composer<_$AppDatabase, $PigsTable> {
  $$PigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmerId => $composableBuilder(
    column: $table.farmerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get penId => $composableBuilder(
    column: $table.penId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PigsTableOrderingComposer extends Composer<_$AppDatabase, $PigsTable> {
  $$PigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmerId => $composableBuilder(
    column: $table.farmerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get penId => $composableBuilder(
    column: $table.penId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PigsTable> {
  $$PigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get farmerId =>
      $composableBuilder(column: $table.farmerId, builder: (column) => column);

  GeneratedColumn<String> get penId =>
      $composableBuilder(column: $table.penId, builder: (column) => column);

  GeneratedColumn<String> get breed =>
      $composableBuilder(column: $table.breed, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$PigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PigsTable,
          Pig,
          $$PigsTableFilterComposer,
          $$PigsTableOrderingComposer,
          $$PigsTableAnnotationComposer,
          $$PigsTableCreateCompanionBuilder,
          $$PigsTableUpdateCompanionBuilder,
          (Pig, BaseReferences<_$AppDatabase, $PigsTable, Pig>),
          Pig,
          PrefetchHooks Function()
        > {
  $$PigsTableTableManager(_$AppDatabase db, $PigsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> farmerId = const Value.absent(),
                Value<String> penId = const Value.absent(),
                Value<String> breed = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PigsCompanion(
                id: id,
                farmerId: farmerId,
                penId: penId,
                breed: breed,
                weight: weight,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String farmerId,
                required String penId,
                required String breed,
                required double weight,
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PigsCompanion.insert(
                id: id,
                farmerId: farmerId,
                penId: penId,
                breed: breed,
                weight: weight,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PigsTable,
      Pig,
      $$PigsTableFilterComposer,
      $$PigsTableOrderingComposer,
      $$PigsTableAnnotationComposer,
      $$PigsTableCreateCompanionBuilder,
      $$PigsTableUpdateCompanionBuilder,
      (Pig, BaseReferences<_$AppDatabase, $PigsTable, Pig>),
      Pig,
      PrefetchHooks Function()
    >;
typedef $$DispersalsTableCreateCompanionBuilder = DispersalsCompanion Function({
  required String id,
  required String farmerId,
  required String pigId,
  required String condition,
  required String remarks,
  Value<bool> isSynced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> createdBy,
  Value<String> fieldWorkerId,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$DispersalsTableUpdateCompanionBuilder = DispersalsCompanion Function({
  Value<String> id,
  Value<String> farmerId,
  Value<String> pigId,
  Value<String> condition,
  Value<String> remarks,
  Value<bool> isSynced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> createdBy,
  Value<String> fieldWorkerId,
  Value<String> syncStatus,
  Value<int> rowid,
});

class $$DispersalsTableFilterComposer
    extends Composer<_$AppDatabase, $DispersalsTable> {
  $$DispersalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmerId => $composableBuilder(
    column: $table.farmerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pigId => $composableBuilder(
    column: $table.pigId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DispersalsTableOrderingComposer
    extends Composer<_$AppDatabase, $DispersalsTable> {
  $$DispersalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmerId => $composableBuilder(
    column: $table.farmerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pigId => $composableBuilder(
    column: $table.pigId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DispersalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DispersalsTable> {
  $$DispersalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get farmerId =>
      $composableBuilder(column: $table.farmerId, builder: (column) => column);

  GeneratedColumn<String> get pigId =>
      $composableBuilder(column: $table.pigId, builder: (column) => column);

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$DispersalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DispersalsTable,
          Dispersal,
          $$DispersalsTableFilterComposer,
          $$DispersalsTableOrderingComposer,
          $$DispersalsTableAnnotationComposer,
          $$DispersalsTableCreateCompanionBuilder,
          $$DispersalsTableUpdateCompanionBuilder,
          (
            Dispersal,
            BaseReferences<_$AppDatabase, $DispersalsTable, Dispersal>,
          ),
          Dispersal,
          PrefetchHooks Function()
        > {
  $$DispersalsTableTableManager(_$AppDatabase db, $DispersalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DispersalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DispersalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DispersalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> farmerId = const Value.absent(),
                Value<String> pigId = const Value.absent(),
                Value<String> condition = const Value.absent(),
                Value<String> remarks = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DispersalsCompanion(
                id: id,
                farmerId: farmerId,
                pigId: pigId,
                condition: condition,
                remarks: remarks,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String farmerId,
                required String pigId,
                required String condition,
                required String remarks,
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DispersalsCompanion.insert(
                id: id,
                farmerId: farmerId,
                pigId: pigId,
                condition: condition,
                remarks: remarks,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DispersalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DispersalsTable,
      Dispersal,
      $$DispersalsTableFilterComposer,
      $$DispersalsTableOrderingComposer,
      $$DispersalsTableAnnotationComposer,
      $$DispersalsTableCreateCompanionBuilder,
      $$DispersalsTableUpdateCompanionBuilder,
      (Dispersal, BaseReferences<_$AppDatabase, $DispersalsTable, Dispersal>),
      Dispersal,
      PrefetchHooks Function()
    >;
typedef $$OfflineRecordsTableCreateCompanionBuilder =
    OfflineRecordsCompanion Function({
      required String id,
      required String recordType,
      required String payload,
      required double latitude,
      required double longitude,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String createdBy,
      required String fieldWorkerId,
      Value<String> syncStatus,
      Value<String?> syncError,
      Value<String?> serverRecordId,
      Value<DateTime?> serverUpdatedAt,
      Value<int> rowid,
    });
typedef $$OfflineRecordsTableUpdateCompanionBuilder =
    OfflineRecordsCompanion Function({
      Value<String> id,
      Value<String> recordType,
      Value<String> payload,
      Value<double> latitude,
      Value<double> longitude,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> createdBy,
      Value<String> fieldWorkerId,
      Value<String> syncStatus,
      Value<String?> syncError,
      Value<String?> serverRecordId,
      Value<DateTime?> serverUpdatedAt,
      Value<int> rowid,
    });

class $$OfflineRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $OfflineRecordsTable> {
  $$OfflineRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverRecordId => $composableBuilder(
    column: $table.serverRecordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OfflineRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $OfflineRecordsTable> {
  $$OfflineRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverRecordId => $composableBuilder(
    column: $table.serverRecordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OfflineRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OfflineRecordsTable> {
  $$OfflineRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncError =>
      $composableBuilder(column: $table.syncError, builder: (column) => column);

  GeneratedColumn<String> get serverRecordId => $composableBuilder(
    column: $table.serverRecordId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get serverUpdatedAt => $composableBuilder(
    column: $table.serverUpdatedAt,
    builder: (column) => column,
  );
}

class $$OfflineRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OfflineRecordsTable,
          OfflineRecord,
          $$OfflineRecordsTableFilterComposer,
          $$OfflineRecordsTableOrderingComposer,
          $$OfflineRecordsTableAnnotationComposer,
          $$OfflineRecordsTableCreateCompanionBuilder,
          $$OfflineRecordsTableUpdateCompanionBuilder,
          (
            OfflineRecord,
            BaseReferences<_$AppDatabase, $OfflineRecordsTable, OfflineRecord>,
          ),
          OfflineRecord,
          PrefetchHooks Function()
        > {
  $$OfflineRecordsTableTableManager(
    _$AppDatabase db,
    $OfflineRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OfflineRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OfflineRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OfflineRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> recordType = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<String?> serverRecordId = const Value.absent(),
                Value<DateTime?> serverUpdatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OfflineRecordsCompanion(
                id: id,
                recordType: recordType,
                payload: payload,
                latitude: latitude,
                longitude: longitude,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                syncError: syncError,
                serverRecordId: serverRecordId,
                serverUpdatedAt: serverUpdatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String recordType,
                required String payload,
                required double latitude,
                required double longitude,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String createdBy,
                required String fieldWorkerId,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<String?> serverRecordId = const Value.absent(),
                Value<DateTime?> serverUpdatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OfflineRecordsCompanion.insert(
                id: id,
                recordType: recordType,
                payload: payload,
                latitude: latitude,
                longitude: longitude,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                syncError: syncError,
                serverRecordId: serverRecordId,
                serverUpdatedAt: serverUpdatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OfflineRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OfflineRecordsTable,
      OfflineRecord,
      $$OfflineRecordsTableFilterComposer,
      $$OfflineRecordsTableOrderingComposer,
      $$OfflineRecordsTableAnnotationComposer,
      $$OfflineRecordsTableCreateCompanionBuilder,
      $$OfflineRecordsTableUpdateCompanionBuilder,
      (
        OfflineRecord,
        BaseReferences<_$AppDatabase, $OfflineRecordsTable, OfflineRecord>,
      ),
      OfflineRecord,
      PrefetchHooks Function()
    >;
typedef $$OfflinePhotosTableCreateCompanionBuilder =
    OfflinePhotosCompanion Function({
      required String id,
      required String recordId,
      Value<String> recordType,
      required String filePath,
      required String mimeType,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String createdBy,
      required String fieldWorkerId,
      Value<String> syncStatus,
      Value<String?> syncError,
      Value<String?> serverFileId,
      Value<String?> serverFileUrl,
      Value<String> verificationStatus,
      Value<int> rowid,
    });
typedef $$OfflinePhotosTableUpdateCompanionBuilder =
    OfflinePhotosCompanion Function({
      Value<String> id,
      Value<String> recordId,
      Value<String> recordType,
      Value<String> filePath,
      Value<String> mimeType,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> createdBy,
      Value<String> fieldWorkerId,
      Value<String> syncStatus,
      Value<String?> syncError,
      Value<String?> serverFileId,
      Value<String?> serverFileUrl,
      Value<String> verificationStatus,
      Value<int> rowid,
    });

class $$OfflinePhotosTableFilterComposer
    extends Composer<_$AppDatabase, $OfflinePhotosTable> {
  $$OfflinePhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverFileId => $composableBuilder(
    column: $table.serverFileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverFileUrl => $composableBuilder(
    column: $table.serverFileUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verificationStatus => $composableBuilder(
    column: $table.verificationStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OfflinePhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $OfflinePhotosTable> {
  $$OfflinePhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverFileId => $composableBuilder(
    column: $table.serverFileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverFileUrl => $composableBuilder(
    column: $table.serverFileUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verificationStatus => $composableBuilder(
    column: $table.verificationStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OfflinePhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $OfflinePhotosTable> {
  $$OfflinePhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncError =>
      $composableBuilder(column: $table.syncError, builder: (column) => column);

  GeneratedColumn<String> get serverFileId => $composableBuilder(
    column: $table.serverFileId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverFileUrl => $composableBuilder(
    column: $table.serverFileUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get verificationStatus => $composableBuilder(
    column: $table.verificationStatus,
    builder: (column) => column,
  );
}

class $$OfflinePhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OfflinePhotosTable,
          OfflinePhoto,
          $$OfflinePhotosTableFilterComposer,
          $$OfflinePhotosTableOrderingComposer,
          $$OfflinePhotosTableAnnotationComposer,
          $$OfflinePhotosTableCreateCompanionBuilder,
          $$OfflinePhotosTableUpdateCompanionBuilder,
          (
            OfflinePhoto,
            BaseReferences<_$AppDatabase, $OfflinePhotosTable, OfflinePhoto>,
          ),
          OfflinePhoto,
          PrefetchHooks Function()
        > {
  $$OfflinePhotosTableTableManager(_$AppDatabase db, $OfflinePhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OfflinePhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OfflinePhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OfflinePhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<String> recordType = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<String?> serverFileId = const Value.absent(),
                Value<String?> serverFileUrl = const Value.absent(),
                Value<String> verificationStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OfflinePhotosCompanion(
                id: id,
                recordId: recordId,
                recordType: recordType,
                filePath: filePath,
                mimeType: mimeType,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                syncError: syncError,
                serverFileId: serverFileId,
                serverFileUrl: serverFileUrl,
                verificationStatus: verificationStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String recordId,
                Value<String> recordType = const Value.absent(),
                required String filePath,
                required String mimeType,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String createdBy,
                required String fieldWorkerId,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<String?> serverFileId = const Value.absent(),
                Value<String?> serverFileUrl = const Value.absent(),
                Value<String> verificationStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OfflinePhotosCompanion.insert(
                id: id,
                recordId: recordId,
                recordType: recordType,
                filePath: filePath,
                mimeType: mimeType,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                syncStatus: syncStatus,
                syncError: syncError,
                serverFileId: serverFileId,
                serverFileUrl: serverFileUrl,
                verificationStatus: verificationStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OfflinePhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OfflinePhotosTable,
      OfflinePhoto,
      $$OfflinePhotosTableFilterComposer,
      $$OfflinePhotosTableOrderingComposer,
      $$OfflinePhotosTableAnnotationComposer,
      $$OfflinePhotosTableCreateCompanionBuilder,
      $$OfflinePhotosTableUpdateCompanionBuilder,
      (
        OfflinePhoto,
        BaseReferences<_$AppDatabase, $OfflinePhotosTable, OfflinePhoto>,
      ),
      OfflinePhoto,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  required String endpoint,
  required String method,
  required String payload,
  Value<String> status,
  Value<String> syncStatus,
  Value<String?> recordId,
  Value<String?> recordType,
  Value<String> createdBy,
  Value<String> fieldWorkerId,
  Value<int> retryCount,
  Value<String?> lastError,
  Value<DateTime?> lastAttemptAt,
  Value<DateTime?> nextAttemptAt,
  Value<String?> serverRecordId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<String> endpoint,
  Value<String> method,
  Value<String> payload,
  Value<String> status,
  Value<String> syncStatus,
  Value<String?> recordId,
  Value<String?> recordType,
  Value<String> createdBy,
  Value<String> fieldWorkerId,
  Value<int> retryCount,
  Value<String?> lastError,
  Value<DateTime?> lastAttemptAt,
  Value<DateTime?> nextAttemptAt,
  Value<String?> serverRecordId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endpoint => $composableBuilder(
    column: $table.endpoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverRecordId => $composableBuilder(
    column: $table.serverRecordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endpoint => $composableBuilder(
    column: $table.endpoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverRecordId => $composableBuilder(
    column: $table.serverRecordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get endpoint =>
      $composableBuilder(column: $table.endpoint, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get fieldWorkerId => $composableBuilder(
    column: $table.fieldWorkerId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverRecordId => $composableBuilder(
    column: $table.serverRecordId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> endpoint = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> recordId = const Value.absent(),
                Value<String?> recordType = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> nextAttemptAt = const Value.absent(),
                Value<String?> serverRecordId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                endpoint: endpoint,
                method: method,
                payload: payload,
                status: status,
                syncStatus: syncStatus,
                recordId: recordId,
                recordType: recordType,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                retryCount: retryCount,
                lastError: lastError,
                lastAttemptAt: lastAttemptAt,
                nextAttemptAt: nextAttemptAt,
                serverRecordId: serverRecordId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String endpoint,
                required String method,
                required String payload,
                Value<String> status = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> recordId = const Value.absent(),
                Value<String?> recordType = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> fieldWorkerId = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> nextAttemptAt = const Value.absent(),
                Value<String?> serverRecordId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                endpoint: endpoint,
                method: method,
                payload: payload,
                status: status,
                syncStatus: syncStatus,
                recordId: recordId,
                recordType: recordType,
                createdBy: createdBy,
                fieldWorkerId: fieldWorkerId,
                retryCount: retryCount,
                lastError: lastError,
                lastAttemptAt: lastAttemptAt,
                nextAttemptAt: nextAttemptAt,
                serverRecordId: serverRecordId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$SyncLogsTableCreateCompanionBuilder = SyncLogsCompanion Function({
  required String id,
  required String trigger,
  required String status,
  Value<int> uploadedCount,
  Value<int> downloadedCount,
  Value<int> failedCount,
  Value<int> conflictCount,
  Value<String?> message,
  required DateTime startedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$SyncLogsTableUpdateCompanionBuilder = SyncLogsCompanion Function({
  Value<String> id,
  Value<String> trigger,
  Value<String> status,
  Value<int> uploadedCount,
  Value<int> downloadedCount,
  Value<int> failedCount,
  Value<int> conflictCount,
  Value<String?> message,
  Value<DateTime> startedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

class $$SyncLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncLogsTable> {
  $$SyncLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get uploadedCount => $composableBuilder(
    column: $table.uploadedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get downloadedCount => $composableBuilder(
    column: $table.downloadedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get failedCount => $composableBuilder(
    column: $table.failedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get conflictCount => $composableBuilder(
    column: $table.conflictCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncLogsTable> {
  $$SyncLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get uploadedCount => $composableBuilder(
    column: $table.uploadedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get downloadedCount => $composableBuilder(
    column: $table.downloadedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get failedCount => $composableBuilder(
    column: $table.failedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get conflictCount => $composableBuilder(
    column: $table.conflictCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncLogsTable> {
  $$SyncLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get trigger =>
      $composableBuilder(column: $table.trigger, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get uploadedCount => $composableBuilder(
    column: $table.uploadedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get downloadedCount => $composableBuilder(
    column: $table.downloadedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get failedCount => $composableBuilder(
    column: $table.failedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get conflictCount => $composableBuilder(
    column: $table.conflictCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$SyncLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncLogsTable,
          SyncLog,
          $$SyncLogsTableFilterComposer,
          $$SyncLogsTableOrderingComposer,
          $$SyncLogsTableAnnotationComposer,
          $$SyncLogsTableCreateCompanionBuilder,
          $$SyncLogsTableUpdateCompanionBuilder,
          (SyncLog, BaseReferences<_$AppDatabase, $SyncLogsTable, SyncLog>),
          SyncLog,
          PrefetchHooks Function()
        > {
  $$SyncLogsTableTableManager(_$AppDatabase db, $SyncLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> trigger = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> uploadedCount = const Value.absent(),
                Value<int> downloadedCount = const Value.absent(),
                Value<int> failedCount = const Value.absent(),
                Value<int> conflictCount = const Value.absent(),
                Value<String?> message = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncLogsCompanion(
                id: id,
                trigger: trigger,
                status: status,
                uploadedCount: uploadedCount,
                downloadedCount: downloadedCount,
                failedCount: failedCount,
                conflictCount: conflictCount,
                message: message,
                startedAt: startedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String trigger,
                required String status,
                Value<int> uploadedCount = const Value.absent(),
                Value<int> downloadedCount = const Value.absent(),
                Value<int> failedCount = const Value.absent(),
                Value<int> conflictCount = const Value.absent(),
                Value<String?> message = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncLogsCompanion.insert(
                id: id,
                trigger: trigger,
                status: status,
                uploadedCount: uploadedCount,
                downloadedCount: downloadedCount,
                failedCount: failedCount,
                conflictCount: conflictCount,
                message: message,
                startedAt: startedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncLogsTable,
      SyncLog,
      $$SyncLogsTableFilterComposer,
      $$SyncLogsTableOrderingComposer,
      $$SyncLogsTableAnnotationComposer,
      $$SyncLogsTableCreateCompanionBuilder,
      $$SyncLogsTableUpdateCompanionBuilder,
      (SyncLog, BaseReferences<_$AppDatabase, $SyncLogsTable, SyncLog>),
      SyncLog,
      PrefetchHooks Function()
    >;
typedef $$SyncMetadataTableCreateCompanionBuilder =
    SyncMetadataCompanion Function({
      required String key,
      required String value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SyncMetadataTableUpdateCompanionBuilder =
    SyncMetadataCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SyncMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetadataTable,
          SyncMetadataData,
          $$SyncMetadataTableFilterComposer,
          $$SyncMetadataTableOrderingComposer,
          $$SyncMetadataTableAnnotationComposer,
          $$SyncMetadataTableCreateCompanionBuilder,
          $$SyncMetadataTableUpdateCompanionBuilder,
          (
            SyncMetadataData,
            BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>,
          ),
          SyncMetadataData,
          PrefetchHooks Function()
        > {
  $$SyncMetadataTableTableManager(_$AppDatabase db, $SyncMetadataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetadataTable,
      SyncMetadataData,
      $$SyncMetadataTableFilterComposer,
      $$SyncMetadataTableOrderingComposer,
      $$SyncMetadataTableAnnotationComposer,
      $$SyncMetadataTableCreateCompanionBuilder,
      $$SyncMetadataTableUpdateCompanionBuilder,
      (
        SyncMetadataData,
        BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>,
      ),
      SyncMetadataData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FarmersTableTableManager get farmers =>
      $$FarmersTableTableManager(_db, _db.farmers);
  $$DiseaseReportsTableTableManager get diseaseReports =>
      $$DiseaseReportsTableTableManager(_db, _db.diseaseReports);
  $$InspectionsTableTableManager get inspections =>
      $$InspectionsTableTableManager(_db, _db.inspections);
  $$NotificationsTableTableManager get notifications =>
      $$NotificationsTableTableManager(_db, _db.notifications);
  $$PigsTableTableManager get pigs => $$PigsTableTableManager(_db, _db.pigs);
  $$DispersalsTableTableManager get dispersals =>
      $$DispersalsTableTableManager(_db, _db.dispersals);
  $$OfflineRecordsTableTableManager get offlineRecords =>
      $$OfflineRecordsTableTableManager(_db, _db.offlineRecords);
  $$OfflinePhotosTableTableManager get offlinePhotos =>
      $$OfflinePhotosTableTableManager(_db, _db.offlinePhotos);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$SyncLogsTableTableManager get syncLogs =>
      $$SyncLogsTableTableManager(_db, _db.syncLogs);
  $$SyncMetadataTableTableManager get syncMetadata =>
      $$SyncMetadataTableTableManager(_db, _db.syncMetadata);
}
