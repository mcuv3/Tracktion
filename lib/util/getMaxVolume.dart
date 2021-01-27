import 'package:tracktion/models/app/index.dart';

SetResume getMaxVolume(List<SetResume> sets) {
  var _sets = [...sets];
  if (_sets.length == 0) return null;
  if (_sets.length == 1) return sets[1];
  _sets.sort((s1, s2) => s1.volume.compareTo(s2.volume));
  return _sets[0];
}
