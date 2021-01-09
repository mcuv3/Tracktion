import 'package:flutter/cupertino.dart';

class Rep {
  int id;
  final int reps;
  final double weight;
  final int rpe;
  int setId;
  String notes;
  Rep(
      {Key key,
      @required this.id,
      @required this.reps,
      @required this.weight,
      @required this.rpe,
      this.notes = "",
      this.setId});

  set updateSetId(int id) => this.setId = id;

  set updateNote(String note) {
    this.notes = note;
  }

  @override
  String toString() {
    return "Rep:(id:${this.id},reps:${this.reps},weight:${this.weight},rpe:${this.rpe},notes:${this.notes})";
  }
}
