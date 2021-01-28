import 'package:tracktion/models/app/index.dart';

double getSetVolume(List<Rep> reps) =>
    reps.fold(0, (acc, rep) => acc + (rep.reps * rep.weight));
