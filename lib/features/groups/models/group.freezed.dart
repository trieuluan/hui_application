// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Group {

@JsonKey(name: '_id') String? get id; String get name; String? get code; String? get description; String? get ownerId;@JsonKey(fromJson: _doubleFromJson, toJson: _doubleToJson) double get amountPerCycle; int get cycleDuration; CycleUnit get cycleUnit; int get totalCycles; int? get maxMembers; bool get autoStart; bool get isPrivate; String? get password; DateTime? get startDate; DateTime? get endDate; GroupStatus get status; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupCopyWith<Group> get copyWith => _$GroupCopyWithImpl<Group>(this as Group, _$identity);

  /// Serializes this Group to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Group&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.amountPerCycle, amountPerCycle) || other.amountPerCycle == amountPerCycle)&&(identical(other.cycleDuration, cycleDuration) || other.cycleDuration == cycleDuration)&&(identical(other.cycleUnit, cycleUnit) || other.cycleUnit == cycleUnit)&&(identical(other.totalCycles, totalCycles) || other.totalCycles == totalCycles)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.autoStart, autoStart) || other.autoStart == autoStart)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate)&&(identical(other.password, password) || other.password == password)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,description,ownerId,amountPerCycle,cycleDuration,cycleUnit,totalCycles,maxMembers,autoStart,isPrivate,password,startDate,endDate,status,createdAt,updatedAt);

@override
String toString() {
  return 'Group(id: $id, name: $name, code: $code, description: $description, ownerId: $ownerId, amountPerCycle: $amountPerCycle, cycleDuration: $cycleDuration, cycleUnit: $cycleUnit, totalCycles: $totalCycles, maxMembers: $maxMembers, autoStart: $autoStart, isPrivate: $isPrivate, password: $password, startDate: $startDate, endDate: $endDate, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GroupCopyWith<$Res>  {
  factory $GroupCopyWith(Group value, $Res Function(Group) _then) = _$GroupCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? id, String name, String? code, String? description, String? ownerId,@JsonKey(fromJson: _doubleFromJson, toJson: _doubleToJson) double amountPerCycle, int cycleDuration, CycleUnit cycleUnit, int totalCycles, int? maxMembers, bool autoStart, bool isPrivate, String? password, DateTime? startDate, DateTime? endDate, GroupStatus status, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$GroupCopyWithImpl<$Res>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._self, this._then);

  final Group _self;
  final $Res Function(Group) _then;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? code = freezed,Object? description = freezed,Object? ownerId = freezed,Object? amountPerCycle = null,Object? cycleDuration = null,Object? cycleUnit = null,Object? totalCycles = null,Object? maxMembers = freezed,Object? autoStart = null,Object? isPrivate = null,Object? password = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,amountPerCycle: null == amountPerCycle ? _self.amountPerCycle : amountPerCycle // ignore: cast_nullable_to_non_nullable
as double,cycleDuration: null == cycleDuration ? _self.cycleDuration : cycleDuration // ignore: cast_nullable_to_non_nullable
as int,cycleUnit: null == cycleUnit ? _self.cycleUnit : cycleUnit // ignore: cast_nullable_to_non_nullable
as CycleUnit,totalCycles: null == totalCycles ? _self.totalCycles : totalCycles // ignore: cast_nullable_to_non_nullable
as int,maxMembers: freezed == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int?,autoStart: null == autoStart ? _self.autoStart : autoStart // ignore: cast_nullable_to_non_nullable
as bool,isPrivate: null == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Group extends Group {
  const _Group({@JsonKey(name: '_id') this.id, required this.name, this.code, this.description, this.ownerId, @JsonKey(fromJson: _doubleFromJson, toJson: _doubleToJson) required this.amountPerCycle, required this.cycleDuration, required this.cycleUnit, required this.totalCycles, this.maxMembers, this.autoStart = false, this.isPrivate = false, this.password, this.startDate, this.endDate, this.status = GroupStatus.inactive, this.createdAt = null, this.updatedAt = null}): super._();
  factory _Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

@override@JsonKey(name: '_id') final  String? id;
@override final  String name;
@override final  String? code;
@override final  String? description;
@override final  String? ownerId;
@override@JsonKey(fromJson: _doubleFromJson, toJson: _doubleToJson) final  double amountPerCycle;
@override final  int cycleDuration;
@override final  CycleUnit cycleUnit;
@override final  int totalCycles;
@override final  int? maxMembers;
@override@JsonKey() final  bool autoStart;
@override@JsonKey() final  bool isPrivate;
@override final  String? password;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  GroupStatus status;
@override@JsonKey() final  DateTime? createdAt;
@override@JsonKey() final  DateTime? updatedAt;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupCopyWith<_Group> get copyWith => __$GroupCopyWithImpl<_Group>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Group&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.amountPerCycle, amountPerCycle) || other.amountPerCycle == amountPerCycle)&&(identical(other.cycleDuration, cycleDuration) || other.cycleDuration == cycleDuration)&&(identical(other.cycleUnit, cycleUnit) || other.cycleUnit == cycleUnit)&&(identical(other.totalCycles, totalCycles) || other.totalCycles == totalCycles)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.autoStart, autoStart) || other.autoStart == autoStart)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate)&&(identical(other.password, password) || other.password == password)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,description,ownerId,amountPerCycle,cycleDuration,cycleUnit,totalCycles,maxMembers,autoStart,isPrivate,password,startDate,endDate,status,createdAt,updatedAt);

@override
String toString() {
  return 'Group(id: $id, name: $name, code: $code, description: $description, ownerId: $ownerId, amountPerCycle: $amountPerCycle, cycleDuration: $cycleDuration, cycleUnit: $cycleUnit, totalCycles: $totalCycles, maxMembers: $maxMembers, autoStart: $autoStart, isPrivate: $isPrivate, password: $password, startDate: $startDate, endDate: $endDate, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$GroupCopyWith(_Group value, $Res Function(_Group) _then) = __$GroupCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? id, String name, String? code, String? description, String? ownerId,@JsonKey(fromJson: _doubleFromJson, toJson: _doubleToJson) double amountPerCycle, int cycleDuration, CycleUnit cycleUnit, int totalCycles, int? maxMembers, bool autoStart, bool isPrivate, String? password, DateTime? startDate, DateTime? endDate, GroupStatus status, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$GroupCopyWithImpl<$Res>
    implements _$GroupCopyWith<$Res> {
  __$GroupCopyWithImpl(this._self, this._then);

  final _Group _self;
  final $Res Function(_Group) _then;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? code = freezed,Object? description = freezed,Object? ownerId = freezed,Object? amountPerCycle = null,Object? cycleDuration = null,Object? cycleUnit = null,Object? totalCycles = null,Object? maxMembers = freezed,Object? autoStart = null,Object? isPrivate = null,Object? password = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Group(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,amountPerCycle: null == amountPerCycle ? _self.amountPerCycle : amountPerCycle // ignore: cast_nullable_to_non_nullable
as double,cycleDuration: null == cycleDuration ? _self.cycleDuration : cycleDuration // ignore: cast_nullable_to_non_nullable
as int,cycleUnit: null == cycleUnit ? _self.cycleUnit : cycleUnit // ignore: cast_nullable_to_non_nullable
as CycleUnit,totalCycles: null == totalCycles ? _self.totalCycles : totalCycles // ignore: cast_nullable_to_non_nullable
as int,maxMembers: freezed == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int?,autoStart: null == autoStart ? _self.autoStart : autoStart // ignore: cast_nullable_to_non_nullable
as bool,isPrivate: null == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
