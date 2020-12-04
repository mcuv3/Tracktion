import 'package:flutter/cupertino.dart';

class Rep {
  final int id;
  final int reps;
  final double weight;
  final int rpe;
  Rep(
      {@required this.id,
      @required this.reps,
      @required this.weight,
      @required this.rpe});

  @override
  String toString() {
    return "Rep:(id:${this.id},reps:${this.reps},weight:${this.weight},rpe:${this.rpe})";
  }
}
