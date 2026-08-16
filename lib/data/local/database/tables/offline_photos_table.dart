import 'package:drift/drift.dart';

class OfflinePhotos extends Table {
  TextColumn get id => text()();

  TextColumn get recordId => text()();

  /// The owning domain record type, used when evidence is queued separately
  /// from the original field record.
  TextColumn get recordType => text().withDefault(const Constant(''))();

  TextColumn get filePath => text()();

  TextColumn get mimeType => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get createdBy => text()();

  TextColumn get fieldWorkerId => text()();

  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  TextColumn get syncError => text().nullable()();

  TextColumn get serverFileId => text().nullable()();

  TextColumn get serverFileUrl => text().nullable()();

  /// Review workflow state from the secure media service. Sync status remains
  /// independent so pending uploads are never confused with review decisions.
  TextColumn get verificationStatus =>
      text().withDefault(const Constant('verification_required'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
