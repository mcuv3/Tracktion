import 'package:tracktion/models/app-models.dart';

Difficulty difficultyToEnum(String difficulty) {
  switch (difficulty) {
    case "Easy":
      return Difficulty.Easy;

    case "Normal":
      return Difficulty.Normal;

    case "Hard":
      return Difficulty.Hard;

    case "Pro":
      return Difficulty.Pro;
    default:
      return Difficulty.Easy;
  }
}
