enum BodyPartEnum {
  Chest,
  Legs,
  Back,
  Hamstrings,
  Abs,
  Quadriceps,
  Shoulders,
  GLUTEUS,
  Arms,
  Calfs,
}

List<BodyPartEnum> toBodyPart(List<int> bodyParts) => bodyParts.map((i) {
      switch (i) {
        case 1:
          return BodyPartEnum.Chest;
        case 2:
          return BodyPartEnum.Legs;
        case 3:
          return BodyPartEnum.Arms;
        case 4:
          return BodyPartEnum.Calfs;
        case 5:
          return BodyPartEnum.Hamstrings;
        case 6:
          return BodyPartEnum.Quadriceps;
        case 7:
          return BodyPartEnum.Shoulders;
        case 8:
          return BodyPartEnum.GLUTEUS;
        case 9:
          return BodyPartEnum.Back;
        case 10:
          return BodyPartEnum.Abs;
        default:
          return BodyPartEnum.Abs;
      }
    }).toList();

List<int> bodyPartToInt(List<BodyPartEnum> bodyParts) => bodyParts.map((e) {
      switch (e) {
        case BodyPartEnum.Chest:
          return 1;
        case BodyPartEnum.Legs:
          return 2;
        case BodyPartEnum.Arms:
          return 3;
        case BodyPartEnum.Calfs:
          return 4;
        case BodyPartEnum.Hamstrings:
          return 5;
        case BodyPartEnum.Quadriceps:
          return 6;
        case BodyPartEnum.Shoulders:
          return 7;
        case BodyPartEnum.GLUTEUS:
          return 8;
        case BodyPartEnum.Back:
          return 9;
        case BodyPartEnum.Abs:
          return 10;
      }
    }).toList();
