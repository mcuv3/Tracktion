enum BodyPart {
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

// BODY_PART_CHOICES = (
//     (1, 'CHEST'),
//     (2, 'BICEP'),
//     (3, 'CALFS'),
//     (4, 'HASTRINGS'),
//     (5, 'QUADRICEPS'),
//     (6, 'FEMORALS'),
//     (7, 'SHOULDERS'),
//     (8, 'GLUTEUS'),
//     (9, 'BACK'),
// )

List<BodyPart> toBodyPart(List<dynamic> bodyParts) => bodyParts.map((i) {
      switch (i) {
        case 1:
          return BodyPart.Chest;
          break;
        case 2:
          return BodyPart.Legs;
          break;
        case 3:
          return BodyPart.Arms;
          break;
        case 4:
          return BodyPart.Calfs;
          break;
        case 5:
          return BodyPart.Hamstrings;
          break;
        case 6:
          return BodyPart.Quadriceps;
          break;
        case 7:
          return BodyPart.Shoulders;
          break;
        case 8:
          return BodyPart.GLUTEUS;
          break;
        case 9:
          return BodyPart.Back;
          break;
        case 10:
          return BodyPart.Abs;
          break;
      }
    }).toList();

List<int> bodyPartToInt(List<BodyPart> bodyParts) => bodyParts.map((e) {
      switch (e) {
        case BodyPart.Chest:
          return 1;
          break;
        case BodyPart.Legs:
          return 2;
        case BodyPart.Arms:
          return 3;
          break;
        case BodyPart.Calfs:
          return 4;
          break;
        case BodyPart.Hamstrings:
          return 5;
          break;
        case BodyPart.Quadriceps:
          return 6;
          break;
        case BodyPart.Shoulders:
          return 7;
          break;
        case BodyPart.GLUTEUS:
          return 8;
          break;
        case BodyPart.Back:
          return 9;
          break;
        case BodyPart.Abs:
          return 10;
          break;
      }
    }).toList();
