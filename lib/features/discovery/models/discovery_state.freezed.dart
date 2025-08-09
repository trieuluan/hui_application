// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discovery_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiscoveryState {

 List<HuiGroupPreview> get groups; bool get isLoading; String get searchQuery; String get selectedLocation; double get selectedAmount; int get selectedDuration; String? get error;
/// Create a copy of DiscoveryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoveryStateCopyWith<DiscoveryState> get copyWith => _$DiscoveryStateCopyWithImpl<DiscoveryState>(this as DiscoveryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoveryState&&const DeepCollectionEquality().equals(other.groups, groups)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedLocation, selectedLocation) || other.selectedLocation == selectedLocation)&&(identical(other.selectedAmount, selectedAmount) || other.selectedAmount == selectedAmount)&&(identical(other.selectedDuration, selectedDuration) || other.selectedDuration == selectedDuration)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(groups),isLoading,searchQuery,selectedLocation,selectedAmount,selectedDuration,error);

@override
String toString() {
  return 'DiscoveryState(groups: $groups, isLoading: $isLoading, searchQuery: $searchQuery, selectedLocation: $selectedLocation, selectedAmount: $selectedAmount, selectedDuration: $selectedDuration, error: $error)';
}


}

/// @nodoc
abstract mixin class $DiscoveryStateCopyWith<$Res>  {
  factory $DiscoveryStateCopyWith(DiscoveryState value, $Res Function(DiscoveryState) _then) = _$DiscoveryStateCopyWithImpl;
@useResult
$Res call({
 List<HuiGroupPreview> groups, bool isLoading, String searchQuery, String selectedLocation, double selectedAmount, int selectedDuration, String? error
});




}
/// @nodoc
class _$DiscoveryStateCopyWithImpl<$Res>
    implements $DiscoveryStateCopyWith<$Res> {
  _$DiscoveryStateCopyWithImpl(this._self, this._then);

  final DiscoveryState _self;
  final $Res Function(DiscoveryState) _then;

/// Create a copy of DiscoveryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groups = null,Object? isLoading = null,Object? searchQuery = null,Object? selectedLocation = null,Object? selectedAmount = null,Object? selectedDuration = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<HuiGroupPreview>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedLocation: null == selectedLocation ? _self.selectedLocation : selectedLocation // ignore: cast_nullable_to_non_nullable
as String,selectedAmount: null == selectedAmount ? _self.selectedAmount : selectedAmount // ignore: cast_nullable_to_non_nullable
as double,selectedDuration: null == selectedDuration ? _self.selectedDuration : selectedDuration // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _DiscoveryState implements DiscoveryState {
  const _DiscoveryState({final  List<HuiGroupPreview> groups = const [], this.isLoading = false, this.searchQuery = '', this.selectedLocation = '', this.selectedAmount = 0.0, this.selectedDuration = 0, this.error}): _groups = groups;
  

 final  List<HuiGroupPreview> _groups;
@override@JsonKey() List<HuiGroupPreview> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  String selectedLocation;
@override@JsonKey() final  double selectedAmount;
@override@JsonKey() final  int selectedDuration;
@override final  String? error;

/// Create a copy of DiscoveryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscoveryStateCopyWith<_DiscoveryState> get copyWith => __$DiscoveryStateCopyWithImpl<_DiscoveryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscoveryState&&const DeepCollectionEquality().equals(other._groups, _groups)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedLocation, selectedLocation) || other.selectedLocation == selectedLocation)&&(identical(other.selectedAmount, selectedAmount) || other.selectedAmount == selectedAmount)&&(identical(other.selectedDuration, selectedDuration) || other.selectedDuration == selectedDuration)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_groups),isLoading,searchQuery,selectedLocation,selectedAmount,selectedDuration,error);

@override
String toString() {
  return 'DiscoveryState(groups: $groups, isLoading: $isLoading, searchQuery: $searchQuery, selectedLocation: $selectedLocation, selectedAmount: $selectedAmount, selectedDuration: $selectedDuration, error: $error)';
}


}

/// @nodoc
abstract mixin class _$DiscoveryStateCopyWith<$Res> implements $DiscoveryStateCopyWith<$Res> {
  factory _$DiscoveryStateCopyWith(_DiscoveryState value, $Res Function(_DiscoveryState) _then) = __$DiscoveryStateCopyWithImpl;
@override @useResult
$Res call({
 List<HuiGroupPreview> groups, bool isLoading, String searchQuery, String selectedLocation, double selectedAmount, int selectedDuration, String? error
});




}
/// @nodoc
class __$DiscoveryStateCopyWithImpl<$Res>
    implements _$DiscoveryStateCopyWith<$Res> {
  __$DiscoveryStateCopyWithImpl(this._self, this._then);

  final _DiscoveryState _self;
  final $Res Function(_DiscoveryState) _then;

/// Create a copy of DiscoveryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groups = null,Object? isLoading = null,Object? searchQuery = null,Object? selectedLocation = null,Object? selectedAmount = null,Object? selectedDuration = null,Object? error = freezed,}) {
  return _then(_DiscoveryState(
groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<HuiGroupPreview>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedLocation: null == selectedLocation ? _self.selectedLocation : selectedLocation // ignore: cast_nullable_to_non_nullable
as String,selectedAmount: null == selectedAmount ? _self.selectedAmount : selectedAmount // ignore: cast_nullable_to_non_nullable
as double,selectedDuration: null == selectedDuration ? _self.selectedDuration : selectedDuration // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$HuiGroupPreview {

 String get id; String get name; String get ownerName; double get amount; int get duration; String get location; int get memberCount; int get maxMembers; GroupPrivacy get privacy; JoinStatus get joinStatus; DateTime get createdAt;
/// Create a copy of HuiGroupPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HuiGroupPreviewCopyWith<HuiGroupPreview> get copyWith => _$HuiGroupPreviewCopyWithImpl<HuiGroupPreview>(this as HuiGroupPreview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HuiGroupPreview&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.location, location) || other.location == location)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.privacy, privacy) || other.privacy == privacy)&&(identical(other.joinStatus, joinStatus) || other.joinStatus == joinStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,ownerName,amount,duration,location,memberCount,maxMembers,privacy,joinStatus,createdAt);

@override
String toString() {
  return 'HuiGroupPreview(id: $id, name: $name, ownerName: $ownerName, amount: $amount, duration: $duration, location: $location, memberCount: $memberCount, maxMembers: $maxMembers, privacy: $privacy, joinStatus: $joinStatus, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $HuiGroupPreviewCopyWith<$Res>  {
  factory $HuiGroupPreviewCopyWith(HuiGroupPreview value, $Res Function(HuiGroupPreview) _then) = _$HuiGroupPreviewCopyWithImpl;
@useResult
$Res call({
 String id, String name, String ownerName, double amount, int duration, String location, int memberCount, int maxMembers, GroupPrivacy privacy, JoinStatus joinStatus, DateTime createdAt
});




}
/// @nodoc
class _$HuiGroupPreviewCopyWithImpl<$Res>
    implements $HuiGroupPreviewCopyWith<$Res> {
  _$HuiGroupPreviewCopyWithImpl(this._self, this._then);

  final HuiGroupPreview _self;
  final $Res Function(HuiGroupPreview) _then;

/// Create a copy of HuiGroupPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? ownerName = null,Object? amount = null,Object? duration = null,Object? location = null,Object? memberCount = null,Object? maxMembers = null,Object? privacy = null,Object? joinStatus = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ownerName: null == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,privacy: null == privacy ? _self.privacy : privacy // ignore: cast_nullable_to_non_nullable
as GroupPrivacy,joinStatus: null == joinStatus ? _self.joinStatus : joinStatus // ignore: cast_nullable_to_non_nullable
as JoinStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc


class _HuiGroupPreview implements HuiGroupPreview {
  const _HuiGroupPreview({required this.id, required this.name, required this.ownerName, required this.amount, required this.duration, required this.location, required this.memberCount, required this.maxMembers, required this.privacy, required this.joinStatus, required this.createdAt});
  

@override final  String id;
@override final  String name;
@override final  String ownerName;
@override final  double amount;
@override final  int duration;
@override final  String location;
@override final  int memberCount;
@override final  int maxMembers;
@override final  GroupPrivacy privacy;
@override final  JoinStatus joinStatus;
@override final  DateTime createdAt;

/// Create a copy of HuiGroupPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HuiGroupPreviewCopyWith<_HuiGroupPreview> get copyWith => __$HuiGroupPreviewCopyWithImpl<_HuiGroupPreview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HuiGroupPreview&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.location, location) || other.location == location)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.privacy, privacy) || other.privacy == privacy)&&(identical(other.joinStatus, joinStatus) || other.joinStatus == joinStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,ownerName,amount,duration,location,memberCount,maxMembers,privacy,joinStatus,createdAt);

@override
String toString() {
  return 'HuiGroupPreview(id: $id, name: $name, ownerName: $ownerName, amount: $amount, duration: $duration, location: $location, memberCount: $memberCount, maxMembers: $maxMembers, privacy: $privacy, joinStatus: $joinStatus, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$HuiGroupPreviewCopyWith<$Res> implements $HuiGroupPreviewCopyWith<$Res> {
  factory _$HuiGroupPreviewCopyWith(_HuiGroupPreview value, $Res Function(_HuiGroupPreview) _then) = __$HuiGroupPreviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String ownerName, double amount, int duration, String location, int memberCount, int maxMembers, GroupPrivacy privacy, JoinStatus joinStatus, DateTime createdAt
});




}
/// @nodoc
class __$HuiGroupPreviewCopyWithImpl<$Res>
    implements _$HuiGroupPreviewCopyWith<$Res> {
  __$HuiGroupPreviewCopyWithImpl(this._self, this._then);

  final _HuiGroupPreview _self;
  final $Res Function(_HuiGroupPreview) _then;

/// Create a copy of HuiGroupPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? ownerName = null,Object? amount = null,Object? duration = null,Object? location = null,Object? memberCount = null,Object? maxMembers = null,Object? privacy = null,Object? joinStatus = null,Object? createdAt = null,}) {
  return _then(_HuiGroupPreview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ownerName: null == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,privacy: null == privacy ? _self.privacy : privacy // ignore: cast_nullable_to_non_nullable
as GroupPrivacy,joinStatus: null == joinStatus ? _self.joinStatus : joinStatus // ignore: cast_nullable_to_non_nullable
as JoinStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
