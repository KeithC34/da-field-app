import 'package:drift/drift.dart';

class SyncLogs extends Table {
  TextColumn get id => text()();

  TextColumn get trigger => text()();

  TextColumn get status => text()();

  IntColumn get uploadedCount => integer().withDefault(const Constant(0))();

  IntColumn get downloadedCount => integer().withDefault(const Constant(0))();

  IntColumn get failedCount => integer().withDefault(const Constant(0))();

  IntColumn get conflictCount => integer().withDefault(const Constant(0))();

  TextColumn get message => text().nullable()();

  DateTimeColumn get startedAt => dateTime()();

  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
