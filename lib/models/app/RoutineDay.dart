import 'package:tracktion/models/db/database.dart';

class RoutineDay {
  final RoutineData routine;
  List<RoutineSetData> sets = [];

  RoutineDay({this.routine, this.sets});

  int get numSeries =>
      sets.fold(0, (previousValue, s) => previousValue += s.series);

  int get numExercises => sets.length;

  void add(RoutineSetData set) => this.sets.add(set);
}
