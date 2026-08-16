import 'package:drift/drift.dart';

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get endpoint => text()();

  TextColumn get method => text()();

  TextColumn get payload => text()();

  TextColumn get status => text().withDefault(const Constant('pending'))();

  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  TextColumn get recordId => text().nullable()();

  TextColumn get recordType => text().nullable()();

  TextColumn get createdBy => text().withDefault(const Constant('legacy'))();

  TextColumn get fieldWorkerId =>
      text().withDefault(const Constant('legacy'))();

  IntColumn get retryCount => integer().withDefault(const Constant(0))();

  TextColumn get lastError => text().nullable()();

  DateTimeColumn get lastAttemptAt => dateTime().nullable()();

  DateTimeColumn get nextAttemptAt => dateTime().nullable()();

  TextColumn get serverRecordId => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
