import 'dart:convert';

import 'package:flutter/material.dart';

import 'body-parts.dart';
import 'difficulties.dart';

class Exercise {
  final int id;
  final String name;
  final Difficulty difficulty;
  final String notes;
  double maxWeigth;
  double maxVolume;
  List<SetResume> lastWorkouts;
  List<BodyPartEnum> bodyParts;
  int _setId;

  Exercise(
      {@required this.id,
      @required this.name,
      @required this.difficulty,
      @required this.bodyParts,
      @required this.lastWorkouts,
      @required this.maxWeigth,
      @required this.maxVolume,
      this.notes});

  set bodyPartSet(List<BodyPartEnum> bds) {
    this.bodyParts = bds;
  }

  int get setId => this._setId;
  set setId(int id) => this._setId = id;

  @override
  String toString() {
    return "${this.name} BodyParts = ${this.bodyParts}";
  }

  String toJson() => json.encode({
        'name': name,
        'difficulty': difficultyToInt(difficulty),
        'body_part': bodyPartToInt(bodyParts),
        'notes': notes == null ? "" : notes,
      });

  String lastWorkoutsToString() =>
      json.encode(this.lastWorkouts.map((set) => set.toString()).toList());

  static List<SetResume> stringToLastWorkouts(String str) {
    final js = json.decode(str) as List<Map<String, dynamic>>;
    return js
        .map((record) => SetResume(
            reps: record["reps"],
            date: DateTime(record["date"]),
            maxWeigth: record["maxWeith"],
            volume: record["volume"]))
        .toList();
  }
}

class SetResume {
  final double maxWeigth;
  final int reps;
  final DateTime date;
  final double volume;
  SetResume({this.maxWeigth, this.reps, this.date, this.volume});

  @override
  String toString() {
    return "";
  }
}
