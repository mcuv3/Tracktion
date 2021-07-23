import './index.dart';

class SetWorkout {
  int? id;
  final Exercise exercise;
  double maxWeigth;
  double volume;
  List<Rep> reps;
  SetWorkout({
    this.id,
    required this.exercise,
    required this.reps,
    required this.maxWeigth,
    required this.volume,
  });

  void cleanIds() {
    this.id = null;
    for (final rep in this.reps) rep.id = null;
  }

  @override
  String toString() {
    return "{Exe:${this.exercise.name} reps:${this.reps.length} maxWeigth:${this.maxWeigth} volume:${this.volume}}";
  }
}
