import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tracktion/models/body-parts.dart';
import 'package:tracktion/models/difficulties.dart';

// @DataClassName(name)
class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get notes => text().withLength(min: 1, max: 200)();
  IntColumn get difficulty => intEnum<Difficulty>()();
}

class ExerciseBodyParts extends Table {
  IntColumn get exerciseId => integer()();
  IntColumn get bodyPart => intEnum<BodyPartEnum>()();
}

// class BodyParts extends Table {
//   IntColumn get id => integer().autoIncrement()();
// }
