import 'package:tracktion/models/db/database.dart' as db;
import 'package:tracktion/models/tables/Converts.dart';
import 'package:tracktion/models/tables/Routines.dart';

List<db.Preference> preferencesList = [
  db.Preference(id: 1, key: "nickname", value: ""),
  db.Preference(id: 2, key: "age", value: "0"),
  db.Preference(id: 3, key: "defaultIncrement", value: "2.5"),
  db.Preference(id: 4, key: "metric", value: "kg"),
  db.Preference(id: 5, key: "weight", value: "0.0"),
];

// TODO: add routines to inital migrations

List<db.Exercise> exercisesMigration = [
  db.Exercise(
      id: 1,
      name: "DeadLift",
      notes: "Protect your lower back when you go up.",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 2,
      name: "BenchPress",
      notes: "Really good for chest building.",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 3,
      name: "Squat",
      notes: "Really good for quads and butt.",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 4,
      name: "OverHeadPress",
      notes: "Shoulders focus",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 5,
      name: "Leg Rise",
      notes: "Abs dominant",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 6,
      name: "Incline Dumbbell Press",
      notes: "Chest focus",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 7,
      name: "Front Squad",
      notes: "Heavily use for growth",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 8,
      name: "Pull Up",
      notes: "Back builder",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 9,
      name: "Lat PullDown",
      notes: "Good for lats.",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 10,
      name: "Arnold Press",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 11,
      name: "FacePull",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 12,
      name: "Lateral Rise",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 13,
      name: "UpRight Row",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 14,
      name: "Barbell Curl",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 15,
      name: "Hammer Curl",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 16,
      name: "Dips",
      notes: "",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 17,
      name: "Cable Crossover",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 18,
      name: "Push Ups",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 19,
      name: "Seated Leg Curl",
      notes: "",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 20,
      name: "Hip Trust",
      notes: "",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 21,
      name: "Front Squat",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 22,
      name: "Hack Squat",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 23,
      name: "Leg Press",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 24,
      name: "Hack Squat",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 25,
      name: "Lying Leg Curl",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 26,
      name: "Lying Leg Curl 1/Leg",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 27,
      name: "Standing Calf Raise",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 28,
      name: "Sumo DeadLift",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 29,
      name: "Walking Lunge",
      notes: "",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 30,
      name: "Glute Kickbacks",
      notes: "",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 31,
      name: "Pendlay Row",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 32,
      name: "Seated Cable Row",
      notes: "",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 33,
      name: "T Bar Row",
      notes: "",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 34,
      name: "Supinated Pull Up",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 35,
      name: "Ab-Wheel Rollout",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 36,
      name: "Crunch",
      notes: "",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 37,
      name: "Dragon Flag",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 38,
      name: "Hanging Leg Rise",
      notes: "",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 39,
      name: "Plank",
      notes: "",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 40,
      name: "Cable Chop",
      notes: "",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 41,
      name: "Reverse Crunches",
      notes: "",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 42,
      name: "Egyptian Lateral Rise",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 43,
      name: "Rear Delt Dumbbell Raise",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 44,
      name: "Triceps KickBacks",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 45,
      name: "SkullCrushers",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 46,
      name: "Seated Calf Raise",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 47,
      name: "Romanian DeadLift",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 48,
      name: "Cable Pull-Through",
      notes: "",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 49,
      name: "Close Grip BenchPress",
      notes: "",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 50,
      name: "Pec Deck",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 51,
      name: "1 Arm LatPull In",
      notes: "",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 52,
      name: "Leg Extension",
      notes: "",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 53,
      name: "Shoulder Press",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 54,
      name: "PullOver",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 55,
      name: "Good Morning",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 56,
      name: "Cable Crunch",
      notes: "",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 57,
      name: "Close Grip Row",
      notes: "",
      difficulty: Difficulty.Normal,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 58,
      name: "Cable Fly 21s",
      notes: "",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 59,
      name: "Incline Barbell Bench Press",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 60,
      name: "Neutral Grip PullUp",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 61,
      name: "Machine Hip Abduction",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 62,
      name: "Oblique Crunch",
      notes: "",
      difficulty: Difficulty.Pro,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 63,
      name: "Tricep PressDown",
      notes: "",
      difficulty: Difficulty.Easy,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
  db.Exercise(
      id: 64,
      name: "Glute Ham Raise",
      notes: "",
      difficulty: Difficulty.Hard,
      lastWorkouts: "",
      maxWeight: 0.0,
      maxVolume: 0.0,
      maxVolumeSetId: null,
      maxWeightSetId: null),
];

List<db.RoutineGroupCompanion> routineGroupMigrations = [
  db.RoutineGroupData(
    id: 1,
    name: "PPL Advance",
    description: "Push pull legs for advance folks.",
    level: Level.Advance,
    imageUrl: "",
  ).toCompanion(true),
  db.RoutineGroupData(
    id: 2,
    name: "Upper/Lower Intermediate",
    description: "Upper and lower workout.",
    level: Level.Normal,
    imageUrl: "",
  ).toCompanion(true),
  db.RoutineGroupData(
    id: 3,
    name: "Full Body Beginner",
    description: "Hit every body part each workout.",
    level: Level.Beginner,
    imageUrl: "",
  ).toCompanion(true),
  // db.RoutineGroupData(
  //   id: 4,
  //   name: "Creator 5 Split",
  //   description: "Legs - Push - Pull - Legs - Upper",
  //   level: Level.Advance,
  //   imageUrl: "",
  // ).toCompanion(true),
];

List<db.RoutineCompanion> routinesMigrations = [
  db.RoutineData(
          id: 1,
          name: "Push #1",
          difficulty: Difficulty.Hard,
          duration: 60,
          timesCopied: 0,
          notes: "Push day number 1.",
          bodyParts: RoutineBodyParts({}),
          groupId: 1)
      .toCompanion(true),
  db.RoutineData(
          id: 2,
          name: "Pull #1",
          difficulty: Difficulty.Hard,
          duration: 60,
          timesCopied: 0,
          notes: "Pull day number 1.",
          bodyParts: RoutineBodyParts({}),
          groupId: 1)
      .toCompanion(true),
  db.RoutineData(
          id: 3,
          name: "Legs #1",
          difficulty: Difficulty.Hard,
          duration: 60,
          timesCopied: 0,
          notes: "Push day number 2.",
          bodyParts: RoutineBodyParts({}),
          groupId: 1)
      .toCompanion(true),
  db.RoutineData(
          id: 4,
          name: "Push #2",
          difficulty: Difficulty.Hard,
          duration: 60,
          timesCopied: 0,
          notes: "Push day number 2.",
          bodyParts: RoutineBodyParts({}),
          groupId: 1)
      .toCompanion(true),
  db.RoutineData(
          id: 5,
          name: "Pull #2",
          difficulty: Difficulty.Hard,
          duration: 60,
          timesCopied: 0,
          notes: "Pull day number 2.",
          bodyParts: RoutineBodyParts({}),
          groupId: 1)
      .toCompanion(true),
  db.RoutineData(
          id: 6,
          name: "Legs #2",
          difficulty: Difficulty.Hard,
          duration: 60,
          timesCopied: 0,
          notes: "Legs day number 2.",
          bodyParts: RoutineBodyParts({}),
          groupId: 1)
      .toCompanion(true),
  // UPPER LOWER WORKOUT
  db.RoutineData(
          id: 7,
          name: "Upper #1",
          difficulty: Difficulty.Normal,
          duration: 60,
          timesCopied: 0,
          notes: "Upper day number 1.",
          bodyParts: RoutineBodyParts({}),
          groupId: 2)
      .toCompanion(true),
  db.RoutineData(
          id: 8,
          name: "Lower #1",
          difficulty: Difficulty.Hard,
          duration: 60,
          timesCopied: 0,
          notes: "Lower day number 1.",
          bodyParts: RoutineBodyParts({}),
          groupId: 2)
      .toCompanion(true),
  db.RoutineData(
          id: 9,
          name: "Upper #2",
          difficulty: Difficulty.Normal,
          duration: 60,
          timesCopied: 0,
          notes: "Upper day number 2.",
          bodyParts: RoutineBodyParts({}),
          groupId: 2)
      .toCompanion(true),
  db.RoutineData(
          id: 10,
          name: "Lower #2",
          difficulty: Difficulty.Normal,
          duration: 60,
          timesCopied: 0,
          notes: "Lower day number 2.",
          bodyParts: RoutineBodyParts({}),
          groupId: 2)
      .toCompanion(true),
  db.RoutineData(
          id: 11,
          name: "Upper #3",
          difficulty: Difficulty.Normal,
          duration: 60,
          timesCopied: 0,
          notes: "Upper day number 3.",
          bodyParts: RoutineBodyParts({}),
          groupId: 2)
      .toCompanion(true),
  db.RoutineData(
          id: 12,
          name: "Lower #3",
          difficulty: Difficulty.Normal,
          duration: 60,
          timesCopied: 0,
          notes: "Lower day number 3.",
          bodyParts: RoutineBodyParts({}),
          groupId: 2)
      .toCompanion(true),
  // Full Body Workout
  db.RoutineData(
          id: 13,
          name: "Workout 1",
          difficulty: Difficulty.Easy,
          duration: 60,
          timesCopied: 0,
          notes: "Full body workout number 1.",
          bodyParts: RoutineBodyParts({}),
          groupId: 3)
      .toCompanion(true),
  db.RoutineData(
          id: 14,
          name: "Workout 2",
          difficulty: Difficulty.Easy,
          duration: 60,
          timesCopied: 0,
          notes: "Full body workout number 2.",
          bodyParts: RoutineBodyParts({}),
          groupId: 3)
      .toCompanion(true),
  db.RoutineData(
          id: 15,
          name: "Workout 3",
          difficulty: Difficulty.Easy,
          duration: 60,
          timesCopied: 0,
          notes: "Full body workout number 3.",
          bodyParts: RoutineBodyParts({}),
          groupId: 3)
      .toCompanion(true),
  // // Creators workout
  // db.RoutineData(
  //         id: 16,
  //         name: "Legs #1",
  //         difficulty: Difficulty.Pro,
  //         duration: 60,
  //         timesCopied: 0,
  //         notes: "Leg day number 1.",
  //         bodyParts: RoutineBodyParts({}),
  //         groupId: 4)
  //     .toCompanion(true),
  // db.RoutineData(
  //         id: 17,
  //         name: "Push Day",
  //         difficulty: Difficulty.Hard,
  //         duration: 60,
  //         timesCopied: 0,
  //         notes: "Chest focus day.",
  //         bodyParts: RoutineBodyParts({}),
  //         groupId: 4)
  //     .toCompanion(true),
  // db.RoutineData(
  //         id: 18,
  //         name: "Pull Day",
  //         difficulty: Difficulty.Normal,
  //         duration: 60,
  //         timesCopied: 0,
  //         notes: "Back focus day.",
  //         bodyParts: RoutineBodyParts({}),
  //         groupId: 4)
  //     .toCompanion(true),
  // db.RoutineData(
  //         id: 19,
  //         name: "Legs #2",
  //         difficulty: Difficulty.Pro,
  //         duration: 60,
  //         timesCopied: 0,
  //         notes: "Leg day part 2",
  //         bodyParts: RoutineBodyParts({}),
  //         groupId: 4)
  //     .toCompanion(true),
  // db.RoutineData(
  //         id: 20,
  //         name: "Upper Body",
  //         difficulty: Difficulty.Hard,
  //         duration: 60,
  //         timesCopied: 0,
  //         notes: "Push/Pull day.",
  //         bodyParts: RoutineBodyParts({}),
  //         groupId: 4)
  //     .toCompanion(true),
];


// TODO: add routines sets to migrations
