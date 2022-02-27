// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Exercise extends DataClass implements Insertable<Exercise> {
  final int id;
  final String name;
  final String lastWorkouts;
  final double maxVolume;
  final double maxWeight;
  final int maxWeightSetId;
  final int maxVolumeSetId;
  final String notes;
  final Difficulty difficulty;
  Exercise(
      {@required this.id,
      @required this.name,
      @required this.lastWorkouts,
      @required this.maxVolume,
      @required this.maxWeight,
      this.maxWeightSetId,
      this.maxVolumeSetId,
      this.notes,
      @required this.difficulty});
  factory Exercise.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Exercise(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      lastWorkouts: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_workouts']),
      maxVolume: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}max_volume']),
      maxWeight: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}max_weight']),
      maxWeightSetId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}max_weight_set_id']),
      maxVolumeSetId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}max_volume_set_id']),
      notes: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}notes']),
      difficulty: $ExercisesTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}difficulty'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || lastWorkouts != null) {
      map['last_workouts'] = Variable<String>(lastWorkouts);
    }
    if (!nullToAbsent || maxVolume != null) {
      map['max_volume'] = Variable<double>(maxVolume);
    }
    if (!nullToAbsent || maxWeight != null) {
      map['max_weight'] = Variable<double>(maxWeight);
    }
    if (!nullToAbsent || maxWeightSetId != null) {
      map['max_weight_set_id'] = Variable<int>(maxWeightSetId);
    }
    if (!nullToAbsent || maxVolumeSetId != null) {
      map['max_volume_set_id'] = Variable<int>(maxVolumeSetId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || difficulty != null) {
      final converter = $ExercisesTable.$converter0;
      map['difficulty'] = Variable<int>(converter.mapToSql(difficulty));
    }
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      lastWorkouts: lastWorkouts == null && nullToAbsent
          ? const Value.absent()
          : Value(lastWorkouts),
      maxVolume: maxVolume == null && nullToAbsent
          ? const Value.absent()
          : Value(maxVolume),
      maxWeight: maxWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(maxWeight),
      maxWeightSetId: maxWeightSetId == null && nullToAbsent
          ? const Value.absent()
          : Value(maxWeightSetId),
      maxVolumeSetId: maxVolumeSetId == null && nullToAbsent
          ? const Value.absent()
          : Value(maxVolumeSetId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lastWorkouts: serializer.fromJson<String>(json['lastWorkouts']),
      maxVolume: serializer.fromJson<double>(json['maxVolume']),
      maxWeight: serializer.fromJson<double>(json['maxWeight']),
      maxWeightSetId: serializer.fromJson<int>(json['maxWeightSetId']),
      maxVolumeSetId: serializer.fromJson<int>(json['maxVolumeSetId']),
      notes: serializer.fromJson<String>(json['notes']),
      difficulty: serializer.fromJson<Difficulty>(json['difficulty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lastWorkouts': serializer.toJson<String>(lastWorkouts),
      'maxVolume': serializer.toJson<double>(maxVolume),
      'maxWeight': serializer.toJson<double>(maxWeight),
      'maxWeightSetId': serializer.toJson<int>(maxWeightSetId),
      'maxVolumeSetId': serializer.toJson<int>(maxVolumeSetId),
      'notes': serializer.toJson<String>(notes),
      'difficulty': serializer.toJson<Difficulty>(difficulty),
    };
  }

  Exercise copyWith(
          {int id,
          String name,
          String lastWorkouts,
          double maxVolume,
          double maxWeight,
          int maxWeightSetId,
          int maxVolumeSetId,
          String notes,
          Difficulty difficulty}) =>
      Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        lastWorkouts: lastWorkouts ?? this.lastWorkouts,
        maxVolume: maxVolume ?? this.maxVolume,
        maxWeight: maxWeight ?? this.maxWeight,
        maxWeightSetId: maxWeightSetId ?? this.maxWeightSetId,
        maxVolumeSetId: maxVolumeSetId ?? this.maxVolumeSetId,
        notes: notes ?? this.notes,
        difficulty: difficulty ?? this.difficulty,
      );
  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastWorkouts: $lastWorkouts, ')
          ..write('maxVolume: $maxVolume, ')
          ..write('maxWeight: $maxWeight, ')
          ..write('maxWeightSetId: $maxWeightSetId, ')
          ..write('maxVolumeSetId: $maxVolumeSetId, ')
          ..write('notes: $notes, ')
          ..write('difficulty: $difficulty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, lastWorkouts, maxVolume, maxWeight,
      maxWeightSetId, maxVolumeSetId, notes, difficulty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastWorkouts == this.lastWorkouts &&
          other.maxVolume == this.maxVolume &&
          other.maxWeight == this.maxWeight &&
          other.maxWeightSetId == this.maxWeightSetId &&
          other.maxVolumeSetId == this.maxVolumeSetId &&
          other.notes == this.notes &&
          other.difficulty == this.difficulty);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> lastWorkouts;
  final Value<double> maxVolume;
  final Value<double> maxWeight;
  final Value<int> maxWeightSetId;
  final Value<int> maxVolumeSetId;
  final Value<String> notes;
  final Value<Difficulty> difficulty;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastWorkouts = const Value.absent(),
    this.maxVolume = const Value.absent(),
    this.maxWeight = const Value.absent(),
    this.maxWeightSetId = const Value.absent(),
    this.maxVolumeSetId = const Value.absent(),
    this.notes = const Value.absent(),
    this.difficulty = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String lastWorkouts,
    @required double maxVolume,
    @required double maxWeight,
    this.maxWeightSetId = const Value.absent(),
    this.maxVolumeSetId = const Value.absent(),
    this.notes = const Value.absent(),
    @required Difficulty difficulty,
  })  : name = Value(name),
        lastWorkouts = Value(lastWorkouts),
        maxVolume = Value(maxVolume),
        maxWeight = Value(maxWeight),
        difficulty = Value(difficulty);
  static Insertable<Exercise> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> lastWorkouts,
    Expression<double> maxVolume,
    Expression<double> maxWeight,
    Expression<int> maxWeightSetId,
    Expression<int> maxVolumeSetId,
    Expression<String> notes,
    Expression<Difficulty> difficulty,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastWorkouts != null) 'last_workouts': lastWorkouts,
      if (maxVolume != null) 'max_volume': maxVolume,
      if (maxWeight != null) 'max_weight': maxWeight,
      if (maxWeightSetId != null) 'max_weight_set_id': maxWeightSetId,
      if (maxVolumeSetId != null) 'max_volume_set_id': maxVolumeSetId,
      if (notes != null) 'notes': notes,
      if (difficulty != null) 'difficulty': difficulty,
    });
  }

  ExercisesCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> lastWorkouts,
      Value<double> maxVolume,
      Value<double> maxWeight,
      Value<int> maxWeightSetId,
      Value<int> maxVolumeSetId,
      Value<String> notes,
      Value<Difficulty> difficulty}) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lastWorkouts: lastWorkouts ?? this.lastWorkouts,
      maxVolume: maxVolume ?? this.maxVolume,
      maxWeight: maxWeight ?? this.maxWeight,
      maxWeightSetId: maxWeightSetId ?? this.maxWeightSetId,
      maxVolumeSetId: maxVolumeSetId ?? this.maxVolumeSetId,
      notes: notes ?? this.notes,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lastWorkouts.present) {
      map['last_workouts'] = Variable<String>(lastWorkouts.value);
    }
    if (maxVolume.present) {
      map['max_volume'] = Variable<double>(maxVolume.value);
    }
    if (maxWeight.present) {
      map['max_weight'] = Variable<double>(maxWeight.value);
    }
    if (maxWeightSetId.present) {
      map['max_weight_set_id'] = Variable<int>(maxWeightSetId.value);
    }
    if (maxVolumeSetId.present) {
      map['max_volume_set_id'] = Variable<int>(maxVolumeSetId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (difficulty.present) {
      final converter = $ExercisesTable.$converter0;
      map['difficulty'] = Variable<int>(converter.mapToSql(difficulty.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastWorkouts: $lastWorkouts, ')
          ..write('maxVolume: $maxVolume, ')
          ..write('maxWeight: $maxWeight, ')
          ..write('maxWeightSetId: $maxWeightSetId, ')
          ..write('maxVolumeSetId: $maxVolumeSetId, ')
          ..write('notes: $notes, ')
          ..write('difficulty: $difficulty')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name => _name ??= GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _lastWorkoutsMeta =
      const VerificationMeta('lastWorkouts');
  GeneratedColumn<String> _lastWorkouts;
  @override
  GeneratedColumn<String> get lastWorkouts => _lastWorkouts ??=
      GeneratedColumn<String>('last_workouts', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _maxVolumeMeta = const VerificationMeta('maxVolume');
  GeneratedColumn<double> _maxVolume;
  @override
  GeneratedColumn<double> get maxVolume =>
      _maxVolume ??= GeneratedColumn<double>('max_volume', aliasedName, false,
          type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _maxWeightMeta = const VerificationMeta('maxWeight');
  GeneratedColumn<double> _maxWeight;
  @override
  GeneratedColumn<double> get maxWeight =>
      _maxWeight ??= GeneratedColumn<double>('max_weight', aliasedName, false,
          type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _maxWeightSetIdMeta =
      const VerificationMeta('maxWeightSetId');
  GeneratedColumn<int> _maxWeightSetId;
  @override
  GeneratedColumn<int> get maxWeightSetId => _maxWeightSetId ??=
      GeneratedColumn<int>('max_weight_set_id', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _maxVolumeSetIdMeta =
      const VerificationMeta('maxVolumeSetId');
  GeneratedColumn<int> _maxVolumeSetId;
  @override
  GeneratedColumn<int> get maxVolumeSetId => _maxVolumeSetId ??=
      GeneratedColumn<int>('max_volume_set_id', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedColumn<String> _notes;
  @override
  GeneratedColumn<String> get notes =>
      _notes ??= GeneratedColumn<String>('notes', aliasedName, true,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
          type: const StringType(),
          requiredDuringInsert: false);
  final VerificationMeta _difficultyMeta = const VerificationMeta('difficulty');
  GeneratedColumnWithTypeConverter<Difficulty, int> _difficulty;
  @override
  GeneratedColumnWithTypeConverter<Difficulty, int> get difficulty =>
      _difficulty ??= GeneratedColumn<int>('difficulty', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<Difficulty>($ExercisesTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        lastWorkouts,
        maxVolume,
        maxWeight,
        maxWeightSetId,
        maxVolumeSetId,
        notes,
        difficulty
      ];
  @override
  String get aliasedName => _alias ?? 'exercises';
  @override
  String get actualTableName => 'exercises';
  @override
  VerificationContext validateIntegrity(Insertable<Exercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('last_workouts')) {
      context.handle(
          _lastWorkoutsMeta,
          lastWorkouts.isAcceptableOrUnknown(
              data['last_workouts'], _lastWorkoutsMeta));
    } else if (isInserting) {
      context.missing(_lastWorkoutsMeta);
    }
    if (data.containsKey('max_volume')) {
      context.handle(_maxVolumeMeta,
          maxVolume.isAcceptableOrUnknown(data['max_volume'], _maxVolumeMeta));
    } else if (isInserting) {
      context.missing(_maxVolumeMeta);
    }
    if (data.containsKey('max_weight')) {
      context.handle(_maxWeightMeta,
          maxWeight.isAcceptableOrUnknown(data['max_weight'], _maxWeightMeta));
    } else if (isInserting) {
      context.missing(_maxWeightMeta);
    }
    if (data.containsKey('max_weight_set_id')) {
      context.handle(
          _maxWeightSetIdMeta,
          maxWeightSetId.isAcceptableOrUnknown(
              data['max_weight_set_id'], _maxWeightSetIdMeta));
    }
    if (data.containsKey('max_volume_set_id')) {
      context.handle(
          _maxVolumeSetIdMeta,
          maxVolumeSetId.isAcceptableOrUnknown(
              data['max_volume_set_id'], _maxVolumeSetIdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes'], _notesMeta));
    }
    context.handle(_difficultyMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String tablePrefix}) {
    return Exercise.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }

  static TypeConverter<Difficulty, int> $converter0 =
      const EnumIndexConverter<Difficulty>(Difficulty.values);
}

class ExerciseBodyPart extends DataClass
    implements Insertable<ExerciseBodyPart> {
  final int exerciseId;
  final BodyPartEnum bodyPart;
  ExerciseBodyPart({@required this.exerciseId, @required this.bodyPart});
  factory ExerciseBodyPart.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return ExerciseBodyPart(
      exerciseId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}exercise_id']),
      bodyPart: $ExerciseBodyPartsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}body_part'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || exerciseId != null) {
      map['exercise_id'] = Variable<int>(exerciseId);
    }
    if (!nullToAbsent || bodyPart != null) {
      final converter = $ExerciseBodyPartsTable.$converter0;
      map['body_part'] = Variable<int>(converter.mapToSql(bodyPart));
    }
    return map;
  }

  ExerciseBodyPartsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseBodyPartsCompanion(
      exerciseId: exerciseId == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseId),
      bodyPart: bodyPart == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyPart),
    );
  }

  factory ExerciseBodyPart.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ExerciseBodyPart(
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      bodyPart: serializer.fromJson<BodyPartEnum>(json['bodyPart']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'exerciseId': serializer.toJson<int>(exerciseId),
      'bodyPart': serializer.toJson<BodyPartEnum>(bodyPart),
    };
  }

  ExerciseBodyPart copyWith({int exerciseId, BodyPartEnum bodyPart}) =>
      ExerciseBodyPart(
        exerciseId: exerciseId ?? this.exerciseId,
        bodyPart: bodyPart ?? this.bodyPart,
      );
  @override
  String toString() {
    return (StringBuffer('ExerciseBodyPart(')
          ..write('exerciseId: $exerciseId, ')
          ..write('bodyPart: $bodyPart')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(exerciseId, bodyPart);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseBodyPart &&
          other.exerciseId == this.exerciseId &&
          other.bodyPart == this.bodyPart);
}

class ExerciseBodyPartsCompanion extends UpdateCompanion<ExerciseBodyPart> {
  final Value<int> exerciseId;
  final Value<BodyPartEnum> bodyPart;
  const ExerciseBodyPartsCompanion({
    this.exerciseId = const Value.absent(),
    this.bodyPart = const Value.absent(),
  });
  ExerciseBodyPartsCompanion.insert({
    @required int exerciseId,
    @required BodyPartEnum bodyPart,
  })  : exerciseId = Value(exerciseId),
        bodyPart = Value(bodyPart);
  static Insertable<ExerciseBodyPart> custom({
    Expression<int> exerciseId,
    Expression<BodyPartEnum> bodyPart,
  }) {
    return RawValuesInsertable({
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (bodyPart != null) 'body_part': bodyPart,
    });
  }

  ExerciseBodyPartsCompanion copyWith(
      {Value<int> exerciseId, Value<BodyPartEnum> bodyPart}) {
    return ExerciseBodyPartsCompanion(
      exerciseId: exerciseId ?? this.exerciseId,
      bodyPart: bodyPart ?? this.bodyPart,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (bodyPart.present) {
      final converter = $ExerciseBodyPartsTable.$converter0;
      map['body_part'] = Variable<int>(converter.mapToSql(bodyPart.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseBodyPartsCompanion(')
          ..write('exerciseId: $exerciseId, ')
          ..write('bodyPart: $bodyPart')
          ..write(')'))
        .toString();
  }
}

class $ExerciseBodyPartsTable extends ExerciseBodyParts
    with TableInfo<$ExerciseBodyPartsTable, ExerciseBodyPart> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $ExerciseBodyPartsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _exerciseIdMeta = const VerificationMeta('exerciseId');
  GeneratedColumn<int> _exerciseId;
  @override
  GeneratedColumn<int> get exerciseId =>
      _exerciseId ??= GeneratedColumn<int>('exercise_id', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _bodyPartMeta = const VerificationMeta('bodyPart');
  GeneratedColumnWithTypeConverter<BodyPartEnum, int> _bodyPart;
  @override
  GeneratedColumnWithTypeConverter<BodyPartEnum, int> get bodyPart =>
      _bodyPart ??= GeneratedColumn<int>('body_part', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<BodyPartEnum>($ExerciseBodyPartsTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [exerciseId, bodyPart];
  @override
  String get aliasedName => _alias ?? 'exercise_body_parts';
  @override
  String get actualTableName => 'exercise_body_parts';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseBodyPart> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id'], _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    context.handle(_bodyPartMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ExerciseBodyPart map(Map<String, dynamic> data, {String tablePrefix}) {
    return ExerciseBodyPart.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ExerciseBodyPartsTable createAlias(String alias) {
    return $ExerciseBodyPartsTable(attachedDatabase, alias);
  }

  static TypeConverter<BodyPartEnum, int> $converter0 =
      const EnumIndexConverter<BodyPartEnum>(BodyPartEnum.values);
}

class Migration extends DataClass implements Insertable<Migration> {
  final int id;
  final String endPoint;
  final String payload;
  final String verb;
  Migration(
      {@required this.id,
      @required this.endPoint,
      @required this.payload,
      @required this.verb});
  factory Migration.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Migration(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      endPoint: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}end_point']),
      payload: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payload']),
      verb: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}verb']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || endPoint != null) {
      map['end_point'] = Variable<String>(endPoint);
    }
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    if (!nullToAbsent || verb != null) {
      map['verb'] = Variable<String>(verb);
    }
    return map;
  }

  MigrationsCompanion toCompanion(bool nullToAbsent) {
    return MigrationsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      endPoint: endPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(endPoint),
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
      verb: verb == null && nullToAbsent ? const Value.absent() : Value(verb),
    );
  }

  factory Migration.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Migration(
      id: serializer.fromJson<int>(json['id']),
      endPoint: serializer.fromJson<String>(json['endPoint']),
      payload: serializer.fromJson<String>(json['payload']),
      verb: serializer.fromJson<String>(json['verb']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'endPoint': serializer.toJson<String>(endPoint),
      'payload': serializer.toJson<String>(payload),
      'verb': serializer.toJson<String>(verb),
    };
  }

  Migration copyWith({int id, String endPoint, String payload, String verb}) =>
      Migration(
        id: id ?? this.id,
        endPoint: endPoint ?? this.endPoint,
        payload: payload ?? this.payload,
        verb: verb ?? this.verb,
      );
  @override
  String toString() {
    return (StringBuffer('Migration(')
          ..write('id: $id, ')
          ..write('endPoint: $endPoint, ')
          ..write('payload: $payload, ')
          ..write('verb: $verb')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, endPoint, payload, verb);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Migration &&
          other.id == this.id &&
          other.endPoint == this.endPoint &&
          other.payload == this.payload &&
          other.verb == this.verb);
}

class MigrationsCompanion extends UpdateCompanion<Migration> {
  final Value<int> id;
  final Value<String> endPoint;
  final Value<String> payload;
  final Value<String> verb;
  const MigrationsCompanion({
    this.id = const Value.absent(),
    this.endPoint = const Value.absent(),
    this.payload = const Value.absent(),
    this.verb = const Value.absent(),
  });
  MigrationsCompanion.insert({
    this.id = const Value.absent(),
    @required String endPoint,
    @required String payload,
    @required String verb,
  })  : endPoint = Value(endPoint),
        payload = Value(payload),
        verb = Value(verb);
  static Insertable<Migration> custom({
    Expression<int> id,
    Expression<String> endPoint,
    Expression<String> payload,
    Expression<String> verb,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (endPoint != null) 'end_point': endPoint,
      if (payload != null) 'payload': payload,
      if (verb != null) 'verb': verb,
    });
  }

  MigrationsCompanion copyWith(
      {Value<int> id,
      Value<String> endPoint,
      Value<String> payload,
      Value<String> verb}) {
    return MigrationsCompanion(
      id: id ?? this.id,
      endPoint: endPoint ?? this.endPoint,
      payload: payload ?? this.payload,
      verb: verb ?? this.verb,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (endPoint.present) {
      map['end_point'] = Variable<String>(endPoint.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (verb.present) {
      map['verb'] = Variable<String>(verb.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MigrationsCompanion(')
          ..write('id: $id, ')
          ..write('endPoint: $endPoint, ')
          ..write('payload: $payload, ')
          ..write('verb: $verb')
          ..write(')'))
        .toString();
  }
}

class $MigrationsTable extends Migrations
    with TableInfo<$MigrationsTable, Migration> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $MigrationsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _endPointMeta = const VerificationMeta('endPoint');
  GeneratedColumn<String> _endPoint;
  @override
  GeneratedColumn<String> get endPoint =>
      _endPoint ??= GeneratedColumn<String>('end_point', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _payloadMeta = const VerificationMeta('payload');
  GeneratedColumn<String> _payload;
  @override
  GeneratedColumn<String> get payload =>
      _payload ??= GeneratedColumn<String>('payload', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _verbMeta = const VerificationMeta('verb');
  GeneratedColumn<String> _verb;
  @override
  GeneratedColumn<String> get verb =>
      _verb ??= GeneratedColumn<String>('verb', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, endPoint, payload, verb];
  @override
  String get aliasedName => _alias ?? 'migrations';
  @override
  String get actualTableName => 'migrations';
  @override
  VerificationContext validateIntegrity(Insertable<Migration> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('end_point')) {
      context.handle(_endPointMeta,
          endPoint.isAcceptableOrUnknown(data['end_point'], _endPointMeta));
    } else if (isInserting) {
      context.missing(_endPointMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload'], _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('verb')) {
      context.handle(
          _verbMeta, verb.isAcceptableOrUnknown(data['verb'], _verbMeta));
    } else if (isInserting) {
      context.missing(_verbMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Migration map(Map<String, dynamic> data, {String tablePrefix}) {
    return Migration.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MigrationsTable createAlias(String alias) {
    return $MigrationsTable(attachedDatabase, alias);
  }
}

class SetWorkout extends DataClass implements Insertable<SetWorkout> {
  final int id;
  final double volume;
  final double maxWeight;
  final int workOutId;
  final int exerciseId;
  SetWorkout(
      {@required this.id,
      @required this.volume,
      @required this.maxWeight,
      @required this.workOutId,
      @required this.exerciseId});
  factory SetWorkout.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return SetWorkout(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      volume: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}volume']),
      maxWeight: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}max_weight']),
      workOutId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}work_out_id']),
      exerciseId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}exercise_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || volume != null) {
      map['volume'] = Variable<double>(volume);
    }
    if (!nullToAbsent || maxWeight != null) {
      map['max_weight'] = Variable<double>(maxWeight);
    }
    if (!nullToAbsent || workOutId != null) {
      map['work_out_id'] = Variable<int>(workOutId);
    }
    if (!nullToAbsent || exerciseId != null) {
      map['exercise_id'] = Variable<int>(exerciseId);
    }
    return map;
  }

  SetWorkoutsCompanion toCompanion(bool nullToAbsent) {
    return SetWorkoutsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      volume:
          volume == null && nullToAbsent ? const Value.absent() : Value(volume),
      maxWeight: maxWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(maxWeight),
      workOutId: workOutId == null && nullToAbsent
          ? const Value.absent()
          : Value(workOutId),
      exerciseId: exerciseId == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseId),
    );
  }

  factory SetWorkout.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SetWorkout(
      id: serializer.fromJson<int>(json['id']),
      volume: serializer.fromJson<double>(json['volume']),
      maxWeight: serializer.fromJson<double>(json['maxWeight']),
      workOutId: serializer.fromJson<int>(json['workOutId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'volume': serializer.toJson<double>(volume),
      'maxWeight': serializer.toJson<double>(maxWeight),
      'workOutId': serializer.toJson<int>(workOutId),
      'exerciseId': serializer.toJson<int>(exerciseId),
    };
  }

  SetWorkout copyWith(
          {int id,
          double volume,
          double maxWeight,
          int workOutId,
          int exerciseId}) =>
      SetWorkout(
        id: id ?? this.id,
        volume: volume ?? this.volume,
        maxWeight: maxWeight ?? this.maxWeight,
        workOutId: workOutId ?? this.workOutId,
        exerciseId: exerciseId ?? this.exerciseId,
      );
  @override
  String toString() {
    return (StringBuffer('SetWorkout(')
          ..write('id: $id, ')
          ..write('volume: $volume, ')
          ..write('maxWeight: $maxWeight, ')
          ..write('workOutId: $workOutId, ')
          ..write('exerciseId: $exerciseId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, volume, maxWeight, workOutId, exerciseId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetWorkout &&
          other.id == this.id &&
          other.volume == this.volume &&
          other.maxWeight == this.maxWeight &&
          other.workOutId == this.workOutId &&
          other.exerciseId == this.exerciseId);
}

class SetWorkoutsCompanion extends UpdateCompanion<SetWorkout> {
  final Value<int> id;
  final Value<double> volume;
  final Value<double> maxWeight;
  final Value<int> workOutId;
  final Value<int> exerciseId;
  const SetWorkoutsCompanion({
    this.id = const Value.absent(),
    this.volume = const Value.absent(),
    this.maxWeight = const Value.absent(),
    this.workOutId = const Value.absent(),
    this.exerciseId = const Value.absent(),
  });
  SetWorkoutsCompanion.insert({
    this.id = const Value.absent(),
    @required double volume,
    @required double maxWeight,
    @required int workOutId,
    @required int exerciseId,
  })  : volume = Value(volume),
        maxWeight = Value(maxWeight),
        workOutId = Value(workOutId),
        exerciseId = Value(exerciseId);
  static Insertable<SetWorkout> custom({
    Expression<int> id,
    Expression<double> volume,
    Expression<double> maxWeight,
    Expression<int> workOutId,
    Expression<int> exerciseId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (volume != null) 'volume': volume,
      if (maxWeight != null) 'max_weight': maxWeight,
      if (workOutId != null) 'work_out_id': workOutId,
      if (exerciseId != null) 'exercise_id': exerciseId,
    });
  }

  SetWorkoutsCompanion copyWith(
      {Value<int> id,
      Value<double> volume,
      Value<double> maxWeight,
      Value<int> workOutId,
      Value<int> exerciseId}) {
    return SetWorkoutsCompanion(
      id: id ?? this.id,
      volume: volume ?? this.volume,
      maxWeight: maxWeight ?? this.maxWeight,
      workOutId: workOutId ?? this.workOutId,
      exerciseId: exerciseId ?? this.exerciseId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (volume.present) {
      map['volume'] = Variable<double>(volume.value);
    }
    if (maxWeight.present) {
      map['max_weight'] = Variable<double>(maxWeight.value);
    }
    if (workOutId.present) {
      map['work_out_id'] = Variable<int>(workOutId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetWorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('volume: $volume, ')
          ..write('maxWeight: $maxWeight, ')
          ..write('workOutId: $workOutId, ')
          ..write('exerciseId: $exerciseId')
          ..write(')'))
        .toString();
  }
}

class $SetWorkoutsTable extends SetWorkouts
    with TableInfo<$SetWorkoutsTable, SetWorkout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $SetWorkoutsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _volumeMeta = const VerificationMeta('volume');
  GeneratedColumn<double> _volume;
  @override
  GeneratedColumn<double> get volume =>
      _volume ??= GeneratedColumn<double>('volume', aliasedName, false,
          type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _maxWeightMeta = const VerificationMeta('maxWeight');
  GeneratedColumn<double> _maxWeight;
  @override
  GeneratedColumn<double> get maxWeight =>
      _maxWeight ??= GeneratedColumn<double>('max_weight', aliasedName, false,
          type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _workOutIdMeta = const VerificationMeta('workOutId');
  GeneratedColumn<int> _workOutId;
  @override
  GeneratedColumn<int> get workOutId =>
      _workOutId ??= GeneratedColumn<int>('work_out_id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL REFERENCES workouts (id)');
  final VerificationMeta _exerciseIdMeta = const VerificationMeta('exerciseId');
  GeneratedColumn<int> _exerciseId;
  @override
  GeneratedColumn<int> get exerciseId =>
      _exerciseId ??= GeneratedColumn<int>('exercise_id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL REFERENCES exercises (id)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, volume, maxWeight, workOutId, exerciseId];
  @override
  String get aliasedName => _alias ?? 'set_workouts';
  @override
  String get actualTableName => 'set_workouts';
  @override
  VerificationContext validateIntegrity(Insertable<SetWorkout> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('volume')) {
      context.handle(_volumeMeta,
          volume.isAcceptableOrUnknown(data['volume'], _volumeMeta));
    } else if (isInserting) {
      context.missing(_volumeMeta);
    }
    if (data.containsKey('max_weight')) {
      context.handle(_maxWeightMeta,
          maxWeight.isAcceptableOrUnknown(data['max_weight'], _maxWeightMeta));
    } else if (isInserting) {
      context.missing(_maxWeightMeta);
    }
    if (data.containsKey('work_out_id')) {
      context.handle(_workOutIdMeta,
          workOutId.isAcceptableOrUnknown(data['work_out_id'], _workOutIdMeta));
    } else if (isInserting) {
      context.missing(_workOutIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id'], _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SetWorkout map(Map<String, dynamic> data, {String tablePrefix}) {
    return SetWorkout.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SetWorkoutsTable createAlias(String alias) {
    return $SetWorkoutsTable(attachedDatabase, alias);
  }
}

class Workout extends DataClass implements Insertable<Workout> {
  final int id;
  final DateTime date;
  final String metadata;
  Workout({@required this.id, @required this.date, @required this.metadata});
  factory Workout.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Workout(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
      metadata: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}metadata']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
    );
  }

  factory Workout.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Workout(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      metadata: serializer.fromJson<String>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'metadata': serializer.toJson<String>(metadata),
    };
  }

  Workout copyWith({int id, DateTime date, String metadata}) => Workout(
        id: id ?? this.id,
        date: date ?? this.date,
        metadata: metadata ?? this.metadata,
      );
  @override
  String toString() {
    return (StringBuffer('Workout(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, metadata);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workout &&
          other.id == this.id &&
          other.date == this.date &&
          other.metadata == this.metadata);
}

class WorkoutsCompanion extends UpdateCompanion<Workout> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> metadata;
  const WorkoutsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.metadata = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime date,
    @required String metadata,
  })  : date = Value(date),
        metadata = Value(metadata);
  static Insertable<Workout> custom({
    Expression<int> id,
    Expression<DateTime> date,
    Expression<String> metadata,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (metadata != null) 'metadata': metadata,
    });
  }

  WorkoutsCompanion copyWith(
      {Value<int> id, Value<DateTime> date, Value<String> metadata}) {
    return WorkoutsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts with TableInfo<$WorkoutsTable, Workout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $WorkoutsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedColumn<DateTime> _date;
  @override
  GeneratedColumn<DateTime> get date =>
      _date ??= GeneratedColumn<DateTime>('date', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _metadataMeta = const VerificationMeta('metadata');
  GeneratedColumn<String> _metadata;
  @override
  GeneratedColumn<String> get metadata =>
      _metadata ??= GeneratedColumn<String>('metadata', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, date, metadata];
  @override
  String get aliasedName => _alias ?? 'workouts';
  @override
  String get actualTableName => 'workouts';
  @override
  VerificationContext validateIntegrity(Insertable<Workout> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata'], _metadataMeta));
    } else if (isInserting) {
      context.missing(_metadataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workout map(Map<String, dynamic> data, {String tablePrefix}) {
    return Workout.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(attachedDatabase, alias);
  }
}

class Rep extends DataClass implements Insertable<Rep> {
  final int id;
  final double weight;
  final int reps;
  final int rpe;
  final String note;
  final int setId;
  Rep(
      {@required this.id,
      @required this.weight,
      @required this.reps,
      @required this.rpe,
      @required this.note,
      @required this.setId});
  factory Rep.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Rep(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      weight: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}weight']),
      reps: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}reps']),
      rpe: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}rpe']),
      note: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}note']),
      setId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}set_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || rpe != null) {
      map['rpe'] = Variable<int>(rpe);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || setId != null) {
      map['set_id'] = Variable<int>(setId);
    }
    return map;
  }

  RepsCompanion toCompanion(bool nullToAbsent) {
    return RepsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      rpe: rpe == null && nullToAbsent ? const Value.absent() : Value(rpe),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      setId:
          setId == null && nullToAbsent ? const Value.absent() : Value(setId),
    );
  }

  factory Rep.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Rep(
      id: serializer.fromJson<int>(json['id']),
      weight: serializer.fromJson<double>(json['weight']),
      reps: serializer.fromJson<int>(json['reps']),
      rpe: serializer.fromJson<int>(json['rpe']),
      note: serializer.fromJson<String>(json['note']),
      setId: serializer.fromJson<int>(json['setId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'weight': serializer.toJson<double>(weight),
      'reps': serializer.toJson<int>(reps),
      'rpe': serializer.toJson<int>(rpe),
      'note': serializer.toJson<String>(note),
      'setId': serializer.toJson<int>(setId),
    };
  }

  Rep copyWith(
          {int id, double weight, int reps, int rpe, String note, int setId}) =>
      Rep(
        id: id ?? this.id,
        weight: weight ?? this.weight,
        reps: reps ?? this.reps,
        rpe: rpe ?? this.rpe,
        note: note ?? this.note,
        setId: setId ?? this.setId,
      );
  @override
  String toString() {
    return (StringBuffer('Rep(')
          ..write('id: $id, ')
          ..write('weight: $weight, ')
          ..write('reps: $reps, ')
          ..write('rpe: $rpe, ')
          ..write('note: $note, ')
          ..write('setId: $setId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, weight, reps, rpe, note, setId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rep &&
          other.id == this.id &&
          other.weight == this.weight &&
          other.reps == this.reps &&
          other.rpe == this.rpe &&
          other.note == this.note &&
          other.setId == this.setId);
}

class RepsCompanion extends UpdateCompanion<Rep> {
  final Value<int> id;
  final Value<double> weight;
  final Value<int> reps;
  final Value<int> rpe;
  final Value<String> note;
  final Value<int> setId;
  const RepsCompanion({
    this.id = const Value.absent(),
    this.weight = const Value.absent(),
    this.reps = const Value.absent(),
    this.rpe = const Value.absent(),
    this.note = const Value.absent(),
    this.setId = const Value.absent(),
  });
  RepsCompanion.insert({
    this.id = const Value.absent(),
    @required double weight,
    @required int reps,
    @required int rpe,
    this.note = const Value.absent(),
    @required int setId,
  })  : weight = Value(weight),
        reps = Value(reps),
        rpe = Value(rpe),
        setId = Value(setId);
  static Insertable<Rep> custom({
    Expression<int> id,
    Expression<double> weight,
    Expression<int> reps,
    Expression<int> rpe,
    Expression<String> note,
    Expression<int> setId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weight != null) 'weight': weight,
      if (reps != null) 'reps': reps,
      if (rpe != null) 'rpe': rpe,
      if (note != null) 'note': note,
      if (setId != null) 'set_id': setId,
    });
  }

  RepsCompanion copyWith(
      {Value<int> id,
      Value<double> weight,
      Value<int> reps,
      Value<int> rpe,
      Value<String> note,
      Value<int> setId}) {
    return RepsCompanion(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      rpe: rpe ?? this.rpe,
      note: note ?? this.note,
      setId: setId ?? this.setId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (rpe.present) {
      map['rpe'] = Variable<int>(rpe.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (setId.present) {
      map['set_id'] = Variable<int>(setId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepsCompanion(')
          ..write('id: $id, ')
          ..write('weight: $weight, ')
          ..write('reps: $reps, ')
          ..write('rpe: $rpe, ')
          ..write('note: $note, ')
          ..write('setId: $setId')
          ..write(')'))
        .toString();
  }
}

class $RepsTable extends Reps with TableInfo<$RepsTable, Rep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $RepsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _weightMeta = const VerificationMeta('weight');
  GeneratedColumn<double> _weight;
  @override
  GeneratedColumn<double> get weight =>
      _weight ??= GeneratedColumn<double>('weight', aliasedName, false,
          type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _repsMeta = const VerificationMeta('reps');
  GeneratedColumn<int> _reps;
  @override
  GeneratedColumn<int> get reps =>
      _reps ??= GeneratedColumn<int>('reps', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  GeneratedColumn<int> _rpe;
  @override
  GeneratedColumn<int> get rpe =>
      _rpe ??= GeneratedColumn<int>('rpe', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _noteMeta = const VerificationMeta('note');
  GeneratedColumn<String> _note;
  @override
  GeneratedColumn<String> get note =>
      _note ??= GeneratedColumn<String>('note', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 155),
          type: const StringType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(""));
  final VerificationMeta _setIdMeta = const VerificationMeta('setId');
  GeneratedColumn<int> _setId;
  @override
  GeneratedColumn<int> get setId =>
      _setId ??= GeneratedColumn<int>('set_id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL REFERENCES sets (id)');
  @override
  List<GeneratedColumn> get $columns => [id, weight, reps, rpe, note, setId];
  @override
  String get aliasedName => _alias ?? 'reps';
  @override
  String get actualTableName => 'reps';
  @override
  VerificationContext validateIntegrity(Insertable<Rep> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight'], _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps'], _repsMeta));
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('rpe')) {
      context.handle(
          _rpeMeta, rpe.isAcceptableOrUnknown(data['rpe'], _rpeMeta));
    } else if (isInserting) {
      context.missing(_rpeMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note'], _noteMeta));
    }
    if (data.containsKey('set_id')) {
      context.handle(
          _setIdMeta, setId.isAcceptableOrUnknown(data['set_id'], _setIdMeta));
    } else if (isInserting) {
      context.missing(_setIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Rep map(Map<String, dynamic> data, {String tablePrefix}) {
    return Rep.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RepsTable createAlias(String alias) {
    return $RepsTable(attachedDatabase, alias);
  }
}

class RoutineGroupData extends DataClass
    implements Insertable<RoutineGroupData> {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final Level level;
  RoutineGroupData(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.imageUrl,
      @required this.level});
  factory RoutineGroupData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return RoutineGroupData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      imageUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_url']),
      level: $RoutineGroupTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}level'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || level != null) {
      final converter = $RoutineGroupTable.$converter0;
      map['level'] = Variable<int>(converter.mapToSql(level));
    }
    return map;
  }

  RoutineGroupCompanion toCompanion(bool nullToAbsent) {
    return RoutineGroupCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      level:
          level == null && nullToAbsent ? const Value.absent() : Value(level),
    );
  }

  factory RoutineGroupData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return RoutineGroupData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      level: serializer.fromJson<Level>(json['level']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'level': serializer.toJson<Level>(level),
    };
  }

  RoutineGroupData copyWith(
          {int id,
          String name,
          String description,
          String imageUrl,
          Level level}) =>
      RoutineGroupData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        level: level ?? this.level,
      );
  @override
  String toString() {
    return (StringBuffer('RoutineGroupData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('level: $level')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, imageUrl, level);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineGroupData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.level == this.level);
}

class RoutineGroupCompanion extends UpdateCompanion<RoutineGroupData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> imageUrl;
  final Value<Level> level;
  const RoutineGroupCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.level = const Value.absent(),
  });
  RoutineGroupCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String description,
    @required String imageUrl,
    @required Level level,
  })  : name = Value(name),
        description = Value(description),
        imageUrl = Value(imageUrl),
        level = Value(level);
  static Insertable<RoutineGroupData> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> description,
    Expression<String> imageUrl,
    Expression<Level> level,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (level != null) 'level': level,
    });
  }

  RoutineGroupCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<String> imageUrl,
      Value<Level> level}) {
    return RoutineGroupCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      level: level ?? this.level,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (level.present) {
      final converter = $RoutineGroupTable.$converter0;
      map['level'] = Variable<int>(converter.mapToSql(level.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineGroupCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('level: $level')
          ..write(')'))
        .toString();
  }
}

class $RoutineGroupTable extends RoutineGroup
    with TableInfo<$RoutineGroupTable, RoutineGroupData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $RoutineGroupTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name =>
      _name ??= GeneratedColumn<String>('name', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedColumn<String> _description;
  @override
  GeneratedColumn<String> get description => _description ??=
      GeneratedColumn<String>('description', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 0, maxTextLength: 250),
          type: const StringType(),
          requiredDuringInsert: true);
  final VerificationMeta _imageUrlMeta = const VerificationMeta('imageUrl');
  GeneratedColumn<String> _imageUrl;
  @override
  GeneratedColumn<String> get imageUrl =>
      _imageUrl ??= GeneratedColumn<String>('image_url', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _levelMeta = const VerificationMeta('level');
  GeneratedColumnWithTypeConverter<Level, int> _level;
  @override
  GeneratedColumnWithTypeConverter<Level, int> get level =>
      _level ??= GeneratedColumn<int>('level', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<Level>($RoutineGroupTable.$converter0);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, imageUrl, level];
  @override
  String get aliasedName => _alias ?? 'routine_group';
  @override
  String get actualTableName => 'routine_group';
  @override
  VerificationContext validateIntegrity(Insertable<RoutineGroupData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url'], _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    context.handle(_levelMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineGroupData map(Map<String, dynamic> data, {String tablePrefix}) {
    return RoutineGroupData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RoutineGroupTable createAlias(String alias) {
    return $RoutineGroupTable(attachedDatabase, alias);
  }

  static TypeConverter<Level, int> $converter0 =
      const EnumIndexConverter<Level>(Level.values);
}

class RoutineData extends DataClass implements Insertable<RoutineData> {
  final int id;
  final int groupId;
  final String name;
  final int duration;
  final Difficulty difficulty;
  final String notes;
  final int timesCopied;
  final RoutineBodyParts bodyParts;
  RoutineData(
      {@required this.id,
      @required this.groupId,
      @required this.name,
      @required this.duration,
      @required this.difficulty,
      @required this.notes,
      @required this.timesCopied,
      this.bodyParts});
  factory RoutineData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return RoutineData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      groupId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}group_id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      duration: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration']),
      difficulty: $RoutineTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}difficulty'])),
      notes: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}notes']),
      timesCopied: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}times_copied']),
      bodyParts: $RoutineTable.$converter1.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}body_parts'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<int>(groupId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || difficulty != null) {
      final converter = $RoutineTable.$converter0;
      map['difficulty'] = Variable<int>(converter.mapToSql(difficulty));
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || timesCopied != null) {
      map['times_copied'] = Variable<int>(timesCopied);
    }
    if (!nullToAbsent || bodyParts != null) {
      final converter = $RoutineTable.$converter1;
      map['body_parts'] = Variable<String>(converter.mapToSql(bodyParts));
    }
    return map;
  }

  RoutineCompanion toCompanion(bool nullToAbsent) {
    return RoutineCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      timesCopied: timesCopied == null && nullToAbsent
          ? const Value.absent()
          : Value(timesCopied),
      bodyParts: bodyParts == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyParts),
    );
  }

  factory RoutineData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return RoutineData(
      id: serializer.fromJson<int>(json['id']),
      groupId: serializer.fromJson<int>(json['groupId']),
      name: serializer.fromJson<String>(json['name']),
      duration: serializer.fromJson<int>(json['duration']),
      difficulty: serializer.fromJson<Difficulty>(json['difficulty']),
      notes: serializer.fromJson<String>(json['notes']),
      timesCopied: serializer.fromJson<int>(json['timesCopied']),
      bodyParts: serializer.fromJson<RoutineBodyParts>(json['bodyParts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupId': serializer.toJson<int>(groupId),
      'name': serializer.toJson<String>(name),
      'duration': serializer.toJson<int>(duration),
      'difficulty': serializer.toJson<Difficulty>(difficulty),
      'notes': serializer.toJson<String>(notes),
      'timesCopied': serializer.toJson<int>(timesCopied),
      'bodyParts': serializer.toJson<RoutineBodyParts>(bodyParts),
    };
  }

  RoutineData copyWith(
          {int id,
          int groupId,
          String name,
          int duration,
          Difficulty difficulty,
          String notes,
          int timesCopied,
          RoutineBodyParts bodyParts}) =>
      RoutineData(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        name: name ?? this.name,
        duration: duration ?? this.duration,
        difficulty: difficulty ?? this.difficulty,
        notes: notes ?? this.notes,
        timesCopied: timesCopied ?? this.timesCopied,
        bodyParts: bodyParts ?? this.bodyParts,
      );
  @override
  String toString() {
    return (StringBuffer('RoutineData(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('duration: $duration, ')
          ..write('difficulty: $difficulty, ')
          ..write('notes: $notes, ')
          ..write('timesCopied: $timesCopied, ')
          ..write('bodyParts: $bodyParts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, groupId, name, duration, difficulty, notes, timesCopied, bodyParts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineData &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.name == this.name &&
          other.duration == this.duration &&
          other.difficulty == this.difficulty &&
          other.notes == this.notes &&
          other.timesCopied == this.timesCopied &&
          other.bodyParts == this.bodyParts);
}

class RoutineCompanion extends UpdateCompanion<RoutineData> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<String> name;
  final Value<int> duration;
  final Value<Difficulty> difficulty;
  final Value<String> notes;
  final Value<int> timesCopied;
  final Value<RoutineBodyParts> bodyParts;
  const RoutineCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.name = const Value.absent(),
    this.duration = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.notes = const Value.absent(),
    this.timesCopied = const Value.absent(),
    this.bodyParts = const Value.absent(),
  });
  RoutineCompanion.insert({
    this.id = const Value.absent(),
    @required int groupId,
    @required String name,
    @required int duration,
    @required Difficulty difficulty,
    this.notes = const Value.absent(),
    this.timesCopied = const Value.absent(),
    this.bodyParts = const Value.absent(),
  })  : groupId = Value(groupId),
        name = Value(name),
        duration = Value(duration),
        difficulty = Value(difficulty);
  static Insertable<RoutineData> custom({
    Expression<int> id,
    Expression<int> groupId,
    Expression<String> name,
    Expression<int> duration,
    Expression<Difficulty> difficulty,
    Expression<String> notes,
    Expression<int> timesCopied,
    Expression<RoutineBodyParts> bodyParts,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (name != null) 'name': name,
      if (duration != null) 'duration': duration,
      if (difficulty != null) 'difficulty': difficulty,
      if (notes != null) 'notes': notes,
      if (timesCopied != null) 'times_copied': timesCopied,
      if (bodyParts != null) 'body_parts': bodyParts,
    });
  }

  RoutineCompanion copyWith(
      {Value<int> id,
      Value<int> groupId,
      Value<String> name,
      Value<int> duration,
      Value<Difficulty> difficulty,
      Value<String> notes,
      Value<int> timesCopied,
      Value<RoutineBodyParts> bodyParts}) {
    return RoutineCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      difficulty: difficulty ?? this.difficulty,
      notes: notes ?? this.notes,
      timesCopied: timesCopied ?? this.timesCopied,
      bodyParts: bodyParts ?? this.bodyParts,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (difficulty.present) {
      final converter = $RoutineTable.$converter0;
      map['difficulty'] = Variable<int>(converter.mapToSql(difficulty.value));
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (timesCopied.present) {
      map['times_copied'] = Variable<int>(timesCopied.value);
    }
    if (bodyParts.present) {
      final converter = $RoutineTable.$converter1;
      map['body_parts'] = Variable<String>(converter.mapToSql(bodyParts.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('duration: $duration, ')
          ..write('difficulty: $difficulty, ')
          ..write('notes: $notes, ')
          ..write('timesCopied: $timesCopied, ')
          ..write('bodyParts: $bodyParts')
          ..write(')'))
        .toString();
  }
}

class $RoutineTable extends Routine with TableInfo<$RoutineTable, RoutineData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $RoutineTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _groupIdMeta = const VerificationMeta('groupId');
  GeneratedColumn<int> _groupId;
  @override
  GeneratedColumn<int> get groupId =>
      _groupId ??= GeneratedColumn<int>('group_id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL REFERENCES grouproutines (id)');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name =>
      _name ??= GeneratedColumn<String>('name', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  GeneratedColumn<int> _duration;
  @override
  GeneratedColumn<int> get duration =>
      _duration ??= GeneratedColumn<int>('duration', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _difficultyMeta = const VerificationMeta('difficulty');
  GeneratedColumnWithTypeConverter<Difficulty, int> _difficulty;
  @override
  GeneratedColumnWithTypeConverter<Difficulty, int> get difficulty =>
      _difficulty ??= GeneratedColumn<int>('difficulty', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<Difficulty>($RoutineTable.$converter0);
  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedColumn<String> _notes;
  @override
  GeneratedColumn<String> get notes =>
      _notes ??= GeneratedColumn<String>('notes', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 155),
          type: const StringType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(""));
  final VerificationMeta _timesCopiedMeta =
      const VerificationMeta('timesCopied');
  GeneratedColumn<int> _timesCopied;
  @override
  GeneratedColumn<int> get timesCopied =>
      _timesCopied ??= GeneratedColumn<int>('times_copied', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  final VerificationMeta _bodyPartsMeta = const VerificationMeta('bodyParts');
  GeneratedColumnWithTypeConverter<RoutineBodyParts, String> _bodyParts;
  @override
  GeneratedColumnWithTypeConverter<RoutineBodyParts, String> get bodyParts =>
      _bodyParts ??= GeneratedColumn<String>('body_parts', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<RoutineBodyParts>($RoutineTable.$converter1);
  @override
  List<GeneratedColumn> get $columns =>
      [id, groupId, name, duration, difficulty, notes, timesCopied, bodyParts];
  @override
  String get aliasedName => _alias ?? 'routine';
  @override
  String get actualTableName => 'routine';
  @override
  VerificationContext validateIntegrity(Insertable<RoutineData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id'], _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration'], _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    context.handle(_difficultyMeta, const VerificationResult.success());
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes'], _notesMeta));
    }
    if (data.containsKey('times_copied')) {
      context.handle(
          _timesCopiedMeta,
          timesCopied.isAcceptableOrUnknown(
              data['times_copied'], _timesCopiedMeta));
    }
    context.handle(_bodyPartsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineData map(Map<String, dynamic> data, {String tablePrefix}) {
    return RoutineData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RoutineTable createAlias(String alias) {
    return $RoutineTable(attachedDatabase, alias);
  }

  static TypeConverter<Difficulty, int> $converter0 =
      const EnumIndexConverter<Difficulty>(Difficulty.values);
  static TypeConverter<RoutineBodyParts, String> $converter1 =
      const RoutineBodyPartsConverter();
}

class RoutineSetData extends DataClass implements Insertable<RoutineSetData> {
  final int id;
  final String exerciseName;
  final int exerciseId;
  final int routineId;
  final int series;
  final double repmax;
  final double percentage;
  final CopyMethod copyMethod;
  final int targetRpe;
  final String notes;
  RoutineSetData(
      {@required this.id,
      @required this.exerciseName,
      @required this.exerciseId,
      @required this.routineId,
      @required this.series,
      this.repmax,
      @required this.percentage,
      @required this.copyMethod,
      @required this.targetRpe,
      @required this.notes});
  factory RoutineSetData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return RoutineSetData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      exerciseName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}exercise_name']),
      exerciseId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}exercise_id']),
      routineId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}routine_id']),
      series: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}series']),
      repmax: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}repmax']),
      percentage: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}percentage']),
      copyMethod: $RoutineSetTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}copy_method'])),
      targetRpe: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}target_rpe']),
      notes: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}notes']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || exerciseName != null) {
      map['exercise_name'] = Variable<String>(exerciseName);
    }
    if (!nullToAbsent || exerciseId != null) {
      map['exercise_id'] = Variable<int>(exerciseId);
    }
    if (!nullToAbsent || routineId != null) {
      map['routine_id'] = Variable<int>(routineId);
    }
    if (!nullToAbsent || series != null) {
      map['series'] = Variable<int>(series);
    }
    if (!nullToAbsent || repmax != null) {
      map['repmax'] = Variable<double>(repmax);
    }
    if (!nullToAbsent || percentage != null) {
      map['percentage'] = Variable<double>(percentage);
    }
    if (!nullToAbsent || copyMethod != null) {
      final converter = $RoutineSetTable.$converter0;
      map['copy_method'] = Variable<int>(converter.mapToSql(copyMethod));
    }
    if (!nullToAbsent || targetRpe != null) {
      map['target_rpe'] = Variable<int>(targetRpe);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  RoutineSetCompanion toCompanion(bool nullToAbsent) {
    return RoutineSetCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      exerciseName: exerciseName == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseName),
      exerciseId: exerciseId == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseId),
      routineId: routineId == null && nullToAbsent
          ? const Value.absent()
          : Value(routineId),
      series:
          series == null && nullToAbsent ? const Value.absent() : Value(series),
      repmax:
          repmax == null && nullToAbsent ? const Value.absent() : Value(repmax),
      percentage: percentage == null && nullToAbsent
          ? const Value.absent()
          : Value(percentage),
      copyMethod: copyMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(copyMethod),
      targetRpe: targetRpe == null && nullToAbsent
          ? const Value.absent()
          : Value(targetRpe),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory RoutineSetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return RoutineSetData(
      id: serializer.fromJson<int>(json['id']),
      exerciseName: serializer.fromJson<String>(json['exerciseName']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      routineId: serializer.fromJson<int>(json['routineId']),
      series: serializer.fromJson<int>(json['series']),
      repmax: serializer.fromJson<double>(json['repmax']),
      percentage: serializer.fromJson<double>(json['percentage']),
      copyMethod: serializer.fromJson<CopyMethod>(json['copyMethod']),
      targetRpe: serializer.fromJson<int>(json['targetRpe']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseName': serializer.toJson<String>(exerciseName),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'routineId': serializer.toJson<int>(routineId),
      'series': serializer.toJson<int>(series),
      'repmax': serializer.toJson<double>(repmax),
      'percentage': serializer.toJson<double>(percentage),
      'copyMethod': serializer.toJson<CopyMethod>(copyMethod),
      'targetRpe': serializer.toJson<int>(targetRpe),
      'notes': serializer.toJson<String>(notes),
    };
  }

  RoutineSetData copyWith(
          {int id,
          String exerciseName,
          int exerciseId,
          int routineId,
          int series,
          double repmax,
          double percentage,
          CopyMethod copyMethod,
          int targetRpe,
          String notes}) =>
      RoutineSetData(
        id: id ?? this.id,
        exerciseName: exerciseName ?? this.exerciseName,
        exerciseId: exerciseId ?? this.exerciseId,
        routineId: routineId ?? this.routineId,
        series: series ?? this.series,
        repmax: repmax ?? this.repmax,
        percentage: percentage ?? this.percentage,
        copyMethod: copyMethod ?? this.copyMethod,
        targetRpe: targetRpe ?? this.targetRpe,
        notes: notes ?? this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('RoutineSetData(')
          ..write('id: $id, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('routineId: $routineId, ')
          ..write('series: $series, ')
          ..write('repmax: $repmax, ')
          ..write('percentage: $percentage, ')
          ..write('copyMethod: $copyMethod, ')
          ..write('targetRpe: $targetRpe, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseName, exerciseId, routineId,
      series, repmax, percentage, copyMethod, targetRpe, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineSetData &&
          other.id == this.id &&
          other.exerciseName == this.exerciseName &&
          other.exerciseId == this.exerciseId &&
          other.routineId == this.routineId &&
          other.series == this.series &&
          other.repmax == this.repmax &&
          other.percentage == this.percentage &&
          other.copyMethod == this.copyMethod &&
          other.targetRpe == this.targetRpe &&
          other.notes == this.notes);
}

class RoutineSetCompanion extends UpdateCompanion<RoutineSetData> {
  final Value<int> id;
  final Value<String> exerciseName;
  final Value<int> exerciseId;
  final Value<int> routineId;
  final Value<int> series;
  final Value<double> repmax;
  final Value<double> percentage;
  final Value<CopyMethod> copyMethod;
  final Value<int> targetRpe;
  final Value<String> notes;
  const RoutineSetCompanion({
    this.id = const Value.absent(),
    this.exerciseName = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.routineId = const Value.absent(),
    this.series = const Value.absent(),
    this.repmax = const Value.absent(),
    this.percentage = const Value.absent(),
    this.copyMethod = const Value.absent(),
    this.targetRpe = const Value.absent(),
    this.notes = const Value.absent(),
  });
  RoutineSetCompanion.insert({
    this.id = const Value.absent(),
    @required String exerciseName,
    @required int exerciseId,
    @required int routineId,
    this.series = const Value.absent(),
    this.repmax = const Value.absent(),
    this.percentage = const Value.absent(),
    @required CopyMethod copyMethod,
    @required int targetRpe,
    this.notes = const Value.absent(),
  })  : exerciseName = Value(exerciseName),
        exerciseId = Value(exerciseId),
        routineId = Value(routineId),
        copyMethod = Value(copyMethod),
        targetRpe = Value(targetRpe);
  static Insertable<RoutineSetData> custom({
    Expression<int> id,
    Expression<String> exerciseName,
    Expression<int> exerciseId,
    Expression<int> routineId,
    Expression<int> series,
    Expression<double> repmax,
    Expression<double> percentage,
    Expression<CopyMethod> copyMethod,
    Expression<int> targetRpe,
    Expression<String> notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseName != null) 'exercise_name': exerciseName,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (routineId != null) 'routine_id': routineId,
      if (series != null) 'series': series,
      if (repmax != null) 'repmax': repmax,
      if (percentage != null) 'percentage': percentage,
      if (copyMethod != null) 'copy_method': copyMethod,
      if (targetRpe != null) 'target_rpe': targetRpe,
      if (notes != null) 'notes': notes,
    });
  }

  RoutineSetCompanion copyWith(
      {Value<int> id,
      Value<String> exerciseName,
      Value<int> exerciseId,
      Value<int> routineId,
      Value<int> series,
      Value<double> repmax,
      Value<double> percentage,
      Value<CopyMethod> copyMethod,
      Value<int> targetRpe,
      Value<String> notes}) {
    return RoutineSetCompanion(
      id: id ?? this.id,
      exerciseName: exerciseName ?? this.exerciseName,
      exerciseId: exerciseId ?? this.exerciseId,
      routineId: routineId ?? this.routineId,
      series: series ?? this.series,
      repmax: repmax ?? this.repmax,
      percentage: percentage ?? this.percentage,
      copyMethod: copyMethod ?? this.copyMethod,
      targetRpe: targetRpe ?? this.targetRpe,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<int>(routineId.value);
    }
    if (series.present) {
      map['series'] = Variable<int>(series.value);
    }
    if (repmax.present) {
      map['repmax'] = Variable<double>(repmax.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    if (copyMethod.present) {
      final converter = $RoutineSetTable.$converter0;
      map['copy_method'] = Variable<int>(converter.mapToSql(copyMethod.value));
    }
    if (targetRpe.present) {
      map['target_rpe'] = Variable<int>(targetRpe.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineSetCompanion(')
          ..write('id: $id, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('routineId: $routineId, ')
          ..write('series: $series, ')
          ..write('repmax: $repmax, ')
          ..write('percentage: $percentage, ')
          ..write('copyMethod: $copyMethod, ')
          ..write('targetRpe: $targetRpe, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $RoutineSetTable extends RoutineSet
    with TableInfo<$RoutineSetTable, RoutineSetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $RoutineSetTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _exerciseNameMeta =
      const VerificationMeta('exerciseName');
  GeneratedColumn<String> _exerciseName;
  @override
  GeneratedColumn<String> get exerciseName => _exerciseName ??=
      GeneratedColumn<String>('exercise_name', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _exerciseIdMeta = const VerificationMeta('exerciseId');
  GeneratedColumn<int> _exerciseId;
  @override
  GeneratedColumn<int> get exerciseId =>
      _exerciseId ??= GeneratedColumn<int>('exercise_id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL REFERENCES exercises (id)');
  final VerificationMeta _routineIdMeta = const VerificationMeta('routineId');
  GeneratedColumn<int> _routineId;
  @override
  GeneratedColumn<int> get routineId =>
      _routineId ??= GeneratedColumn<int>('routine_id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL REFERENCES routines (id)');
  final VerificationMeta _seriesMeta = const VerificationMeta('series');
  GeneratedColumn<int> _series;
  @override
  GeneratedColumn<int> get series =>
      _series ??= GeneratedColumn<int>('series', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(3));
  final VerificationMeta _repmaxMeta = const VerificationMeta('repmax');
  GeneratedColumn<double> _repmax;
  @override
  GeneratedColumn<double> get repmax =>
      _repmax ??= GeneratedColumn<double>('repmax', aliasedName, true,
          type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _percentageMeta = const VerificationMeta('percentage');
  GeneratedColumn<double> _percentage;
  @override
  GeneratedColumn<double> get percentage =>
      _percentage ??= GeneratedColumn<double>('percentage', aliasedName, false,
          type: const RealType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  final VerificationMeta _copyMethodMeta = const VerificationMeta('copyMethod');
  GeneratedColumnWithTypeConverter<CopyMethod, int> _copyMethod;
  @override
  GeneratedColumnWithTypeConverter<CopyMethod, int> get copyMethod =>
      _copyMethod ??= GeneratedColumn<int>('copy_method', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<CopyMethod>($RoutineSetTable.$converter0);
  final VerificationMeta _targetRpeMeta = const VerificationMeta('targetRpe');
  GeneratedColumn<int> _targetRpe;
  @override
  GeneratedColumn<int> get targetRpe =>
      _targetRpe ??= GeneratedColumn<int>('target_rpe', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedColumn<String> _notes;
  @override
  GeneratedColumn<String> get notes =>
      _notes ??= GeneratedColumn<String>('notes', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 155),
          type: const StringType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(""));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        exerciseName,
        exerciseId,
        routineId,
        series,
        repmax,
        percentage,
        copyMethod,
        targetRpe,
        notes
      ];
  @override
  String get aliasedName => _alias ?? 'routine_set';
  @override
  String get actualTableName => 'routine_set';
  @override
  VerificationContext validateIntegrity(Insertable<RoutineSetData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
          _exerciseNameMeta,
          exerciseName.isAcceptableOrUnknown(
              data['exercise_name'], _exerciseNameMeta));
    } else if (isInserting) {
      context.missing(_exerciseNameMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id'], _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(_routineIdMeta,
          routineId.isAcceptableOrUnknown(data['routine_id'], _routineIdMeta));
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('series')) {
      context.handle(_seriesMeta,
          series.isAcceptableOrUnknown(data['series'], _seriesMeta));
    }
    if (data.containsKey('repmax')) {
      context.handle(_repmaxMeta,
          repmax.isAcceptableOrUnknown(data['repmax'], _repmaxMeta));
    }
    if (data.containsKey('percentage')) {
      context.handle(
          _percentageMeta,
          percentage.isAcceptableOrUnknown(
              data['percentage'], _percentageMeta));
    }
    context.handle(_copyMethodMeta, const VerificationResult.success());
    if (data.containsKey('target_rpe')) {
      context.handle(_targetRpeMeta,
          targetRpe.isAcceptableOrUnknown(data['target_rpe'], _targetRpeMeta));
    } else if (isInserting) {
      context.missing(_targetRpeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes'], _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineSetData map(Map<String, dynamic> data, {String tablePrefix}) {
    return RoutineSetData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RoutineSetTable createAlias(String alias) {
    return $RoutineSetTable(attachedDatabase, alias);
  }

  static TypeConverter<CopyMethod, int> $converter0 =
      const EnumIndexConverter<CopyMethod>(CopyMethod.values);
}

class Preference extends DataClass implements Insertable<Preference> {
  final int id;
  final String key;
  final String value;
  Preference({@required this.id, @required this.key, @required this.value});
  factory Preference.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Preference(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      key: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}key']),
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || key != null) {
      map['key'] = Variable<String>(key);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  PreferencesCompanion toCompanion(bool nullToAbsent) {
    return PreferencesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      key: key == null && nullToAbsent ? const Value.absent() : Value(key),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
    );
  }

  factory Preference.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Preference(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  Preference copyWith({int id, String key, String value}) => Preference(
        id: id ?? this.id,
        key: key ?? this.key,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('Preference(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Preference &&
          other.id == this.id &&
          other.key == this.key &&
          other.value == this.value);
}

class PreferencesCompanion extends UpdateCompanion<Preference> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> value;
  const PreferencesCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
  });
  PreferencesCompanion.insert({
    this.id = const Value.absent(),
    @required String key,
    @required String value,
  })  : key = Value(key),
        value = Value(value);
  static Insertable<Preference> custom({
    Expression<int> id,
    Expression<String> key,
    Expression<String> value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
    });
  }

  PreferencesCompanion copyWith(
      {Value<int> id, Value<String> key, Value<String> value}) {
    return PreferencesCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferencesCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $PreferencesTable extends Preferences
    with TableInfo<$PreferencesTable, Preference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String _alias;
  $PreferencesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _keyMeta = const VerificationMeta('key');
  GeneratedColumn<String> _key;
  @override
  GeneratedColumn<String> get key =>
      _key ??= GeneratedColumn<String>('key', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedColumn<String> _value;
  @override
  GeneratedColumn<String> get value =>
      _value ??= GeneratedColumn<String>('value', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, key, value];
  @override
  String get aliasedName => _alias ?? 'preferences';
  @override
  String get actualTableName => 'preferences';
  @override
  VerificationContext validateIntegrity(Insertable<Preference> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key'], _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value'], _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Preference map(Map<String, dynamic> data, {String tablePrefix}) {
    return Preference.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PreferencesTable createAlias(String alias) {
    return $PreferencesTable(attachedDatabase, alias);
  }
}

abstract class _$SQLDatabase extends GeneratedDatabase {
  _$SQLDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ExercisesTable _exercises;
  $ExercisesTable get exercises => _exercises ??= $ExercisesTable(this);
  $ExerciseBodyPartsTable _exerciseBodyParts;
  $ExerciseBodyPartsTable get exerciseBodyParts =>
      _exerciseBodyParts ??= $ExerciseBodyPartsTable(this);
  $MigrationsTable _migrations;
  $MigrationsTable get migrations => _migrations ??= $MigrationsTable(this);
  $SetWorkoutsTable _setWorkouts;
  $SetWorkoutsTable get setWorkouts => _setWorkouts ??= $SetWorkoutsTable(this);
  $WorkoutsTable _workouts;
  $WorkoutsTable get workouts => _workouts ??= $WorkoutsTable(this);
  $RepsTable _reps;
  $RepsTable get reps => _reps ??= $RepsTable(this);
  $RoutineGroupTable _routineGroup;
  $RoutineGroupTable get routineGroup =>
      _routineGroup ??= $RoutineGroupTable(this);
  $RoutineTable _routine;
  $RoutineTable get routine => _routine ??= $RoutineTable(this);
  $RoutineSetTable _routineSet;
  $RoutineSetTable get routineSet => _routineSet ??= $RoutineSetTable(this);
  $PreferencesTable _preferences;
  $PreferencesTable get preferences => _preferences ??= $PreferencesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        exercises,
        exerciseBodyParts,
        migrations,
        setWorkouts,
        workouts,
        reps,
        routineGroup,
        routine,
        routineSet,
        preferences
      ];
}
