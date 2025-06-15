// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

@JsonKey(name: '_id') String? get id;@JsonKey(name: 'full_name') String get fullName; String? get email; String? get phone; String get role; Profile? get profile; Kyc? get kyc; String? get status;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.kyc, kyc) || other.kyc == kyc)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,phone,role,profile,kyc,status,createdAt,updatedAt);

@override
String toString() {
  return 'User(id: $id, fullName: $fullName, email: $email, phone: $phone, role: $role, profile: $profile, kyc: $kyc, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? id,@JsonKey(name: 'full_name') String fullName, String? email, String? phone, String role, Profile? profile, Kyc? kyc, String? status,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});


$ProfileCopyWith<$Res>? get profile;$KycCopyWith<$Res>? get kyc;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? fullName = null,Object? email = freezed,Object? phone = freezed,Object? role = null,Object? profile = freezed,Object? kyc = freezed,Object? status = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Profile?,kyc: freezed == kyc ? _self.kyc : kyc // ignore: cast_nullable_to_non_nullable
as Kyc?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KycCopyWith<$Res>? get kyc {
    if (_self.kyc == null) {
    return null;
  }

  return $KycCopyWith<$Res>(_self.kyc!, (value) {
    return _then(_self.copyWith(kyc: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _User implements User {
  const _User({@JsonKey(name: '_id') this.id, @JsonKey(name: 'full_name') required this.fullName, this.email, this.phone, required this.role, this.profile, this.kyc, this.status, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override@JsonKey(name: '_id') final  String? id;
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  String? email;
@override final  String? phone;
@override final  String role;
@override final  Profile? profile;
@override final  Kyc? kyc;
@override final  String? status;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.kyc, kyc) || other.kyc == kyc)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,phone,role,profile,kyc,status,createdAt,updatedAt);

@override
String toString() {
  return 'User(id: $id, fullName: $fullName, email: $email, phone: $phone, role: $role, profile: $profile, kyc: $kyc, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? id,@JsonKey(name: 'full_name') String fullName, String? email, String? phone, String role, Profile? profile, Kyc? kyc, String? status,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});


@override $ProfileCopyWith<$Res>? get profile;@override $KycCopyWith<$Res>? get kyc;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? fullName = null,Object? email = freezed,Object? phone = freezed,Object? role = null,Object? profile = freezed,Object? kyc = freezed,Object? status = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_User(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Profile?,kyc: freezed == kyc ? _self.kyc : kyc // ignore: cast_nullable_to_non_nullable
as Kyc?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KycCopyWith<$Res>? get kyc {
    if (_self.kyc == null) {
    return null;
  }

  return $KycCopyWith<$Res>(_self.kyc!, (value) {
    return _then(_self.copyWith(kyc: value));
  });
}
}


/// @nodoc
mixin _$Profile {

 String get dob; String get gender; String get address;
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dob,gender,address);

@override
String toString() {
  return 'Profile(dob: $dob, gender: $gender, address: $address)';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res>  {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 String dob, String gender, String address
});




}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dob = null,Object? gender = null,Object? address = null,}) {
  return _then(_self.copyWith(
dob: null == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Profile implements Profile {
  const _Profile({required this.dob, required this.gender, required this.address});
  factory _Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

@override final  String dob;
@override final  String gender;
@override final  String address;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCopyWith<_Profile> get copyWith => __$ProfileCopyWithImpl<_Profile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Profile&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dob,gender,address);

@override
String toString() {
  return 'Profile(dob: $dob, gender: $gender, address: $address)';
}


}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) = __$ProfileCopyWithImpl;
@override @useResult
$Res call({
 String dob, String gender, String address
});




}
/// @nodoc
class __$ProfileCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dob = null,Object? gender = null,Object? address = null,}) {
  return _then(_Profile(
dob: null == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Kyc {

 String get status;@JsonKey(name: 'id_number') String? get idNumber;@JsonKey(name: 'id_type') String? get idType;@JsonKey(name: 'id_front_url') String? get idFrontUrl;@JsonKey(name: 'id_back_url') String? get idBackUrl;@JsonKey(name: 'selfie_url') String? get selfieUrl;@JsonKey(name: 'verified_at') DateTime? get verifiedAt;
/// Create a copy of Kyc
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KycCopyWith<Kyc> get copyWith => _$KycCopyWithImpl<Kyc>(this as Kyc, _$identity);

  /// Serializes this Kyc to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Kyc&&(identical(other.status, status) || other.status == status)&&(identical(other.idNumber, idNumber) || other.idNumber == idNumber)&&(identical(other.idType, idType) || other.idType == idType)&&(identical(other.idFrontUrl, idFrontUrl) || other.idFrontUrl == idFrontUrl)&&(identical(other.idBackUrl, idBackUrl) || other.idBackUrl == idBackUrl)&&(identical(other.selfieUrl, selfieUrl) || other.selfieUrl == selfieUrl)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,idNumber,idType,idFrontUrl,idBackUrl,selfieUrl,verifiedAt);

@override
String toString() {
  return 'Kyc(status: $status, idNumber: $idNumber, idType: $idType, idFrontUrl: $idFrontUrl, idBackUrl: $idBackUrl, selfieUrl: $selfieUrl, verifiedAt: $verifiedAt)';
}


}

/// @nodoc
abstract mixin class $KycCopyWith<$Res>  {
  factory $KycCopyWith(Kyc value, $Res Function(Kyc) _then) = _$KycCopyWithImpl;
@useResult
$Res call({
 String status,@JsonKey(name: 'id_number') String? idNumber,@JsonKey(name: 'id_type') String? idType,@JsonKey(name: 'id_front_url') String? idFrontUrl,@JsonKey(name: 'id_back_url') String? idBackUrl,@JsonKey(name: 'selfie_url') String? selfieUrl,@JsonKey(name: 'verified_at') DateTime? verifiedAt
});




}
/// @nodoc
class _$KycCopyWithImpl<$Res>
    implements $KycCopyWith<$Res> {
  _$KycCopyWithImpl(this._self, this._then);

  final Kyc _self;
  final $Res Function(Kyc) _then;

/// Create a copy of Kyc
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? idNumber = freezed,Object? idType = freezed,Object? idFrontUrl = freezed,Object? idBackUrl = freezed,Object? selfieUrl = freezed,Object? verifiedAt = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,idNumber: freezed == idNumber ? _self.idNumber : idNumber // ignore: cast_nullable_to_non_nullable
as String?,idType: freezed == idType ? _self.idType : idType // ignore: cast_nullable_to_non_nullable
as String?,idFrontUrl: freezed == idFrontUrl ? _self.idFrontUrl : idFrontUrl // ignore: cast_nullable_to_non_nullable
as String?,idBackUrl: freezed == idBackUrl ? _self.idBackUrl : idBackUrl // ignore: cast_nullable_to_non_nullable
as String?,selfieUrl: freezed == selfieUrl ? _self.selfieUrl : selfieUrl // ignore: cast_nullable_to_non_nullable
as String?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Kyc implements Kyc {
  const _Kyc({required this.status, @JsonKey(name: 'id_number') this.idNumber, @JsonKey(name: 'id_type') this.idType, @JsonKey(name: 'id_front_url') this.idFrontUrl, @JsonKey(name: 'id_back_url') this.idBackUrl, @JsonKey(name: 'selfie_url') this.selfieUrl, @JsonKey(name: 'verified_at') this.verifiedAt});
  factory _Kyc.fromJson(Map<String, dynamic> json) => _$KycFromJson(json);

@override final  String status;
@override@JsonKey(name: 'id_number') final  String? idNumber;
@override@JsonKey(name: 'id_type') final  String? idType;
@override@JsonKey(name: 'id_front_url') final  String? idFrontUrl;
@override@JsonKey(name: 'id_back_url') final  String? idBackUrl;
@override@JsonKey(name: 'selfie_url') final  String? selfieUrl;
@override@JsonKey(name: 'verified_at') final  DateTime? verifiedAt;

/// Create a copy of Kyc
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KycCopyWith<_Kyc> get copyWith => __$KycCopyWithImpl<_Kyc>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KycToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Kyc&&(identical(other.status, status) || other.status == status)&&(identical(other.idNumber, idNumber) || other.idNumber == idNumber)&&(identical(other.idType, idType) || other.idType == idType)&&(identical(other.idFrontUrl, idFrontUrl) || other.idFrontUrl == idFrontUrl)&&(identical(other.idBackUrl, idBackUrl) || other.idBackUrl == idBackUrl)&&(identical(other.selfieUrl, selfieUrl) || other.selfieUrl == selfieUrl)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,idNumber,idType,idFrontUrl,idBackUrl,selfieUrl,verifiedAt);

@override
String toString() {
  return 'Kyc(status: $status, idNumber: $idNumber, idType: $idType, idFrontUrl: $idFrontUrl, idBackUrl: $idBackUrl, selfieUrl: $selfieUrl, verifiedAt: $verifiedAt)';
}


}

/// @nodoc
abstract mixin class _$KycCopyWith<$Res> implements $KycCopyWith<$Res> {
  factory _$KycCopyWith(_Kyc value, $Res Function(_Kyc) _then) = __$KycCopyWithImpl;
@override @useResult
$Res call({
 String status,@JsonKey(name: 'id_number') String? idNumber,@JsonKey(name: 'id_type') String? idType,@JsonKey(name: 'id_front_url') String? idFrontUrl,@JsonKey(name: 'id_back_url') String? idBackUrl,@JsonKey(name: 'selfie_url') String? selfieUrl,@JsonKey(name: 'verified_at') DateTime? verifiedAt
});




}
/// @nodoc
class __$KycCopyWithImpl<$Res>
    implements _$KycCopyWith<$Res> {
  __$KycCopyWithImpl(this._self, this._then);

  final _Kyc _self;
  final $Res Function(_Kyc) _then;

/// Create a copy of Kyc
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? idNumber = freezed,Object? idType = freezed,Object? idFrontUrl = freezed,Object? idBackUrl = freezed,Object? selfieUrl = freezed,Object? verifiedAt = freezed,}) {
  return _then(_Kyc(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,idNumber: freezed == idNumber ? _self.idNumber : idNumber // ignore: cast_nullable_to_non_nullable
as String?,idType: freezed == idType ? _self.idType : idType // ignore: cast_nullable_to_non_nullable
as String?,idFrontUrl: freezed == idFrontUrl ? _self.idFrontUrl : idFrontUrl // ignore: cast_nullable_to_non_nullable
as String?,idBackUrl: freezed == idBackUrl ? _self.idBackUrl : idBackUrl // ignore: cast_nullable_to_non_nullable
as String?,selfieUrl: freezed == selfieUrl ? _self.selfieUrl : selfieUrl // ignore: cast_nullable_to_non_nullable
as String?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
