import 'package:flutter/cupertino.dart';

class Rep {
  final int id;
  final int reps;
  final double weight;
  final int rpe;
  String notes;
  Rep(
      {Key key,
      @required this.id,
      @required this.reps,
      @required this.weight,
      @required this.rpe,
      this.notes = ""});

  set updateNote(String note) {
    this.notes = note;
  }

  @override
  String toString() {
    return "Rep:(id:${this.id},reps:${this.reps},weight:${this.weight},rpe:${this.rpe})";
  }
}
