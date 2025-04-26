// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {

 String get emailOrPhone; bool get isLoggedIn; String get token; Map<String, dynamic> get user;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.emailOrPhone, emailOrPhone) || other.emailOrPhone == emailOrPhone)&&(identical(other.isLoggedIn, isLoggedIn) || other.isLoggedIn == isLoggedIn)&&(identical(other.token, token) || other.token == token)&&const DeepCollectionEquality().equals(other.user, user));
}


@override
int get hashCode => Object.hash(runtimeType,emailOrPhone,isLoggedIn,token,const DeepCollectionEquality().hash(user));

@override
String toString() {
  return 'AuthState(emailOrPhone: $emailOrPhone, isLoggedIn: $isLoggedIn, token: $token, user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 String emailOrPhone, bool isLoggedIn, String token, Map<String, dynamic> user
});




}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? emailOrPhone = null,Object? isLoggedIn = null,Object? token = null,Object? user = null,}) {
  return _then(_self.copyWith(
emailOrPhone: null == emailOrPhone ? _self.emailOrPhone : emailOrPhone // ignore: cast_nullable_to_non_nullable
as String,isLoggedIn: null == isLoggedIn ? _self.isLoggedIn : isLoggedIn // ignore: cast_nullable_to_non_nullable
as bool,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// @nodoc


class _AuthState implements AuthState {
  const _AuthState({this.emailOrPhone = '', this.isLoggedIn = false, this.token = '', final  Map<String, dynamic> user = const {}}): _user = user;
  

@override@JsonKey() final  String emailOrPhone;
@override@JsonKey() final  bool isLoggedIn;
@override@JsonKey() final  String token;
 final  Map<String, dynamic> _user;
@override@JsonKey() Map<String, dynamic> get user {
  if (_user is EqualUnmodifiableMapView) return _user;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_user);
}


/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.emailOrPhone, emailOrPhone) || other.emailOrPhone == emailOrPhone)&&(identical(other.isLoggedIn, isLoggedIn) || other.isLoggedIn == isLoggedIn)&&(identical(other.token, token) || other.token == token)&&const DeepCollectionEquality().equals(other._user, _user));
}


@override
int get hashCode => Object.hash(runtimeType,emailOrPhone,isLoggedIn,token,const DeepCollectionEquality().hash(_user));

@override
String toString() {
  return 'AuthState(emailOrPhone: $emailOrPhone, isLoggedIn: $isLoggedIn, token: $token, user: $user)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 String emailOrPhone, bool isLoggedIn, String token, Map<String, dynamic> user
});




}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? emailOrPhone = null,Object? isLoggedIn = null,Object? token = null,Object? user = null,}) {
  return _then(_AuthState(
emailOrPhone: null == emailOrPhone ? _self.emailOrPhone : emailOrPhone // ignore: cast_nullable_to_non_nullable
as String,isLoggedIn: null == isLoggedIn ? _self.isLoggedIn : isLoggedIn // ignore: cast_nullable_to_non_nullable
as bool,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self._user : user // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
