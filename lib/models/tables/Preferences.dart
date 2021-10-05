import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

class Preferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text()();
  TextColumn get value => text()();
}
