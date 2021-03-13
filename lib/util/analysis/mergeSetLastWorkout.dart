import 'package:tracktion/models/app/exercise.dart';

Exercise consenceMaxes(
    {required Exercise exe,
    required double volume,
    required double maxWeigth,
    bool willDelete = false,
    required int setId}) {
  var _exe = Exercise(
      id: exe.id,
      maxVolumeSetId: exe.maxVolumeSetId,
      maxWeigthSetId: exe.maxWeigthSetId,
      difficulty: exe.difficulty,
      name: exe.name,
      notes: exe.notes,
      lastWorkouts: exe.lastWorkouts,
      maxWeigth: exe.maxWeigth,
      maxVolume: exe.maxVolume,
      bodyParts: exe.bodyParts);

  if (_exe.lastWorkouts.length == 0) {
    _exe.maxVolumeSetId = null;
    _exe.maxWeigthSetId = null;
    _exe.maxVolume = 0.0;
    _exe.maxWeigth = 0.0;
  } else if (!willDelete) {
    if (volume > _exe.maxVolume) {
      _exe.maxVolume = volume;
      _exe.maxVolumeSetId = setId;
    }
    if (maxWeigth > _exe.maxWeigth) {
      _exe.maxWeigth = maxWeigth;
      _exe.maxWeigthSetId = setId;
    }
  }
  return _exe;
}
