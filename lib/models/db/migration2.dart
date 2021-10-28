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
  db.ExerciseBodyPart(exerciseId: 8, bodyPart: BodyPartEnum.Shoulders),
  db.ExerciseBodyPart(exerciseId: 9, bodyPart: BodyPartEnum.Back),
  db.ExerciseBodyPart(exerciseId: 9, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 10, bodyPart: BodyPartEnum.Shoulders),
  db.ExerciseBodyPart(exerciseId: 10, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 11, bodyPart: BodyPartEnum.Shoulders),
  db.ExerciseBodyPart(exerciseId: 12, bodyPart: BodyPartEnum.Shoulders),
  db.ExerciseBodyPart(exerciseId: 13, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 13, bodyPart: BodyPartEnum.Shoulders),
  db.ExerciseBodyPart(exerciseId: 14, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 15, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 16, bodyPart: BodyPartEnum.Chest),
  db.ExerciseBodyPart(exerciseId: 17, bodyPart: BodyPartEnum.Chest),
  db.ExerciseBodyPart(exerciseId: 18, bodyPart: BodyPartEnum.Chest),
  db.ExerciseBodyPart(exerciseId: 19, bodyPart: BodyPartEnum.Hamstrings),
  db.ExerciseBodyPart(exerciseId: 20, bodyPart: BodyPartEnum.Gluteus),
  db.ExerciseBodyPart(exerciseId: 21, bodyPart: BodyPartEnum.Quadriceps),
  db.ExerciseBodyPart(exerciseId: 22, bodyPart: BodyPartEnum.Quadriceps),
  db.ExerciseBodyPart(exerciseId: 23, bodyPart: BodyPartEnum.Quadriceps),
  db.ExerciseBodyPart(exerciseId: 24, bodyPart: BodyPartEnum.Quadriceps),
  db.ExerciseBodyPart(exerciseId: 25, bodyPart: BodyPartEnum.Hamstrings),
  db.ExerciseBodyPart(exerciseId: 26, bodyPart: BodyPartEnum.Hamstrings),
  db.ExerciseBodyPart(exerciseId: 27, bodyPart: BodyPartEnum.Calfs),
  db.ExerciseBodyPart(exerciseId: 46, bodyPart: BodyPartEnum.Calfs),
  db.ExerciseBodyPart(exerciseId: 28, bodyPart: BodyPartEnum.Quadriceps),
  db.ExerciseBodyPart(exerciseId: 28, bodyPart: BodyPartEnum.Gluteus),
  db.ExerciseBodyPart(exerciseId: 28, bodyPart: BodyPartEnum.Back),
  db.ExerciseBodyPart(exerciseId: 29, bodyPart: BodyPartEnum.Gluteus),
  db.ExerciseBodyPart(exerciseId: 29, bodyPart: BodyPartEnum.Quadriceps),
  db.ExerciseBodyPart(exerciseId: 30, bodyPart: BodyPartEnum.Gluteus),
  db.ExerciseBodyPart(exerciseId: 31, bodyPart: BodyPartEnum.Back),
  db.ExerciseBodyPart(exerciseId: 32, bodyPart: BodyPartEnum.Back),
  db.ExerciseBodyPart(exerciseId: 32, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 33, bodyPart: BodyPartEnum.Back),
  db.ExerciseBodyPart(exerciseId: 34, bodyPart: BodyPartEnum.Back),
  db.ExerciseBodyPart(exerciseId: 34, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 35, bodyPart: BodyPartEnum.Abs),
  db.ExerciseBodyPart(exerciseId: 36, bodyPart: BodyPartEnum.Abs),
  db.ExerciseBodyPart(exerciseId: 37, bodyPart: BodyPartEnum.Abs),
  db.ExerciseBodyPart(exerciseId: 38, bodyPart: BodyPartEnum.Abs),
  db.ExerciseBodyPart(exerciseId: 39, bodyPart: BodyPartEnum.Abs),
  db.ExerciseBodyPart(exerciseId: 40, bodyPart: BodyPartEnum.Abs),
  db.ExerciseBodyPart(exerciseId: 41, bodyPart: BodyPartEnum.Abs),
  db.ExerciseBodyPart(exerciseId: 42, bodyPart: BodyPartEnum.Shoulders),
  db.ExerciseBodyPart(exerciseId: 43, bodyPart: BodyPartEnum.Shoulders),
  db.ExerciseBodyPart(exerciseId: 44, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 45, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 47, bodyPart: BodyPartEnum.Hamstrings),
  db.ExerciseBodyPart(exerciseId: 47, bodyPart: BodyPartEnum.Gluteus),
  db.ExerciseBodyPart(exerciseId: 48, bodyPart: BodyPartEnum.Hamstrings),
  db.ExerciseBodyPart(exerciseId: 49, bodyPart: BodyPartEnum.Arms),
  db.ExerciseBodyPart(exerciseId: 49, bodyPart: BodyPartEnum.Chest),
  db.ExerciseBodyPart(exerciseId: 50, bodyPart: BodyPartEnum.Chest),
  db.ExerciseBodyPart(exerciseId: 51, bodyPart: BodyPartEnum.Back),
  db.ExerciseBodyPart(exerciseId: 52, bodyPart: BodyPartEnum.Quadriceps),
];
