// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['_id'] as String?,
  fullName: json['full_name'] as String,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  role: json['role'] as String,
  profile:
      json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
  kyc:
      json['kyc'] == null
          ? null
          : Kyc.fromJson(json['kyc'] as Map<String, dynamic>),
  status: json['status'] as String?,
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  '_id': instance.id,
  'full_name': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'role': instance.role,
  'profile': instance.profile,
  'kyc': instance.kyc,
  'status': instance.status,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  dob: json['dob'] as String,
  gender: json['gender'] as String,
  address: json['address'] as String,
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'dob': instance.dob,
  'gender': instance.gender,
  'address': instance.address,
};

_Kyc _$KycFromJson(Map<String, dynamic> json) => _Kyc(
  status: json['status'] as String,
  idNumber: json['id_number'] as String?,
  idType: json['id_type'] as String?,
  idFrontUrl: json['id_front_url'] as String?,
  idBackUrl: json['id_back_url'] as String?,
  selfieUrl: json['selfie_url'] as String?,
  verifiedAt:
      json['verified_at'] == null
          ? null
          : DateTime.parse(json['verified_at'] as String),
);

Map<String, dynamic> _$KycToJson(_Kyc instance) => <String, dynamic>{
  'status': instance.status,
  'id_number': instance.idNumber,
  'id_type': instance.idType,
  'id_front_url': instance.idFrontUrl,
  'id_back_url': instance.idBackUrl,
  'selfie_url': instance.selfieUrl,
  'verified_at': instance.verifiedAt?.toIso8601String(),
};
