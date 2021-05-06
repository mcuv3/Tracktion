import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tracktion/models/tables/Converts.dart';

enum CopyMethod { Previus, Static, Smart, Percentage }
enum Level { Pro, Advance, Normal, Beginner }
enum Difficulty { Easy, Normal, Hard, Pro }

class RoutineGroup extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().withLength(max: 250, min: 0)();
  TextColumn get imageUrl => text()();
  IntColumn get level => intEnum<Level>()();
}

class Routine extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get groupId =>
      integer().customConstraint("NOT NULL REFERENCES grouproutines (id)")();
  TextColumn get name => text()();
  IntColumn get duration => integer()();
  IntColumn get difficulty => intEnum<Difficulty>()();
  TextColumn get notes =>
      text().withLength(max: 155).withDefault(const Constant(""))();
  IntColumn get timesCopied => integer().withDefault(const Constant(0))();
  TextColumn get bodyParts =>
      text().map(const RoutineBodyPartsConverter()).nullable()();
}

class RoutineSet extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseName => text()();
  IntColumn get exerciseId =>
      integer().customConstraint("NOT NULL REFERENCES exercises (id)")();
  IntColumn get routineId =>
      integer().customConstraint("NOT NULL REFERENCES routines (id)")();
  IntColumn get series => integer().withDefault(const Constant(3))();
  RealColumn get repmax => real().nullable()();
  IntColumn get copyMethod => intEnum<CopyMethod>()();
  IntColumn get targetRpe => integer()();
  TextColumn get notes =>
      text().withLength(max: 155).withDefault(const Constant(""))();
}
