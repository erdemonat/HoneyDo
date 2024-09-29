// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVolumeDataCollection on Isar {
  IsarCollection<VolumeData> get volumeDatas => this.collection();
}

const VolumeDataSchema = CollectionSchema(
  name: r'VolumeData',
  id: -2269912427559612457,
  properties: {
    r'currentVolume': PropertySchema(
      id: 0,
      name: r'currentVolume',
      type: IsarType.double,
    )
  },
  estimateSize: _volumeDataEstimateSize,
  serialize: _volumeDataSerialize,
  deserialize: _volumeDataDeserialize,
  deserializeProp: _volumeDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _volumeDataGetId,
  getLinks: _volumeDataGetLinks,
  attach: _volumeDataAttach,
  version: '3.1.0+1',
);

int _volumeDataEstimateSize(
  VolumeData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _volumeDataSerialize(
  VolumeData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.currentVolume);
}

VolumeData _volumeDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VolumeData();
  object.currentVolume = reader.readDouble(offsets[0]);
  object.id = id;
  return object;
}

P _volumeDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _volumeDataGetId(VolumeData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _volumeDataGetLinks(VolumeData object) {
  return [];
}

void _volumeDataAttach(IsarCollection<dynamic> col, Id id, VolumeData object) {
  object.id = id;
}

extension VolumeDataQueryWhereSort
    on QueryBuilder<VolumeData, VolumeData, QWhere> {
  QueryBuilder<VolumeData, VolumeData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VolumeDataQueryWhere
    on QueryBuilder<VolumeData, VolumeData, QWhereClause> {
  QueryBuilder<VolumeData, VolumeData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<VolumeData, VolumeData, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterWhereClause> idBetween(
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

extension VolumeDataQueryFilter
    on QueryBuilder<VolumeData, VolumeData, QFilterCondition> {
  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition>
      currentVolumeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentVolume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition>
      currentVolumeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentVolume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition>
      currentVolumeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentVolume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition>
      currentVolumeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentVolume',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition> idBetween(
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
}

extension VolumeDataQueryObject
    on QueryBuilder<VolumeData, VolumeData, QFilterCondition> {}

extension VolumeDataQueryLinks
    on QueryBuilder<VolumeData, VolumeData, QFilterCondition> {}

extension VolumeDataQuerySortBy
    on QueryBuilder<VolumeData, VolumeData, QSortBy> {
  QueryBuilder<VolumeData, VolumeData, QAfterSortBy> sortByCurrentVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentVolume', Sort.asc);
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterSortBy> sortByCurrentVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentVolume', Sort.desc);
    });
  }
}

extension VolumeDataQuerySortThenBy
    on QueryBuilder<VolumeData, VolumeData, QSortThenBy> {
  QueryBuilder<VolumeData, VolumeData, QAfterSortBy> thenByCurrentVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentVolume', Sort.asc);
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterSortBy> thenByCurrentVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentVolume', Sort.desc);
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension VolumeDataQueryWhereDistinct
    on QueryBuilder<VolumeData, VolumeData, QDistinct> {
  QueryBuilder<VolumeData, VolumeData, QDistinct> distinctByCurrentVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentVolume');
    });
  }
}

extension VolumeDataQueryProperty
    on QueryBuilder<VolumeData, VolumeData, QQueryProperty> {
  QueryBuilder<VolumeData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VolumeData, double, QQueryOperations> currentVolumeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentVolume');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetThemeDataCollection on Isar {
  IsarCollection<ThemeData> get themeDatas => this.collection();
}

const ThemeDataSchema = CollectionSchema(
  name: r'ThemeData',
  id: 6523765599623502154,
  properties: {
    r'currentThemeIndex': PropertySchema(
      id: 0,
      name: r'currentThemeIndex',
      type: IsarType.long,
    ),
    r'isDarkMode': PropertySchema(
      id: 1,
      name: r'isDarkMode',
      type: IsarType.bool,
    )
  },
  estimateSize: _themeDataEstimateSize,
  serialize: _themeDataSerialize,
  deserialize: _themeDataDeserialize,
  deserializeProp: _themeDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _themeDataGetId,
  getLinks: _themeDataGetLinks,
  attach: _themeDataAttach,
  version: '3.1.0+1',
);

int _themeDataEstimateSize(
  ThemeData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _themeDataSerialize(
  ThemeData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.currentThemeIndex);
  writer.writeBool(offsets[1], object.isDarkMode);
}

ThemeData _themeDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ThemeData();
  object.currentThemeIndex = reader.readLong(offsets[0]);
  object.id = id;
  object.isDarkMode = reader.readBool(offsets[1]);
  return object;
}

P _themeDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _themeDataGetId(ThemeData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _themeDataGetLinks(ThemeData object) {
  return [];
}

void _themeDataAttach(IsarCollection<dynamic> col, Id id, ThemeData object) {
  object.id = id;
}

extension ThemeDataQueryWhereSort
    on QueryBuilder<ThemeData, ThemeData, QWhere> {
  QueryBuilder<ThemeData, ThemeData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ThemeDataQueryWhere
    on QueryBuilder<ThemeData, ThemeData, QWhereClause> {
  QueryBuilder<ThemeData, ThemeData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<ThemeData, ThemeData, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterWhereClause> idBetween(
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

extension ThemeDataQueryFilter
    on QueryBuilder<ThemeData, ThemeData, QFilterCondition> {
  QueryBuilder<ThemeData, ThemeData, QAfterFilterCondition>
      currentThemeIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentThemeIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterFilterCondition>
      currentThemeIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentThemeIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterFilterCondition>
      currentThemeIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentThemeIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterFilterCondition>
      currentThemeIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentThemeIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ThemeData, ThemeData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ThemeData, ThemeData, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ThemeData, ThemeData, QAfterFilterCondition> isDarkModeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDarkMode',
        value: value,
      ));
    });
  }
}

extension ThemeDataQueryObject
    on QueryBuilder<ThemeData, ThemeData, QFilterCondition> {}

extension ThemeDataQueryLinks
    on QueryBuilder<ThemeData, ThemeData, QFilterCondition> {}

extension ThemeDataQuerySortBy on QueryBuilder<ThemeData, ThemeData, QSortBy> {
  QueryBuilder<ThemeData, ThemeData, QAfterSortBy> sortByCurrentThemeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentThemeIndex', Sort.asc);
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterSortBy>
      sortByCurrentThemeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentThemeIndex', Sort.desc);
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterSortBy> sortByIsDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.asc);
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterSortBy> sortByIsDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.desc);
    });
  }
}

extension ThemeDataQuerySortThenBy
    on QueryBuilder<ThemeData, ThemeData, QSortThenBy> {
  QueryBuilder<ThemeData, ThemeData, QAfterSortBy> thenByCurrentThemeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentThemeIndex', Sort.asc);
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterSortBy>
      thenByCurrentThemeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentThemeIndex', Sort.desc);
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterSortBy> thenByIsDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.asc);
    });
  }

  QueryBuilder<ThemeData, ThemeData, QAfterSortBy> thenByIsDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDarkMode', Sort.desc);
    });
  }
}

extension ThemeDataQueryWhereDistinct
    on QueryBuilder<ThemeData, ThemeData, QDistinct> {
  QueryBuilder<ThemeData, ThemeData, QDistinct> distinctByCurrentThemeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentThemeIndex');
    });
  }

  QueryBuilder<ThemeData, ThemeData, QDistinct> distinctByIsDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDarkMode');
    });
  }
}

extension ThemeDataQueryProperty
    on QueryBuilder<ThemeData, ThemeData, QQueryProperty> {
  QueryBuilder<ThemeData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ThemeData, int, QQueryOperations> currentThemeIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentThemeIndex');
    });
  }

  QueryBuilder<ThemeData, bool, QQueryOperations> isDarkModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDarkMode');
    });
  }
}
