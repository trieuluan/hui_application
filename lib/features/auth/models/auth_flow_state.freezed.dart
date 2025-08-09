// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_flow_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthFlowState {

 AuthStep get currentStep; ParsedPhoneData? get phoneNumber; String? get password; String? get confirmPassword; bool get accountExists; bool get isLoading; String? get errorMessage; bool get isPasswordVisible; bool get isConfirmPasswordVisible;// Profile setup fields
 String? get selectedRole; String? get fullName; String? get dateOfBirth; String? get gender; String? get address;
/// Create a copy of AuthFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthFlowStateCopyWith<AuthFlowState> get copyWith => _$AuthFlowStateCopyWithImpl<AuthFlowState>(this as AuthFlowState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFlowState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.accountExists, accountExists) || other.accountExists == accountExists)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isPasswordVisible, isPasswordVisible) || other.isPasswordVisible == isPasswordVisible)&&(identical(other.isConfirmPasswordVisible, isConfirmPasswordVisible) || other.isConfirmPasswordVisible == isConfirmPasswordVisible)&&(identical(other.selectedRole, selectedRole) || other.selectedRole == selectedRole)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,phoneNumber,password,confirmPassword,accountExists,isLoading,errorMessage,isPasswordVisible,isConfirmPasswordVisible,selectedRole,fullName,dateOfBirth,gender,address);

@override
String toString() {
  return 'AuthFlowState(currentStep: $currentStep, phoneNumber: $phoneNumber, password: $password, confirmPassword: $confirmPassword, accountExists: $accountExists, isLoading: $isLoading, errorMessage: $errorMessage, isPasswordVisible: $isPasswordVisible, isConfirmPasswordVisible: $isConfirmPasswordVisible, selectedRole: $selectedRole, fullName: $fullName, dateOfBirth: $dateOfBirth, gender: $gender, address: $address)';
}


}

/// @nodoc
abstract mixin class $AuthFlowStateCopyWith<$Res>  {
  factory $AuthFlowStateCopyWith(AuthFlowState value, $Res Function(AuthFlowState) _then) = _$AuthFlowStateCopyWithImpl;
@useResult
$Res call({
 AuthStep currentStep, ParsedPhoneData? phoneNumber, String? password, String? confirmPassword, bool accountExists, bool isLoading, String? errorMessage, bool isPasswordVisible, bool isConfirmPasswordVisible, String? selectedRole, String? fullName, String? dateOfBirth, String? gender, String? address
});




}
/// @nodoc
class _$AuthFlowStateCopyWithImpl<$Res>
    implements $AuthFlowStateCopyWith<$Res> {
  _$AuthFlowStateCopyWithImpl(this._self, this._then);

  final AuthFlowState _self;
  final $Res Function(AuthFlowState) _then;

/// Create a copy of AuthFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStep = null,Object? phoneNumber = freezed,Object? password = freezed,Object? confirmPassword = freezed,Object? accountExists = null,Object? isLoading = null,Object? errorMessage = freezed,Object? isPasswordVisible = null,Object? isConfirmPasswordVisible = null,Object? selectedRole = freezed,Object? fullName = freezed,Object? dateOfBirth = freezed,Object? gender = freezed,Object? address = freezed,}) {
  return _then(_self.copyWith(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as AuthStep,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as ParsedPhoneData?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,confirmPassword: freezed == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String?,accountExists: null == accountExists ? _self.accountExists : accountExists // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isConfirmPasswordVisible: null == isConfirmPasswordVisible ? _self.isConfirmPasswordVisible : isConfirmPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,selectedRole: freezed == selectedRole ? _self.selectedRole : selectedRole // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _AuthFlowState implements AuthFlowState {
  const _AuthFlowState({this.currentStep = AuthStep.phoneInput, this.phoneNumber, this.password, this.confirmPassword, this.accountExists = false, this.isLoading = false, this.errorMessage, this.isPasswordVisible = false, this.isConfirmPasswordVisible = false, this.selectedRole, this.fullName, this.dateOfBirth, this.gender, this.address});
  

@override@JsonKey() final  AuthStep currentStep;
@override final  ParsedPhoneData? phoneNumber;
@override final  String? password;
@override final  String? confirmPassword;
@override@JsonKey() final  bool accountExists;
@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;
@override@JsonKey() final  bool isPasswordVisible;
@override@JsonKey() final  bool isConfirmPasswordVisible;
// Profile setup fields
@override final  String? selectedRole;
@override final  String? fullName;
@override final  String? dateOfBirth;
@override final  String? gender;
@override final  String? address;

/// Create a copy of AuthFlowState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthFlowStateCopyWith<_AuthFlowState> get copyWith => __$AuthFlowStateCopyWithImpl<_AuthFlowState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthFlowState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.accountExists, accountExists) || other.accountExists == accountExists)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isPasswordVisible, isPasswordVisible) || other.isPasswordVisible == isPasswordVisible)&&(identical(other.isConfirmPasswordVisible, isConfirmPasswordVisible) || other.isConfirmPasswordVisible == isConfirmPasswordVisible)&&(identical(other.selectedRole, selectedRole) || other.selectedRole == selectedRole)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,phoneNumber,password,confirmPassword,accountExists,isLoading,errorMessage,isPasswordVisible,isConfirmPasswordVisible,selectedRole,fullName,dateOfBirth,gender,address);

@override
String toString() {
  return 'AuthFlowState(currentStep: $currentStep, phoneNumber: $phoneNumber, password: $password, confirmPassword: $confirmPassword, accountExists: $accountExists, isLoading: $isLoading, errorMessage: $errorMessage, isPasswordVisible: $isPasswordVisible, isConfirmPasswordVisible: $isConfirmPasswordVisible, selectedRole: $selectedRole, fullName: $fullName, dateOfBirth: $dateOfBirth, gender: $gender, address: $address)';
}


}

/// @nodoc
abstract mixin class _$AuthFlowStateCopyWith<$Res> implements $AuthFlowStateCopyWith<$Res> {
  factory _$AuthFlowStateCopyWith(_AuthFlowState value, $Res Function(_AuthFlowState) _then) = __$AuthFlowStateCopyWithImpl;
@override @useResult
$Res call({
 AuthStep currentStep, ParsedPhoneData? phoneNumber, String? password, String? confirmPassword, bool accountExists, bool isLoading, String? errorMessage, bool isPasswordVisible, bool isConfirmPasswordVisible, String? selectedRole, String? fullName, String? dateOfBirth, String? gender, String? address
});




}
/// @nodoc
class __$AuthFlowStateCopyWithImpl<$Res>
    implements _$AuthFlowStateCopyWith<$Res> {
  __$AuthFlowStateCopyWithImpl(this._self, this._then);

  final _AuthFlowState _self;
  final $Res Function(_AuthFlowState) _then;

/// Create a copy of AuthFlowState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStep = null,Object? phoneNumber = freezed,Object? password = freezed,Object? confirmPassword = freezed,Object? accountExists = null,Object? isLoading = null,Object? errorMessage = freezed,Object? isPasswordVisible = null,Object? isConfirmPasswordVisible = null,Object? selectedRole = freezed,Object? fullName = freezed,Object? dateOfBirth = freezed,Object? gender = freezed,Object? address = freezed,}) {
  return _then(_AuthFlowState(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as AuthStep,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as ParsedPhoneData?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,confirmPassword: freezed == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String?,accountExists: null == accountExists ? _self.accountExists : accountExists // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isPasswordVisible: null == isPasswordVisible ? _self.isPasswordVisible : isPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isConfirmPasswordVisible: null == isConfirmPasswordVisible ? _self.isConfirmPasswordVisible : isConfirmPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,selectedRole: freezed == selectedRole ? _self.selectedRole : selectedRole // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
