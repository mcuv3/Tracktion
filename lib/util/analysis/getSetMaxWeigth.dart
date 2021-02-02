import 'package:tracktion/models/app/index.dart';

double getSetMaxWeigth(List<Rep> reps) {
  var _reps = [...reps];

  if (_reps.length == 0) return 0.0;

  if (_reps.length == 1) return reps[1].weight;

  _reps.sort((r1, r2) => r2.weight.compareTo(r1.weight));

  return _reps[0].weight;
}
