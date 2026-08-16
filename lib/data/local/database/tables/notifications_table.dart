import 'package:drift/drift.dart';

/// Server notification cache. Read state is retained locally for offline use.
class Notifications extends Table {
  TextColumn get id => text()();
  TextColumn get category => text().withDefault(const Constant('system'))();
  TextColumn get priority => text().withDefault(const Constant('normal'))();
  TextColumn get title => text()();
  TextColumn get message => text()();
  TextColumn get relatedRecordId => text().nullable()();
  TextColumn get relatedRecordType => text().nullable()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  DateTimeColumn get readAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get scheduledAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  TextColumn get lastError => text().nullable()();
  @override Set<Column<Object>> get primaryKey => {id};
}
