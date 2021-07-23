import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tracktion/models/app/body-parts.dart';
import 'package:tracktion/models/app/difficulties.dart';

class Migrations extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get endPoint => text()();
  TextColumn get payload => text()();
  TextColumn get verb => text()();
}

class Exercises extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get lastWorkouts => text()();
  RealColumn get maxVolume => real().nullable().withDefault(const Constant(0.0))();
  RealColumn get maxWeigth => real().nullable().withDefault(const Constant(0.0))();
  IntColumn get maxWeigthSetId => integer().nullable()();
  IntColumn get maxVolumeSetId => integer().nullable()();
  TextColumn get notes => text().withLength(max: 200).nullable()();
  IntColumn get difficulty => intEnum<Difficulty>()();
}

class ExerciseBodyParts extends Table {
  IntColumn get exerciseId =>
      integer().customConstraint("NOT NULL REFERENCES exercises (id)")();
  IntColumn get bodyPart => intEnum<BodyPartEnum>()();
}
