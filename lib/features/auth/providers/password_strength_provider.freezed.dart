// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_strength_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PasswordStrengthState {

 PasswordStrengthResponse? get response; bool get isLoading; String? get error;
/// Create a copy of PasswordStrengthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PasswordStrengthStateCopyWith<PasswordStrengthState> get copyWith => _$PasswordStrengthStateCopyWithImpl<PasswordStrengthState>(this as PasswordStrengthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordStrengthState&&(identical(other.response, response) || other.response == response)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,response,isLoading,error);

@override
String toString() {
  return 'PasswordStrengthState(response: $response, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $PasswordStrengthStateCopyWith<$Res>  {
  factory $PasswordStrengthStateCopyWith(PasswordStrengthState value, $Res Function(PasswordStrengthState) _then) = _$PasswordStrengthStateCopyWithImpl;
@useResult
$Res call({
 PasswordStrengthResponse? response, bool isLoading, String? error
});




}
/// @nodoc
class _$PasswordStrengthStateCopyWithImpl<$Res>
    implements $PasswordStrengthStateCopyWith<$Res> {
  _$PasswordStrengthStateCopyWithImpl(this._self, this._then);

  final PasswordStrengthState _self;
  final $Res Function(PasswordStrengthState) _then;

/// Create a copy of PasswordStrengthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? response = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as PasswordStrengthResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _PasswordStrengthState implements PasswordStrengthState {
  const _PasswordStrengthState({this.response, this.isLoading = false, this.error});
  

@override final  PasswordStrengthResponse? response;
@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of PasswordStrengthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordStrengthStateCopyWith<_PasswordStrengthState> get copyWith => __$PasswordStrengthStateCopyWithImpl<_PasswordStrengthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordStrengthState&&(identical(other.response, response) || other.response == response)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,response,isLoading,error);

@override
String toString() {
  return 'PasswordStrengthState(response: $response, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PasswordStrengthStateCopyWith<$Res> implements $PasswordStrengthStateCopyWith<$Res> {
  factory _$PasswordStrengthStateCopyWith(_PasswordStrengthState value, $Res Function(_PasswordStrengthState) _then) = __$PasswordStrengthStateCopyWithImpl;
@override @useResult
$Res call({
 PasswordStrengthResponse? response, bool isLoading, String? error
});




}
/// @nodoc
class __$PasswordStrengthStateCopyWithImpl<$Res>
    implements _$PasswordStrengthStateCopyWith<$Res> {
  __$PasswordStrengthStateCopyWithImpl(this._self, this._then);

  final _PasswordStrengthState _self;
  final $Res Function(_PasswordStrengthState) _then;

/// Create a copy of PasswordStrengthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? response = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_PasswordStrengthState(
response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as PasswordStrengthResponse?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
