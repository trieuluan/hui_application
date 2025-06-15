// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Group _$GroupFromJson(Map<String, dynamic> json) => _Group(
  id: json['_id'] as String?,
  name: json['name'] as String,
  code: json['code'] as String?,
  description: json['description'] as String?,
  ownerId: json['ownerId'] as String?,
  amountPerCycle: _doubleFromJson(json['amountPerCycle']),
  cycleDuration: (json['cycleDuration'] as num).toInt(),
  cycleUnit: $enumDecode(_$CycleUnitEnumMap, json['cycleUnit']),
  totalCycles: (json['totalCycles'] as num).toInt(),
  maxMembers: (json['maxMembers'] as num?)?.toInt(),
  autoStart: json['autoStart'] as bool? ?? false,
  isPrivate: json['isPrivate'] as bool? ?? false,
  password: json['password'] as String?,
  startDate:
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
  endDate:
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
  status:
      $enumDecodeNullable(_$GroupStatusEnumMap, json['status']) ??
      GroupStatus.inactive,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$GroupToJson(_Group instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'description': instance.description,
  'ownerId': instance.ownerId,
  'amountPerCycle': _doubleToJson(instance.amountPerCycle),
  'cycleDuration': instance.cycleDuration,
  'cycleUnit': _$CycleUnitEnumMap[instance.cycleUnit]!,
  'totalCycles': instance.totalCycles,
  'maxMembers': instance.maxMembers,
  'autoStart': instance.autoStart,
  'isPrivate': instance.isPrivate,
  'password': instance.password,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'status': _$GroupStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$CycleUnitEnumMap = {
  CycleUnit.day: 'day',
  CycleUnit.week: 'week',
  CycleUnit.month: 'month',
};

const _$GroupStatusEnumMap = {
  GroupStatus.inactive: 'inactive',
  GroupStatus.active: 'active',
  GroupStatus.completed: 'completed',
};
