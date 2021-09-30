import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tracktion/models/db/database.dart';
import 'package:tracktion/models/tables/Routines.dart';

import 'body-parts.dart';
// import 'difficulties.dart';

class Exercise {
  final int id;
  final String name;
  final Difficulty difficulty;
  final String notes;
  double maxWeigth;
  int maxWeigthSetId;
  double maxVolume;
  int maxVolumeSetId;
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
      @required this.maxVolumeSetId,
      @required this.maxWeigthSetId,
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
        'difficulty': difficulty.index,
        'body_part': bodyPartToInt(bodyParts),
        'notes': notes == null ? "" : notes,
      });

  String lastWorkoutsToString() =>
      json.encode(this.lastWorkouts.map((set) => set.toJson()).toList());

  static List<SetResume> stringToLastWorkouts(String str) {
    if (str == "") return [];

    try {
      final js = json.decode(str) as List<dynamic>;
      return js
          .map((record) => SetResume(
              setId: record["setId"],
              reps: record["reps"],
              date: DateTime.parse(record["date"]),
              maxWeigth: record["maxWeigth"],
              volume: record["volume"]))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  removeSet(int setId) {
    this.lastWorkouts.removeWhere((wk) => wk.setId == setId);
  }

  Future<void> verifyMaxWeight(
      {SQLDatabase db, int setId, double newSetWeight}) async {
    var delete = newSetWeight == null;

    if (this.maxWeigthSetId == setId &&
        ((!delete && newSetWeight < this.maxWeigth) || delete)) {
      final results = await db.findMaxWeigth(this.id, setId);
      if (results == null) return this;

      final nextMaxWeigth = results[1];

      if (!delete && newSetWeight >= nextMaxWeigth) {
        this.maxWeigthSetId = setId;
        this.maxWeigth = newSetWeight;
      } else {
        this.maxWeigthSetId = results[0];
        this.maxWeigth = results[1];
      }
    }
  }

  Future<void> verifyMaxVolume(
      {SQLDatabase db, int setId, double newSetVolume}) async {
    var delete = newSetVolume == null;

    if (this.maxVolumeSetId == setId &&
        ((!delete && newSetVolume < this.maxVolume) || delete)) {
      final results = await db.findMaxVolume(this.id, setId);
      if (results == null) return this;

      final nextMaxVolume = results[1];

      if (!delete && newSetVolume >= nextMaxVolume) {
        this.maxVolumeSetId = setId;
        this.maxVolume = newSetVolume;
      } else {
        this.maxVolumeSetId = results[0];
        this.maxVolume = results[1];
      }
    }
  }

  syncMaxes(
      {double volume, double maxWeigth, bool willDelete = false, int setId}) {
    if (this.lastWorkouts.length == 0) {
      this.maxVolumeSetId = null;
      this.maxWeigthSetId = null;
      this.maxVolume = 0.0;
      this.maxWeigth = 0.0;
    } else if (!willDelete) {
      if (volume > this.maxVolume) {
        this.maxVolume = volume;
        this.maxVolumeSetId = setId;
      }
      if (maxWeigth > this.maxWeigth) {
        this.maxWeigth = maxWeigth;
        this.maxWeigthSetId = setId;
      }
    }
  }

  Exercise copy() => Exercise(
      id: this.id,
      difficulty: this.difficulty,
      maxVolumeSetId: this.maxVolumeSetId,
      maxWeigthSetId: this.maxWeigthSetId,
      name: this.name,
      notes: this.notes,
      lastWorkouts: this.lastWorkouts,
      maxWeigth: this.maxWeigth,
      maxVolume: this.maxVolume,
      bodyParts: this.bodyParts);
}

class SetResume {
  int setId;
  final double maxWeigth;
  final int reps;
  final DateTime date;
  final double volume;
  SetResume({this.setId, this.maxWeigth, this.reps, this.date, this.volume});

  Map<String, dynamic> toJson() {
    return {
      "setId": this.setId,
      "reps": this.reps,
      "maxWeigth": this.maxWeigth,
      "volume": this.volume,
      "date": this.date.toString()
    };
  }

  @override
  String toString() {
    return 'SetResume(reps:${this.reps},maxWeigth:${this.maxWeigth},volume:${this.volume},day:${this.date.day})';
  }
}
