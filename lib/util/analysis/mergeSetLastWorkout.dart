import 'package:tracktion/models/app/exercise.dart';

List<SetResume> mergeSetLastWorkouts(
    {Exercise exe, double volume, double maxWeight, DateTime date}) {
  var _sets = [...exe.lastWorkouts];

  if (exe.lastWorkouts.length >= 12) exe.lastWorkouts.removeAt(11);
  if (volume > exe.maxVolume) exe.maxVolume = volume;
  if (maxWeight > exe.maxWeight) exe.maxWeight = maxWeight;
  _sets.insert(0, SetResume(date: date, maxWeight: maxWeight, volume: volume));
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
    exe.maxWeightSetId = null;
    exe.maxVolume = 0.0;
    exe.maxWeight = 0.0;
  } else if (!willDelete) {
    if (volume > exe.maxVolume) {
      exe.maxVolume = volume;
      exe.maxVolumeSetId = setId;
    }
    if (maxWeight > exe.maxWeight) {
      exe.maxWeight = maxWeight;
      exe.maxWeightSetId = setId;
    }
  }
  return exe;
}
