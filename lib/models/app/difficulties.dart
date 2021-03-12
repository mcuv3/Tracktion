enum Difficulty { Easy, Normal, Hard, Pro }

Difficulty toDifficulty(int d) {
  switch (d) {
    case 1:
      return Difficulty.Easy;
    case 2:
      return Difficulty.Normal;
    case 3:
      return Difficulty.Hard;
    case 4:
      return Difficulty.Pro;
    default:
      return Difficulty.Easy;
  }
}

int difficultyToInt(Difficulty difficulty) {
  switch (difficulty) {
    case Difficulty.Easy:
      return 1;
    case Difficulty.Normal:
      return 2;
    case Difficulty.Hard:
      return 3;
    case Difficulty.Pro:
      return 4;
  }
}
