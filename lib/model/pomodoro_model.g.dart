// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPomodoroSettingsCollection on Isar {
  IsarCollection<PomodoroSettings> get pomodoroSettings => this.collection();
}

const PomodoroSettingsSchema = CollectionSchema(
  name: r'PomodoroSettings',
  id: 6140716566819135039,
  properties: {
    r'autoBreak': PropertySchema(
      id: 0,
      name: r'autoBreak',
      type: IsarType.bool,
    ),
    r'autoPomodoro': PropertySchema(
      id: 1,
      name: r'autoPomodoro',
      type: IsarType.bool,
    ),
    r'longBreakDurationInSeconds': PropertySchema(
      id: 2,
      name: r'longBreakDurationInSeconds',
      type: IsarType.long,
    ),
    r'pomodoroDurationInSeconds': PropertySchema(
      id: 3,
      name: r'pomodoroDurationInSeconds',
      type: IsarType.long,
    ),
    r'setCount': PropertySchema(
      id: 4,
      name: r'setCount',
      type: IsarType.long,
    ),
    r'shortBreakDurationInSeconds': PropertySchema(
      id: 5,
      name: r'shortBreakDurationInSeconds',
      type: IsarType.long,
    )
  },
  estimateSize: _pomodoroSettingsEstimateSize,
  serialize: _pomodoroSettingsSerialize,
  deserialize: _pomodoroSettingsDeserialize,
  deserializeProp: _pomodoroSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _pomodoroSettingsGetId,
  getLinks: _pomodoroSettingsGetLinks,
  attach: _pomodoroSettingsAttach,
  version: '3.1.0+1',
);

int _pomodoroSettingsEstimateSize(
  PomodoroSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _pomodoroSettingsSerialize(
  PomodoroSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.autoBreak);
  writer.writeBool(offsets[1], object.autoPomodoro);
  writer.writeLong(offsets[2], object.longBreakDurationInSeconds);
  writer.writeLong(offsets[3], object.pomodoroDurationInSeconds);
  writer.writeLong(offsets[4], object.setCount);
  writer.writeLong(offsets[5], object.shortBreakDurationInSeconds);
}

PomodoroSettings _pomodoroSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PomodoroSettings();
  object.autoBreak = reader.readBool(offsets[0]);
  object.autoPomodoro = reader.readBool(offsets[1]);
  object.id = id;
  object.longBreakDurationInSeconds = reader.readLong(offsets[2]);
  object.pomodoroDurationInSeconds = reader.readLong(offsets[3]);
  object.setCount = reader.readLong(offsets[4]);
  object.shortBreakDurationInSeconds = reader.readLong(offsets[5]);
  return object;
}

P _pomodoroSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pomodoroSettingsGetId(PomodoroSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pomodoroSettingsGetLinks(PomodoroSettings object) {
  return [];
}

void _pomodoroSettingsAttach(
    IsarCollection<dynamic> col, Id id, PomodoroSettings object) {
  object.id = id;
}

extension PomodoroSettingsQueryWhereSort
    on QueryBuilder<PomodoroSettings, PomodoroSettings, QWhere> {
  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PomodoroSettingsQueryWhere
    on QueryBuilder<PomodoroSettings, PomodoroSettings, QWhereClause> {
  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PomodoroSettingsQueryFilter
    on QueryBuilder<PomodoroSettings, PomodoroSettings, QFilterCondition> {
  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      autoBreakEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoBreak',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      autoPomodoroEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoPomodoro',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      longBreakDurationInSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longBreakDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      longBreakDurationInSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longBreakDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      longBreakDurationInSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longBreakDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      longBreakDurationInSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longBreakDurationInSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      pomodoroDurationInSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pomodoroDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      pomodoroDurationInSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pomodoroDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      pomodoroDurationInSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pomodoroDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      pomodoroDurationInSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pomodoroDurationInSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      setCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'setCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      setCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'setCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      setCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'setCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      setCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'setCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      shortBreakDurationInSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortBreakDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      shortBreakDurationInSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shortBreakDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      shortBreakDurationInSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shortBreakDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterFilterCondition>
      shortBreakDurationInSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shortBreakDurationInSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PomodoroSettingsQueryObject
    on QueryBuilder<PomodoroSettings, PomodoroSettings, QFilterCondition> {}

extension PomodoroSettingsQueryLinks
    on QueryBuilder<PomodoroSettings, PomodoroSettings, QFilterCondition> {}

extension PomodoroSettingsQuerySortBy
    on QueryBuilder<PomodoroSettings, PomodoroSettings, QSortBy> {
  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      sortByAutoBreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoBreak', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      sortByAutoBreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoBreak', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      sortByAutoPomodoro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoPomodoro', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      sortByAutoPomodoroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoPomodoro', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      sortByLongBreakDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longBreakDurationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      sortByLongBreakDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longBreakDurationInSeconds', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      sortByPomodoroDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroDurationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      sortByPomodoroDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroDurationInSeconds', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      sortBySetCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'setCount', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      sortBySetCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'setCount', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      sortByShortBreakDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortBreakDurationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      sortByShortBreakDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortBreakDurationInSeconds', Sort.desc);
    });
  }
}

extension PomodoroSettingsQuerySortThenBy
    on QueryBuilder<PomodoroSettings, PomodoroSettings, QSortThenBy> {
  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenByAutoBreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoBreak', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenByAutoBreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoBreak', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenByAutoPomodoro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoPomodoro', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenByAutoPomodoroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoPomodoro', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenByLongBreakDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longBreakDurationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenByLongBreakDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longBreakDurationInSeconds', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenByPomodoroDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroDurationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenByPomodoroDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroDurationInSeconds', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenBySetCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'setCount', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenBySetCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'setCount', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenByShortBreakDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortBreakDurationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QAfterSortBy>
      thenByShortBreakDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortBreakDurationInSeconds', Sort.desc);
    });
  }
}

extension PomodoroSettingsQueryWhereDistinct
    on QueryBuilder<PomodoroSettings, PomodoroSettings, QDistinct> {
  QueryBuilder<PomodoroSettings, PomodoroSettings, QDistinct>
      distinctByAutoBreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoBreak');
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QDistinct>
      distinctByAutoPomodoro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoPomodoro');
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QDistinct>
      distinctByLongBreakDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longBreakDurationInSeconds');
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QDistinct>
      distinctByPomodoroDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pomodoroDurationInSeconds');
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QDistinct>
      distinctBySetCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'setCount');
    });
  }

  QueryBuilder<PomodoroSettings, PomodoroSettings, QDistinct>
      distinctByShortBreakDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shortBreakDurationInSeconds');
    });
  }
}

extension PomodoroSettingsQueryProperty
    on QueryBuilder<PomodoroSettings, PomodoroSettings, QQueryProperty> {
  QueryBuilder<PomodoroSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PomodoroSettings, bool, QQueryOperations> autoBreakProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoBreak');
    });
  }

  QueryBuilder<PomodoroSettings, bool, QQueryOperations>
      autoPomodoroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoPomodoro');
    });
  }

  QueryBuilder<PomodoroSettings, int, QQueryOperations>
      longBreakDurationInSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longBreakDurationInSeconds');
    });
  }

  QueryBuilder<PomodoroSettings, int, QQueryOperations>
      pomodoroDurationInSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pomodoroDurationInSeconds');
    });
  }

  QueryBuilder<PomodoroSettings, int, QQueryOperations> setCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'setCount');
    });
  }

  QueryBuilder<PomodoroSettings, int, QQueryOperations>
      shortBreakDurationInSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shortBreakDurationInSeconds');
    });
  }
}
