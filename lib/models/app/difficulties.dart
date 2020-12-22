enum Difficulty { Easy, Normal, Hard, Pro }

Difficulty toDifficulty(int d) {
  switch (d) {
    case 1:
      return Difficulty.Easy;
      break;
    case 2:
      return Difficulty.Normal;
      break;
    case 3:
      return Difficulty.Hard;
      break;
    case 4:
      return Difficulty.Pro;
      break;
  }
  ;
}

int difficultyToInt(Difficulty difficulty) {
  switch (difficulty) {
    case Difficulty.Easy:
      return 1;
      break;
    case Difficulty.Normal:
      return 2;
      break;
    case Difficulty.Hard:
      return 3;
      break;
    case Difficulty.Pro:
      return 4;
      break;
  }
  ;
}
