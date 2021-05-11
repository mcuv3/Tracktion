import 'package:tracktion/models/tables/Converts.dart';
import 'package:tracktion/models/tables/Routines.dart';

class RoutineSlim {
  final int id;
  final String routineName;
  final String groupName;
  final Difficulty difficulty;
  final RoutineBodyParts topBodyParts;
  const RoutineSlim(
      {this.id,
      this.routineName,
      this.groupName,
      this.topBodyParts,
      this.difficulty});

  @override
  String toString() {
    return "RoutineSlim(id:${this.id},name:${this.routineName},group:${this.groupName},topBodyParts:${this.topBodyParts}";
  }
}
