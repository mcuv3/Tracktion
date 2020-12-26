import 'package:flutter/foundation.dart';

import './index.dart';

class SetWorkout {
  final int id;
  final Exercise exercise;
   List<Rep> reps;
  SetWorkout({@required this.id,@required this.exercise,@required this.reps});
}
