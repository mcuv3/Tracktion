enum BodyPartEnum {
  Chest,
  Legs,
  Back,
  Hamstrings,
  Abs,
  Quadriceps,
  Shoulders,
  Gluteus,
  Arms,
  Calfs,
}

// BODY_PART_CHOICES = (
//     (1, 'CHEST'),
//     (2, 'BICEP'),
//     (3, 'CALFS'),
//     (4, 'HASTRINGS'),
//     (5, 'QUADRICEPS'),
//     (6, 'FEMORALS'),
//     (7, 'SHOULDERS'),
//     (8, 'Gluteus'),
//     (9, 'BACK'),
// )

List<BodyPartEnum> toBodyPart(List<dynamic> bodyParts) => bodyParts.map((i) {
      switch (i) {
        case 1:
          return BodyPartEnum.Chest;
          break;
        case 2:
          return BodyPartEnum.Legs;
          break;
        case 3:
          return BodyPartEnum.Arms;
          break;
        case 4:
          return BodyPartEnum.Calfs;
          break;
        case 5:
          return BodyPartEnum.Hamstrings;
          break;
        case 6:
          return BodyPartEnum.Quadriceps;
          break;
        case 7:
          return BodyPartEnum.Shoulders;
          break;
        case 8:
          return BodyPartEnum.Gluteus;
          break;
        case 9:
          return BodyPartEnum.Back;
          break;
        case 10:
          return BodyPartEnum.Abs;
          break;
      }
    }).toList();

List<int> bodyPartToInt(List<BodyPartEnum> bodyParts) => bodyParts.map((e) {
      switch (e) {
        case BodyPartEnum.Chest:
          return 1;
          break;
        case BodyPartEnum.Legs:
          return 2;
        case BodyPartEnum.Arms:
          return 3;
          break;
        case BodyPartEnum.Calfs:
          return 4;
          break;
        case BodyPartEnum.Hamstrings:
          return 5;
          break;
        case BodyPartEnum.Quadriceps:
          return 6;
          break;
        case BodyPartEnum.Shoulders:
          return 7;
          break;
        case BodyPartEnum.Gluteus:
          return 8;
          break;
        case BodyPartEnum.Back:
          return 9;
          break;
        case BodyPartEnum.Abs:
          return 10;
          break;
      }
    }).toList();
