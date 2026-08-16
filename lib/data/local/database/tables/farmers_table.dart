import 'package:drift/drift.dart';

class Farmers extends Table {
  TextColumn get id => text()();

  TextColumn get fullName => text()();

  TextColumn get contactNumber => text()();

  RealColumn get latitude => real()();

  RealColumn get longitude => real()();

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
