import 'package:tracktion/models/app/index.dart';

double getSetMaxWeigth(List<Rep> reps) {
  var _reps = [...reps];

  if (_reps.length == 0) return 0.0;

  if (_reps.length == 1) return reps[0].weight;

  _reps.sort((r1, r2) => r2.weight.compareTo(r1.weight));

  return _reps[0].weight;
}

List<double> getMaxVolume(List<SetResume> sets) {
  var _sets = [...sets];

  if (_sets.length == 0) return [0.0, 0.0];

  if (_sets.length == 1) return [sets[0].volume, sets[0].volume];

  _sets.sort((s1, s2) => s2.volume.compareTo(s1.volume));

  return [_sets[0].volume, _sets[_sets.length - 1].volume];
}

List<double> getMaxWeigth(List<SetResume> sets) {
  var _sets = [...sets];

  if (_sets.length == 0) return [0.0, 0.0];

  if (_sets.length == 1) return [sets[0].maxWeigth, sets[0].maxWeigth];

  _sets.sort((s1, s2) => s2.maxWeigth.compareTo(s1.maxWeigth));

  return [_sets[0].maxWeigth, _sets[_sets.length - 1].maxWeigth];
}
