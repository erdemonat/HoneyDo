// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_model.dart';

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
    r'currentProviderSoundValue': PropertySchema(
      id: 0,
      name: r'currentProviderSoundValue',
      type: IsarType.double,
    ),
    r'currentSliderValue': PropertySchema(
      id: 1,
      name: r'currentSliderValue',
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
  writer.writeDouble(offsets[0], object.currentProviderSoundValue);
  writer.writeDouble(offsets[1], object.currentSliderValue);
}

VolumeData _volumeDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VolumeData();
  object.currentProviderSoundValue = reader.readDouble(offsets[0]);
  object.currentSliderValue = reader.readDouble(offsets[1]);
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
    case 1:
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
      currentProviderSoundValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentProviderSoundValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition>
      currentProviderSoundValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentProviderSoundValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition>
      currentProviderSoundValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentProviderSoundValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition>
      currentProviderSoundValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentProviderSoundValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition>
      currentSliderValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentSliderValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition>
      currentSliderValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentSliderValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition>
      currentSliderValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentSliderValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterFilterCondition>
      currentSliderValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentSliderValue',
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
  QueryBuilder<VolumeData, VolumeData, QAfterSortBy>
      sortByCurrentProviderSoundValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProviderSoundValue', Sort.asc);
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterSortBy>
      sortByCurrentProviderSoundValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProviderSoundValue', Sort.desc);
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterSortBy>
      sortByCurrentSliderValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSliderValue', Sort.asc);
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterSortBy>
      sortByCurrentSliderValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSliderValue', Sort.desc);
    });
  }
}

extension VolumeDataQuerySortThenBy
    on QueryBuilder<VolumeData, VolumeData, QSortThenBy> {
  QueryBuilder<VolumeData, VolumeData, QAfterSortBy>
      thenByCurrentProviderSoundValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProviderSoundValue', Sort.asc);
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterSortBy>
      thenByCurrentProviderSoundValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProviderSoundValue', Sort.desc);
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterSortBy>
      thenByCurrentSliderValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSliderValue', Sort.asc);
    });
  }

  QueryBuilder<VolumeData, VolumeData, QAfterSortBy>
      thenByCurrentSliderValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSliderValue', Sort.desc);
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
  QueryBuilder<VolumeData, VolumeData, QDistinct>
      distinctByCurrentProviderSoundValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentProviderSoundValue');
    });
  }

  QueryBuilder<VolumeData, VolumeData, QDistinct>
      distinctByCurrentSliderValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentSliderValue');
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

  QueryBuilder<VolumeData, double, QQueryOperations>
      currentProviderSoundValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentProviderSoundValue');
    });
  }

  QueryBuilder<VolumeData, double, QQueryOperations>
      currentSliderValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentSliderValue');
    });
  }
}
