import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hui_application/widgets/reactive_intl_phone_field.dart';

part 'auth_flow_state.freezed.dart';

enum AuthStep { phoneInput, accountCheck, login, register, profileSetup, otp }

@freezed
abstract class AuthFlowState with _$AuthFlowState {
  const factory AuthFlowState({
    @Default(AuthStep.phoneInput) AuthStep currentStep,
    ParsedPhoneData? phoneNumber,
    String? password,
    String? confirmPassword,
    @Default(false) bool accountExists,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool isPasswordVisible,
    @Default(false) bool isConfirmPasswordVisible,
    // Profile setup fields
    String? selectedRole,
    String? fullName,
    String? dateOfBirth,
    String? gender,
    String? address,
  }) = _AuthFlowState;
}
