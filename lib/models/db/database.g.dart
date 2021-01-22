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
  final double maxWeigth;
  final String notes;
  final Difficulty difficulty;
  Exercise(
      {@required this.id,
      @required this.name,
      @required this.lastWorkouts,
      @required this.maxVolume,
      @required this.maxWeigth,
      @required this.notes,
      @required this.difficulty});
  factory Exercise.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Exercise(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      lastWorkouts: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_workouts']),
      maxVolume: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}max_volume']),
      maxWeigth: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}max_weigth']),
      notes:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}notes']),
      difficulty: $ExercisesTable.$converter0.mapToDart(intType
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
    if (!nullToAbsent || maxWeigth != null) {
      map['max_weigth'] = Variable<double>(maxWeigth);
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
      maxWeigth: maxWeigth == null && nullToAbsent
          ? const Value.absent()
          : Value(maxWeigth),
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
      maxWeigth: serializer.fromJson<double>(json['maxWeigth']),
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
      'maxWeigth': serializer.toJson<double>(maxWeigth),
      'notes': serializer.toJson<String>(notes),
      'difficulty': serializer.toJson<Difficulty>(difficulty),
    };
  }

  Exercise copyWith(
          {int id,
          String name,
          String lastWorkouts,
          double maxVolume,
          double maxWeigth,
          String notes,
          Difficulty difficulty}) =>
      Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        lastWorkouts: lastWorkouts ?? this.lastWorkouts,
        maxVolume: maxVolume ?? this.maxVolume,
        maxWeigth: maxWeigth ?? this.maxWeigth,
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
          ..write('maxWeigth: $maxWeigth, ')
          ..write('notes: $notes, ')
          ..write('difficulty: $difficulty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              lastWorkouts.hashCode,
              $mrjc(
                  maxVolume.hashCode,
                  $mrjc(maxWeigth.hashCode,
                      $mrjc(notes.hashCode, difficulty.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastWorkouts == this.lastWorkouts &&
          other.maxVolume == this.maxVolume &&
          other.maxWeigth == this.maxWeigth &&
          other.notes == this.notes &&
          other.difficulty == this.difficulty);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> lastWorkouts;
  final Value<double> maxVolume;
  final Value<double> maxWeigth;
  final Value<String> notes;
  final Value<Difficulty> difficulty;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastWorkouts = const Value.absent(),
    this.maxVolume = const Value.absent(),
    this.maxWeigth = const Value.absent(),
    this.notes = const Value.absent(),
    this.difficulty = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String lastWorkouts,
    @required double maxVolume,
    @required double maxWeigth,
    @required String notes,
    @required Difficulty difficulty,
  })  : name = Value(name),
        lastWorkouts = Value(lastWorkouts),
        maxVolume = Value(maxVolume),
        maxWeigth = Value(maxWeigth),
        notes = Value(notes),
        difficulty = Value(difficulty);
  static Insertable<Exercise> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> lastWorkouts,
    Expression<double> maxVolume,
    Expression<double> maxWeigth,
    Expression<String> notes,
    Expression<int> difficulty,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastWorkouts != null) 'last_workouts': lastWorkouts,
      if (maxVolume != null) 'max_volume': maxVolume,
      if (maxWeigth != null) 'max_weigth': maxWeigth,
      if (notes != null) 'notes': notes,
      if (difficulty != null) 'difficulty': difficulty,
    });
  }

  ExercisesCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> lastWorkouts,
      Value<double> maxVolume,
      Value<double> maxWeigth,
      Value<String> notes,
      Value<Difficulty> difficulty}) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lastWorkouts: lastWorkouts ?? this.lastWorkouts,
      maxVolume: maxVolume ?? this.maxVolume,
      maxWeigth: maxWeigth ?? this.maxWeigth,
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
    if (maxWeigth.present) {
      map['max_weigth'] = Variable<double>(maxWeigth.value);
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
          ..write('maxWeigth: $maxWeigth, ')
          ..write('notes: $notes, ')
          ..write('difficulty: $difficulty')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  final GeneratedDatabase _db;
  final String _alias;
  $ExercisesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _lastWorkoutsMeta =
      const VerificationMeta('lastWorkouts');
  GeneratedTextColumn _lastWorkouts;
  @override
  GeneratedTextColumn get lastWorkouts =>
      _lastWorkouts ??= _constructLastWorkouts();
  GeneratedTextColumn _constructLastWorkouts() {
    return GeneratedTextColumn(
      'last_workouts',
      $tableName,
      false,
    );
  }

  final VerificationMeta _maxVolumeMeta = const VerificationMeta('maxVolume');
  GeneratedRealColumn _maxVolume;
  @override
  GeneratedRealColumn get maxVolume => _maxVolume ??= _constructMaxVolume();
  GeneratedRealColumn _constructMaxVolume() {
    return GeneratedRealColumn(
      'max_volume',
      $tableName,
      false,
    );
  }

  final VerificationMeta _maxWeigthMeta = const VerificationMeta('maxWeigth');
  GeneratedRealColumn _maxWeigth;
  @override
  GeneratedRealColumn get maxWeigth => _maxWeigth ??= _constructMaxWeigth();
  GeneratedRealColumn _constructMaxWeigth() {
    return GeneratedRealColumn(
      'max_weigth',
      $tableName,
      false,
    );
  }

  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedTextColumn _notes;
  @override
  GeneratedTextColumn get notes => _notes ??= _constructNotes();
  GeneratedTextColumn _constructNotes() {
    return GeneratedTextColumn('notes', $tableName, false,
        minTextLength: 1, maxTextLength: 200);
  }

  final VerificationMeta _difficultyMeta = const VerificationMeta('difficulty');
  GeneratedIntColumn _difficulty;
  @override
  GeneratedIntColumn get difficulty => _difficulty ??= _constructDifficulty();
  GeneratedIntColumn _constructDifficulty() {
    return GeneratedIntColumn(
      'difficulty',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, lastWorkouts, maxVolume, maxWeigth, notes, difficulty];
  @override
  $ExercisesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'exercises';
  @override
  final String actualTableName = 'exercises';
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
    if (data.containsKey('max_weigth')) {
      context.handle(_maxWeigthMeta,
          maxWeigth.isAcceptableOrUnknown(data['max_weigth'], _maxWeigthMeta));
    } else if (isInserting) {
      context.missing(_maxWeigthMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes'], _notesMeta));
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    context.handle(_difficultyMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Exercise.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(_db, alias);
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
    final intType = db.typeSystem.forDartType<int>();
    return ExerciseBodyPart(
      exerciseId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}exercise_id']),
      bodyPart: $ExerciseBodyPartsTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}body_part'])),
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
  int get hashCode => $mrjf($mrjc(exerciseId.hashCode, bodyPart.hashCode));
  @override
  bool operator ==(dynamic other) =>
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
    Expression<int> bodyPart,
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
  final GeneratedDatabase _db;
  final String _alias;
  $ExerciseBodyPartsTable(this._db, [this._alias]);
  final VerificationMeta _exerciseIdMeta = const VerificationMeta('exerciseId');
  GeneratedIntColumn _exerciseId;
  @override
  GeneratedIntColumn get exerciseId => _exerciseId ??= _constructExerciseId();
  GeneratedIntColumn _constructExerciseId() {
    return GeneratedIntColumn('exercise_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES exercises (id)');
  }

  final VerificationMeta _bodyPartMeta = const VerificationMeta('bodyPart');
  GeneratedIntColumn _bodyPart;
  @override
  GeneratedIntColumn get bodyPart => _bodyPart ??= _constructBodyPart();
  GeneratedIntColumn _constructBodyPart() {
    return GeneratedIntColumn(
      'body_part',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [exerciseId, bodyPart];
  @override
  $ExerciseBodyPartsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'exercise_body_parts';
  @override
  final String actualTableName = 'exercise_body_parts';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ExerciseBodyPart.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ExerciseBodyPartsTable createAlias(String alias) {
    return $ExerciseBodyPartsTable(_db, alias);
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
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Migration(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      endPoint: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}end_point']),
      payload:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}payload']),
      verb: stringType.mapFromDatabaseResponse(data['${effectivePrefix}verb']),
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
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(endPoint.hashCode, $mrjc(payload.hashCode, verb.hashCode))));
  @override
  bool operator ==(dynamic other) =>
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
  final GeneratedDatabase _db;
  final String _alias;
  $MigrationsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _endPointMeta = const VerificationMeta('endPoint');
  GeneratedTextColumn _endPoint;
  @override
  GeneratedTextColumn get endPoint => _endPoint ??= _constructEndPoint();
  GeneratedTextColumn _constructEndPoint() {
    return GeneratedTextColumn(
      'end_point',
      $tableName,
      false,
    );
  }

  final VerificationMeta _payloadMeta = const VerificationMeta('payload');
  GeneratedTextColumn _payload;
  @override
  GeneratedTextColumn get payload => _payload ??= _constructPayload();
  GeneratedTextColumn _constructPayload() {
    return GeneratedTextColumn(
      'payload',
      $tableName,
      false,
    );
  }

  final VerificationMeta _verbMeta = const VerificationMeta('verb');
  GeneratedTextColumn _verb;
  @override
  GeneratedTextColumn get verb => _verb ??= _constructVerb();
  GeneratedTextColumn _constructVerb() {
    return GeneratedTextColumn(
      'verb',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, endPoint, payload, verb];
  @override
  $MigrationsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'migrations';
  @override
  final String actualTableName = 'migrations';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Migration.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MigrationsTable createAlias(String alias) {
    return $MigrationsTable(_db, alias);
  }
}

class SetWorkout extends DataClass implements Insertable<SetWorkout> {
  final int id;
  final double setVolume;
  final double setMaxWeigth;
  final int workOutId;
  final int exerciseId;
  SetWorkout(
      {@required this.id,
      @required this.setVolume,
      @required this.setMaxWeigth,
      @required this.workOutId,
      @required this.exerciseId});
  factory SetWorkout.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    return SetWorkout(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      setVolume: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}set_volume']),
      setMaxWeigth: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}set_max_weigth']),
      workOutId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}work_out_id']),
      exerciseId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}exercise_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || setVolume != null) {
      map['set_volume'] = Variable<double>(setVolume);
    }
    if (!nullToAbsent || setMaxWeigth != null) {
      map['set_max_weigth'] = Variable<double>(setMaxWeigth);
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
      setVolume: setVolume == null && nullToAbsent
          ? const Value.absent()
          : Value(setVolume),
      setMaxWeigth: setMaxWeigth == null && nullToAbsent
          ? const Value.absent()
          : Value(setMaxWeigth),
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
      setVolume: serializer.fromJson<double>(json['setVolume']),
      setMaxWeigth: serializer.fromJson<double>(json['setMaxWeigth']),
      workOutId: serializer.fromJson<int>(json['workOutId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'setVolume': serializer.toJson<double>(setVolume),
      'setMaxWeigth': serializer.toJson<double>(setMaxWeigth),
      'workOutId': serializer.toJson<int>(workOutId),
      'exerciseId': serializer.toJson<int>(exerciseId),
    };
  }

  SetWorkout copyWith(
          {int id,
          double setVolume,
          double setMaxWeigth,
          int workOutId,
          int exerciseId}) =>
      SetWorkout(
        id: id ?? this.id,
        setVolume: setVolume ?? this.setVolume,
        setMaxWeigth: setMaxWeigth ?? this.setMaxWeigth,
        workOutId: workOutId ?? this.workOutId,
        exerciseId: exerciseId ?? this.exerciseId,
      );
  @override
  String toString() {
    return (StringBuffer('SetWorkout(')
          ..write('id: $id, ')
          ..write('setVolume: $setVolume, ')
          ..write('setMaxWeigth: $setMaxWeigth, ')
          ..write('workOutId: $workOutId, ')
          ..write('exerciseId: $exerciseId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          setVolume.hashCode,
          $mrjc(setMaxWeigth.hashCode,
              $mrjc(workOutId.hashCode, exerciseId.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SetWorkout &&
          other.id == this.id &&
          other.setVolume == this.setVolume &&
          other.setMaxWeigth == this.setMaxWeigth &&
          other.workOutId == this.workOutId &&
          other.exerciseId == this.exerciseId);
}

class SetWorkoutsCompanion extends UpdateCompanion<SetWorkout> {
  final Value<int> id;
  final Value<double> setVolume;
  final Value<double> setMaxWeigth;
  final Value<int> workOutId;
  final Value<int> exerciseId;
  const SetWorkoutsCompanion({
    this.id = const Value.absent(),
    this.setVolume = const Value.absent(),
    this.setMaxWeigth = const Value.absent(),
    this.workOutId = const Value.absent(),
    this.exerciseId = const Value.absent(),
  });
  SetWorkoutsCompanion.insert({
    this.id = const Value.absent(),
    @required double setVolume,
    @required double setMaxWeigth,
    @required int workOutId,
    @required int exerciseId,
  })  : setVolume = Value(setVolume),
        setMaxWeigth = Value(setMaxWeigth),
        workOutId = Value(workOutId),
        exerciseId = Value(exerciseId);
  static Insertable<SetWorkout> custom({
    Expression<int> id,
    Expression<double> setVolume,
    Expression<double> setMaxWeigth,
    Expression<int> workOutId,
    Expression<int> exerciseId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (setVolume != null) 'set_volume': setVolume,
      if (setMaxWeigth != null) 'set_max_weigth': setMaxWeigth,
      if (workOutId != null) 'work_out_id': workOutId,
      if (exerciseId != null) 'exercise_id': exerciseId,
    });
  }

  SetWorkoutsCompanion copyWith(
      {Value<int> id,
      Value<double> setVolume,
      Value<double> setMaxWeigth,
      Value<int> workOutId,
      Value<int> exerciseId}) {
    return SetWorkoutsCompanion(
      id: id ?? this.id,
      setVolume: setVolume ?? this.setVolume,
      setMaxWeigth: setMaxWeigth ?? this.setMaxWeigth,
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
    if (setVolume.present) {
      map['set_volume'] = Variable<double>(setVolume.value);
    }
    if (setMaxWeigth.present) {
      map['set_max_weigth'] = Variable<double>(setMaxWeigth.value);
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
          ..write('setVolume: $setVolume, ')
          ..write('setMaxWeigth: $setMaxWeigth, ')
          ..write('workOutId: $workOutId, ')
          ..write('exerciseId: $exerciseId')
          ..write(')'))
        .toString();
  }
}

class $SetWorkoutsTable extends SetWorkouts
    with TableInfo<$SetWorkoutsTable, SetWorkout> {
  final GeneratedDatabase _db;
  final String _alias;
  $SetWorkoutsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _setVolumeMeta = const VerificationMeta('setVolume');
  GeneratedRealColumn _setVolume;
  @override
  GeneratedRealColumn get setVolume => _setVolume ??= _constructSetVolume();
  GeneratedRealColumn _constructSetVolume() {
    return GeneratedRealColumn(
      'set_volume',
      $tableName,
      false,
    );
  }

  final VerificationMeta _setMaxWeigthMeta =
      const VerificationMeta('setMaxWeigth');
  GeneratedRealColumn _setMaxWeigth;
  @override
  GeneratedRealColumn get setMaxWeigth =>
      _setMaxWeigth ??= _constructSetMaxWeigth();
  GeneratedRealColumn _constructSetMaxWeigth() {
    return GeneratedRealColumn(
      'set_max_weigth',
      $tableName,
      false,
    );
  }

  final VerificationMeta _workOutIdMeta = const VerificationMeta('workOutId');
  GeneratedIntColumn _workOutId;
  @override
  GeneratedIntColumn get workOutId => _workOutId ??= _constructWorkOutId();
  GeneratedIntColumn _constructWorkOutId() {
    return GeneratedIntColumn('work_out_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES workouts (id)');
  }

  final VerificationMeta _exerciseIdMeta = const VerificationMeta('exerciseId');
  GeneratedIntColumn _exerciseId;
  @override
  GeneratedIntColumn get exerciseId => _exerciseId ??= _constructExerciseId();
  GeneratedIntColumn _constructExerciseId() {
    return GeneratedIntColumn('exercise_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES exercises(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, setVolume, setMaxWeigth, workOutId, exerciseId];
  @override
  $SetWorkoutsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'set_workouts';
  @override
  final String actualTableName = 'set_workouts';
  @override
  VerificationContext validateIntegrity(Insertable<SetWorkout> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('set_volume')) {
      context.handle(_setVolumeMeta,
          setVolume.isAcceptableOrUnknown(data['set_volume'], _setVolumeMeta));
    } else if (isInserting) {
      context.missing(_setVolumeMeta);
    }
    if (data.containsKey('set_max_weigth')) {
      context.handle(
          _setMaxWeigthMeta,
          setMaxWeigth.isAcceptableOrUnknown(
              data['set_max_weigth'], _setMaxWeigthMeta));
    } else if (isInserting) {
      context.missing(_setMaxWeigthMeta);
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SetWorkout.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SetWorkoutsTable createAlias(String alias) {
    return $SetWorkoutsTable(_db, alias);
  }
}

class Workout extends DataClass implements Insertable<Workout> {
  final int id;
  final DateTime date;
  Workout({@required this.id, @required this.date});
  factory Workout.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Workout(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
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
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory Workout.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Workout(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Workout copyWith({int id, DateTime date}) => Workout(
        id: id ?? this.id,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Workout(')
          ..write('id: $id, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, date.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Workout && other.id == this.id && other.date == this.date);
}

class WorkoutsCompanion extends UpdateCompanion<Workout> {
  final Value<int> id;
  final Value<DateTime> date;
  const WorkoutsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime date,
  }) : date = Value(date);
  static Insertable<Workout> custom({
    Expression<int> id,
    Expression<DateTime> date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
    });
  }

  WorkoutsCompanion copyWith({Value<int> id, Value<DateTime> date}) {
    return WorkoutsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts with TableInfo<$WorkoutsTable, Workout> {
  final GeneratedDatabase _db;
  final String _alias;
  $WorkoutsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, date];
  @override
  $WorkoutsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'workouts';
  @override
  final String actualTableName = 'workouts';
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workout map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Workout.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(_db, alias);
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
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final stringType = db.typeSystem.forDartType<String>();
    return Rep(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      weight:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}weight']),
      reps: intType.mapFromDatabaseResponse(data['${effectivePrefix}reps']),
      rpe: intType.mapFromDatabaseResponse(data['${effectivePrefix}rpe']),
      note: stringType.mapFromDatabaseResponse(data['${effectivePrefix}note']),
      setId: intType.mapFromDatabaseResponse(data['${effectivePrefix}set_id']),
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
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          weight.hashCode,
          $mrjc(reps.hashCode,
              $mrjc(rpe.hashCode, $mrjc(note.hashCode, setId.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
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
    @required String note,
    @required int setId,
  })  : weight = Value(weight),
        reps = Value(reps),
        rpe = Value(rpe),
        note = Value(note),
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
  final GeneratedDatabase _db;
  final String _alias;
  $RepsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _weightMeta = const VerificationMeta('weight');
  GeneratedRealColumn _weight;
  @override
  GeneratedRealColumn get weight => _weight ??= _constructWeight();
  GeneratedRealColumn _constructWeight() {
    return GeneratedRealColumn(
      'weight',
      $tableName,
      false,
    );
  }

  final VerificationMeta _repsMeta = const VerificationMeta('reps');
  GeneratedIntColumn _reps;
  @override
  GeneratedIntColumn get reps => _reps ??= _constructReps();
  GeneratedIntColumn _constructReps() {
    return GeneratedIntColumn(
      'reps',
      $tableName,
      false,
    );
  }

  final VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  GeneratedIntColumn _rpe;
  @override
  GeneratedIntColumn get rpe => _rpe ??= _constructRpe();
  GeneratedIntColumn _constructRpe() {
    return GeneratedIntColumn(
      'rpe',
      $tableName,
      false,
    );
  }

  final VerificationMeta _noteMeta = const VerificationMeta('note');
  GeneratedTextColumn _note;
  @override
  GeneratedTextColumn get note => _note ??= _constructNote();
  GeneratedTextColumn _constructNote() {
    return GeneratedTextColumn(
      'note',
      $tableName,
      false,
    );
  }

  final VerificationMeta _setIdMeta = const VerificationMeta('setId');
  GeneratedIntColumn _setId;
  @override
  GeneratedIntColumn get setId => _setId ??= _constructSetId();
  GeneratedIntColumn _constructSetId() {
    return GeneratedIntColumn('set_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES sets (id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, weight, reps, rpe, note, setId];
  @override
  $RepsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'reps';
  @override
  final String actualTableName = 'reps';
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
    } else if (isInserting) {
      context.missing(_noteMeta);
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Rep.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $RepsTable createAlias(String alias) {
    return $RepsTable(_db, alias);
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
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [exercises, exerciseBodyParts, migrations, setWorkouts, workouts, reps];
}
