import 'package:tracktion/models/app-models.dart';
import 'package:tracktion/models/db/database.dart' as db;

List<db.ExerciseBodyPart> bodyPartsMigration = [
  db.ExerciseBodyPart(exerciseId: 1, bodyPart: BodyPartEnum.Legs),
  db.ExerciseBodyPart(exerciseId: 1, bodyPart: BodyPartEnum.Quadriceps),
  db.ExerciseBodyPart(exerciseId: 2, bodyPart: BodyPartEnum.Chest),
  db.ExerciseBodyPart(exerciseId: 2, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 2, bodyPart: BodyPartEnum.Shoulders),
  db.ExerciseBodyPart(exerciseId: 3, bodyPart: BodyPartEnum.Legs),
  db.ExerciseBodyPart(exerciseId: 3, bodyPart: BodyPartEnum.Quadriceps),
  db.ExerciseBodyPart(exerciseId: 3, bodyPart: BodyPartEnum.Gluteus),
  db.ExerciseBodyPart(exerciseId: 4, bodyPart: BodyPartEnum.Shoulders),
  db.ExerciseBodyPart(exerciseId: 4, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 5, bodyPart: BodyPartEnum.Abs),
  db.ExerciseBodyPart(exerciseId: 6, bodyPart: BodyPartEnum.Chest),
  db.ExerciseBodyPart(exerciseId: 6, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 7, bodyPart: BodyPartEnum.Quadriceps),
  db.ExerciseBodyPart(exerciseId: 8, bodyPart: BodyPartEnum.Back),
  db.ExerciseBodyPart(exerciseId: 8, bodyPart: BodyPartEnum.Shoulders)
];
