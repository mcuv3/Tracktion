import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

enum CopyMethod { Previus, Smart, Manual }

class RoutineGroup extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().withLength(max: 250, min:0)();
}

class Routine extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get groupId =>
      integer().customConstraint("NOT NULL REFERENCES grouproutines (id)")();
  TextColumn get name => text()();
}


class RoutineSet extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseId =>
      integer().customConstraint("NOT NULL REFERENCES exercises (id)")();
  IntColumn get routineId =>
      integer().customConstraint("NOT NULL REFERENCES routines (id)")();
  IntColumn get reps => integer()();
  IntColumn get copyMethod => intEnum<CopyMethod>()();
  IntColumn get targetRpe => integer()();
}

class RoutineRep extends Table {
    IntColumn get id => integer().autoIncrement()();
  RealColumn get weight => real()();
  IntColumn get reps => integer()();
  IntColumn get rpe => integer()();
  TextColumn get note => text()();
  IntColumn get setId =>
      integer().customConstraint("NOT NULL REFERENCES routinesets (id)")();
}
