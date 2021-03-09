

import 'package:tracktion/models/app-models.dart';

Difficulty difficultyToEnum(String difficulty){
  switch (difficulty) {
        case "Easy":
          return Difficulty.Easy;
          break;
        case "Normal":
          return Difficulty.Normal;
          break;
        case "Hard":
          return Difficulty.Hard;
          break;
        case "Pro":
          return Difficulty.Pro;
          break;
        default:
          return null;
          break;
      }

}