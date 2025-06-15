import 'package:freezed_annotation/freezed_annotation.dart';

part 'users.freezed.dart';
part 'users.g.dart';

@Freezed()
abstract class User with _$User {
  const factory User({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'full_name') required String fullName,
    String? email,
    String? phone,
    required String role,
    Profile? profile,
    Kyc? kyc,
    String? status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@Freezed()
abstract class Profile with _$Profile {
  const factory Profile({
    required String dob,
    required String gender,
    required String address,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}

@Freezed()
abstract class Kyc with _$Kyc {
  const factory Kyc({
    required String status,
    @JsonKey(name: 'id_number') String? idNumber,
    @JsonKey(name: 'id_type') String? idType,
    @JsonKey(name: 'id_front_url') String? idFrontUrl,
    @JsonKey(name: 'id_back_url') String? idBackUrl,
    @JsonKey(name: 'selfie_url') String? selfieUrl,
    @JsonKey(name: 'verified_at') DateTime? verifiedAt,
  }) = _Kyc;

  factory Kyc.fromJson(Map<String, dynamic> json) => _$KycFromJson(json);
}
