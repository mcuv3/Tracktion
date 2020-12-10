import 'package:flutter/material.dart';
import 'dart:convert';
import './body-parts.dart';
import './difficulties.dart';

class Exercise {
  final int id;
  final String name;
  final Difficulty difficulty;
  final String notes;
  List<BodyPartEnum> bodyParts;

  Exercise(
      {@required this.id,
      @required this.name,
      @required this.difficulty,
      @required this.bodyParts,
      this.notes});

  set bodyPartss(List<BodyPartEnum> bds) {
    this.bodyParts = bds;
  }

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
}
