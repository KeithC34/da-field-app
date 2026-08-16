import 'package:drift/drift.dart';

class Inspections extends Table {
  TextColumn get id => text()();

  TextColumn get penId => text()();

  BoolColumn get wasteManagementCompliant => boolean()();

  RealColumn get wastewaterPh => real()();

  RealColumn get coliformLevel => real()();

  RealColumn get latitude => real()();

  RealColumn get longitude => real()();

  TextColumn get photoPath => text()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get createdBy => text().withDefault(const Constant('legacy'))();

  TextColumn get fieldWorkerId =>
      text().withDefault(const Constant('legacy'))();

  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
