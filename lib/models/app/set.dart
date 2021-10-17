import 'package:flutter/foundation.dart';

import './index.dart';

class SetWorkout {
  int id;
  Exercise exercise;
  double maxWeight;
  double volume;
  List<Rep> reps;
  SetWorkout({
    @required this.id,
    @required this.exercise,
    @required this.reps,
    @required this.maxWeight,
    @required this.volume,
  });

  void cleanIds() {
    this.id = null;
    for (final rep in this.reps) rep.id = null;
  }

  @override
  String toString() {
    return "{Exe:${this.exercise.name} reps:${this.reps.length} maxWeight:${this.maxWeight} volume:${this.volume}}";
  }
}
