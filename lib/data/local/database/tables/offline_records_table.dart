import 'package:drift/drift.dart';

class OfflineRecords extends Table {
  TextColumn get id => text()();

  TextColumn get recordType => text()();

  TextColumn get payload => text()();

  RealColumn get latitude => real()();

  RealColumn get longitude => real()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get createdBy => text()();

  TextColumn get fieldWorkerId => text()();

  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  TextColumn get syncError => text().nullable()();

  TextColumn get serverRecordId => text().nullable()();

  DateTimeColumn get serverUpdatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
