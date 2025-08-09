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
    List<String>? permissions,
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

@Freezed()
abstract class Permissions with _$Permissions {
  const factory Permissions({
    @Default(false) bool canCreateGroup,
    @Default(false) bool canJoinGroup,
    @Default(false) bool canInviteMembers,
    @Default(false) bool canRemoveMembers,
    @Default(false) bool canManageGroupSettings,
    @Default(false) bool canViewGroupDetails,
    @Default(false) bool canMakePayments,
    @Default(false) bool canViewPayments,
    @Default(false) bool canManageKyc,
    @Default(false) bool canViewReports,
    @Default(false) bool canDeleteGroup,
    @Default(false) bool canEditGroup,
    @Default(false) bool canApproveJoinRequests,
    @Default(false) bool canRejectJoinRequests,
    @Default(false) bool canViewAllGroups,
    @Default(false) bool canManageUsers,
    @Default(false) bool canViewAdminPanel,
  }) = _Permissions;

  factory Permissions.fromJson(Map<String, dynamic> json) =>
      _$PermissionsFromJson(json);

  // Map backend permissions to frontend permissions
  factory Permissions.fromBackendPermissions(List<String>? backendPermissions) {
    if (backendPermissions == null) return const Permissions();

    return Permissions(
      canCreateGroup: backendPermissions.contains('group:create'),
      canJoinGroup: backendPermissions.contains('group:view'),
      canInviteMembers: backendPermissions.contains('group_member:add'),
      canRemoveMembers: backendPermissions.contains('group_member:remove'),
      canManageGroupSettings: backendPermissions.contains('group:update'),
      canViewGroupDetails: backendPermissions.contains('group:view'),
      canMakePayments: backendPermissions.contains('group:view'),
      canViewPayments: backendPermissions.contains('group:view'),
      canManageKyc: backendPermissions.contains('user:update'),
      canViewReports: backendPermissions.contains('group:view'),
      canDeleteGroup: backendPermissions.contains('group:delete'),
      canEditGroup: backendPermissions.contains('group:update'),
      canApproveJoinRequests: backendPermissions.contains(
        'group_member:update',
      ),
      canRejectJoinRequests: backendPermissions.contains('group_member:remove'),
      canViewAllGroups: backendPermissions.contains('group:view'),
      canManageUsers: backendPermissions.contains('user:update'),
      canViewAdminPanel: backendPermissions.contains('role:view'),
    );
  }
}

// Extension to easily get permissions from User
extension UserPermissions on User {
  Permissions get userPermissions =>
      Permissions.fromBackendPermissions(permissions);
}
