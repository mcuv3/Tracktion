import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

enum CopyMethod { Previus, Smart, Manual }
enum Theme { Black, Blue, Yellow, Orange, Green }

class RoutineGroup extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().withLength(max: 250, min: 0)();
  TextColumn get imageUrl => text()();
  IntColumn get theme => intEnum<Theme>()();
}

class Routine extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get groupId =>
      integer().customConstraint("NOT NULL REFERENCES grouproutines (id)")();
  TextColumn get name => text()();
  TextColumn get notes =>
      text().withLength(max: 155).withDefault(const Constant(""))();
}

class RoutineSet extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseName => text()();
  IntColumn get exerciseId =>
      integer().customConstraint("NOT NULL REFERENCES exercises (id)")();
  IntColumn get routineId =>
      integer().customConstraint("NOT NULL REFERENCES routines (id)")();
  IntColumn get reps => integer()();
  IntColumn get copyMethod => intEnum<CopyMethod>()();
  IntColumn get targetRpe => integer()();
  TextColumn get notes =>
      text().withLength(max: 155).withDefault(const Constant(""))();
}
