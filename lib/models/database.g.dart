// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Exercise extends DataClass implements Insertable<Exercise> {
  final int id;
  final String name;
  final String notes;
  final Difficulty difficulty;
  Exercise(
      {@required this.id,
      @required this.name,
      @required this.notes,
      @required this.difficulty});

  factory Exercise.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Exercise(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
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
      'notes': serializer.toJson<String>(notes),
      'difficulty': serializer.toJson<Difficulty>(difficulty),
    };
  }

  Exercise copyWith(
          {int id, String name, String notes, Difficulty difficulty}) =>
      Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        notes: notes ?? this.notes,
        difficulty: difficulty ?? this.difficulty,
      );
  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('difficulty: $difficulty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(notes.hashCode, difficulty.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.name == this.name &&
          other.notes == this.notes &&
          other.difficulty == this.difficulty);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> notes;
  final Value<Difficulty> difficulty;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.notes = const Value.absent(),
    this.difficulty = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String notes,
    @required Difficulty difficulty,
  })  : name = Value(name),
        notes = Value(notes),
        difficulty = Value(difficulty);
  static Insertable<Exercise> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> notes,
    Expression<int> difficulty,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (notes != null) 'notes': notes,
      if (difficulty != null) 'difficulty': difficulty,
    });
  }

  ExercisesCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> notes,
      Value<Difficulty> difficulty}) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
  List<GeneratedColumn> get $columns => [id, name, notes, difficulty];
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
    return GeneratedIntColumn(
      'exercise_id',
      $tableName,
      false,
    );
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

abstract class _$SQLDatabase extends GeneratedDatabase {
  _$SQLDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ExercisesTable _exercises;
  $ExercisesTable get exercises => _exercises ??= $ExercisesTable(this);
  $ExerciseBodyPartsTable _exerciseBodyParts;
  $ExerciseBodyPartsTable get exerciseBodyParts =>
      _exerciseBodyParts ??= $ExerciseBodyPartsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [exercises, exerciseBodyParts];
}
