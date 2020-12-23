import 'package:tracktion/models/db/database.dart';

class Set {
  final Workout workout;
  final Exercise exercise;
  final List<Rep> reps;
  Set({ this.workout, this.exercise, this.reps});
}
