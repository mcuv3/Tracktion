import 'dart:convert';

import 'body-parts.dart';
// import 'difficulties.dart';

class WorkoutApp {
  final DateTime date;
  final WorkoutMetadata metadata;
  final int id;

  WorkoutApp({this.date, this.metadata, this.id});
}

class WorkoutMetadata {
  Map<int, Set<BodyPartEnum>> exesToBodyParts = {};
  Set<BodyPartEnum> bodyParts = Set();

  WorkoutMetadata({this.bodyParts, this.exesToBodyParts});

  syncBodyParts() {
    this.bodyParts = Set();
    this.exesToBodyParts.forEach((key, value) => this.bodyParts.addAll(value));
  }

  String toJson() => json.encode({
        'bodyParts': this.bodyParts.map((e) => e.index).toList(),
        'exesToBodyParts': this.exesToBodyParts.map((key, value) =>
            MapEntry(key.toString(), value.map((e) => e.index).toList())),
      });

  static WorkoutMetadata parse(String str) {
    if (str == "")
      return WorkoutMetadata(bodyParts: Set(), exesToBodyParts: {});

    try {
      final js = json.decode(str) as Map<String, dynamic>;
      final bodyPartsWk = js['bodyParts'] as List<dynamic>;
      final exesToBodyPartsWk = js['exesToBodyParts'];
      return WorkoutMetadata(
          bodyParts: bodyPartsWk.map((e) => BodyPartEnum.values[e]).toSet(),
          exesToBodyParts: Map.from(exesToBodyPartsWk).map((key, value) =>
              MapEntry(
                  int.parse(key),
                  List.from(value)
                      .map((e) => BodyPartEnum.values[e])
                      .toSet())));
    } catch (e) {
      print(e);
      return WorkoutMetadata();
    }
  }
}
