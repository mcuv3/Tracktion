import 'dart:convert';

import 'package:json_annotation/json_annotation.dart' as j;
import 'package:moor/moor.dart';
import 'package:tracktion/models/app/body-parts.dart';

@j.JsonSerializable()
class RoutineBodyParts {
  Map<BodyPartEnum, int> bds;

  RoutineBodyParts(this.bds);

  factory RoutineBodyParts.fromJson(Map<String, dynamic> json) {
    final Map<BodyPartEnum, int> bds = {};
    json.forEach((key, value) {
      bds[BodyPartEnum.values[int.parse(key)]] = value;
    });
    return RoutineBodyParts(bds);
  }

  Map<String, dynamic> toJson() {
    return bds.map((key, value) {
      return MapEntry(key.index.toString(), value);
    });
  }
}

// stores preferences as strings
class RoutineBodyPartsConverter
    extends TypeConverter<RoutineBodyParts, String> {
  const RoutineBodyPartsConverter();
  @override
  RoutineBodyParts mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return RoutineBodyParts.fromJson(json.decode(fromDb));
  }

  @override
  String mapToSql(RoutineBodyParts value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}
