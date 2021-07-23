import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

class Workouts extends Table {
  IntColumn get  id => integer().autoIncrement()() ;
  DateTimeColumn get date => dateTime()();
}

class SetWorkouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get volume => real()();
  RealColumn get maxWeigth => real()();
  IntColumn get workOutId =>
      integer().customConstraint("NOT NULL REFERENCES workouts (id)")();
  IntColumn get exerciseId =>
      integer().customConstraint("NOT NULL REFERENCES exercises (id)")();
}

class Reps extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get weight => real()();
  IntColumn get reps => integer()();
  IntColumn get rpe => integer()();
  TextColumn get note =>
      text().withLength(max: 155).withDefault(const Constant(""))();
  IntColumn get setId =>
      integer().customConstraint("NOT NULL REFERENCES sets (id)")();
}
