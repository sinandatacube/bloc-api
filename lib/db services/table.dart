import 'package:drift/drift.dart';

@DataClassName('Bag')
class Bags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productId => text()();
  TextColumn get quantity => text()();
}
