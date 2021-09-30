import 'package:tracktion/models/app/exercise.dart';

List<SetResume> mergeSetLastWorkouts(
    {Exercise exe, double volume, double maxWeight, DateTime date}) {
  var _sets = [...exe.lastWorkouts];

  if (exe.lastWorkouts.length >= 12) exe.lastWorkouts.removeAt(11);
  if (volume > exe.maxVolume) exe.maxVolume = volume;
  if (maxWeight > exe.maxWeigth) exe.maxWeigth = maxWeight;
  _sets.insert(0, SetResume(date: date, maxWeigth: maxWeight, volume: volume));
  return _sets;
}

Exercise syncMaxes(
    {Exercise exe,
    double volume,
    double maxWeight,
    bool willDelete = false,
    int setId}) {
  if (exe.lastWorkouts.length == 0) {
    exe.maxVolumeSetId = null;
    exe.maxWeigthSetId = null;
    exe.maxVolume = 0.0;
    exe.maxWeigth = 0.0;
  } else if (!willDelete) {
    if (volume > exe.maxVolume) {
      exe.maxVolume = volume;
      exe.maxVolumeSetId = setId;
    }
    if (maxWeight > exe.maxWeigth) {
      exe.maxWeigth = maxWeight;
      exe.maxWeigthSetId = setId;
    }
  }
  return exe;
}
