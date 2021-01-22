import 'package:flutter/foundation.dart';

import './index.dart';

class SetWorkout {
  int id;
  final Exercise exercise;
  double maxWeigth;
  double volume;
  List<Rep> reps;
  SetWorkout({
    @required this.id,
    @required this.exercise,
    @required this.reps,
    @required this.maxWeigth,
    @required this.volume,
  });

  void cleanIds() {
    this.id = null;
    for (final rep in this.reps) rep.id = null;
  }
}
