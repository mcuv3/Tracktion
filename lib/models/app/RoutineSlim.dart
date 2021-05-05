import 'package:tracktion/models/tables/Routines.dart';

class RoutineSlim {
  final int id;
  final String routineName;
  final String groupName;
  final Difficulty difficulty;
  final List<String> topBodyParts;
  const RoutineSlim(
      {this.id,
      this.routineName,
      this.groupName,
      this.topBodyParts,
      this.difficulty});
}
