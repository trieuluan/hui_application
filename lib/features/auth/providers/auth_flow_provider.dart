import 'package:hui_application/widgets/reactive_intl_phone_field.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hui_application/core/network/api_exception.dart';
import 'package:hui_application/features/auth/models/auth_flow_state.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/core/utils/snackbar_util.dart';

part 'auth_flow_provider.g.dart';

@riverpod
class AuthFlowNotifier extends _$AuthFlowNotifier {
  @override
  AuthFlowState build() {
    return const AuthFlowState();
  }

  void setPhoneNumber(ParsedPhoneData? phone) {
    state = state.copyWith(phoneNumber: phone);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
  }

  void nextStep(AuthStep step) {
    state = state.copyWith(currentStep: step);
  }

  void goBack() {
    switch (state.currentStep) {
      case AuthStep.login:
      case AuthStep.register:
        nextStep(AuthStep.phoneInput);
        break;
      case AuthStep.profileSetup:
        nextStep(state.accountExists ? AuthStep.login : AuthStep.register);
        break;
      case AuthStep.otp:
        nextStep(AuthStep.profileSetup);
        break;
      default:
        break;
    }
  }

  void setAccountExists(bool exists) {
    state = state.copyWith(accountExists: exists);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(errorMessage: error);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    );
  }

  void setSelectedRole(String role) {
    state = state.copyWith(selectedRole: role);
  }

  void setFullName(String fullName) {
    state = state.copyWith(fullName: fullName);
  }

  void setDateOfBirth(String dateOfBirth) {
    state = state.copyWith(dateOfBirth: dateOfBirth);
  }

  void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void setAddress(String address) {
    state = state.copyWith(address: address);
  }

  Future<void> checkAccount() async {
    try {
      setLoading(true);
      clearError();

      final authNotifier = ref.read(authNotifierProvider.notifier);
      final isAvailable = await authNotifier.checkAvailability(
        state.phoneNumber?.e164 ?? '',
      );

      setAccountExists(isAvailable);

      if (!isAvailable) {
        nextStep(AuthStep.register);
      } else {
        nextStep(AuthStep.login);
      }
    } on ApiException catch (e) {
      setError(e.message.toString());
      showGlobalErrorSnackBar(
        message: e.message.toString(),
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      setError(e.toString());
      showGlobalErrorSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 5),
      );
    } finally {
      setLoading(false);
    }
  }

  Future<void> handleLogin() async {
    try {
      setLoading(true);
      clearError();

      // First check password before sending OTP
      final authNotifier = ref.read(authNotifierProvider.notifier);
      final passwordCheckResult = await authNotifier.checkPassword(
        emailOrPhone: state.phoneNumber?.e164 ?? '',
        password: state.password ?? '',
      );

      if (passwordCheckResult != null &&
          passwordCheckResult['success'] == true) {
        // Password is correct, now send OTP
        await authNotifier.sendOtp(state.phoneNumber?.e164 ?? '');
        nextStep(AuthStep.otp);
      } else {
        // Password check failed
        setError(passwordCheckResult?['error']);
        showGlobalErrorSnackBar(
          message: passwordCheckResult?['error'],
          duration: const Duration(seconds: 3),
        );
      }
    } on ApiException catch (e) {
      setError(e.message.toString());
      showGlobalErrorSnackBar(
        message: e.message.toString(),
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      setError(e.toString());
      showGlobalErrorSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 5),
      );
    } finally {
      setLoading(false);
    }
  }

  Future<void> handleRegister() async {
    try {
      setLoading(true);
      clearError();

      if (state.password != state.confirmPassword) {
        setError('Mật khẩu xác nhận không khớp');
        showGlobalErrorSnackBar(
          message: 'Mật khẩu xác nhận không khớp',
          duration: const Duration(seconds: 3),
        );
        return;
      }

      // Go to profile setup instead of directly to OTP
      nextStep(AuthStep.profileSetup);
    } on ApiException catch (e) {
      setError(e.message.toString());
      showGlobalErrorSnackBar(
        message: e.message.toString(),
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      setError(e.toString());
      showGlobalErrorSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 5),
      );
    } finally {
      setLoading(false);
    }
  }

  Future<void> handleProfileSetup() async {
    try {
      setLoading(true);
      clearError();

      // Validate profile data
      if (state.selectedRole == null || state.selectedRole!.isEmpty) {
        setError('Vui lòng chọn vai trò');
        showGlobalErrorSnackBar(
          message: 'Vui lòng chọn vai trò',
          duration: const Duration(seconds: 3),
        );
        return;
      }

      if (state.fullName == null || state.fullName!.isEmpty) {
        setError('Vui lòng nhập họ tên');
        showGlobalErrorSnackBar(
          message: 'Vui lòng nhập họ tên',
          duration: const Duration(seconds: 3),
        );
        return;
      }

      if (state.dateOfBirth == null || state.dateOfBirth!.isEmpty) {
        setError('Vui lòng chọn ngày sinh');
        showGlobalErrorSnackBar(
          message: 'Vui lòng chọn ngày sinh',
          duration: const Duration(seconds: 3),
        );
        return;
      }

      if (state.gender == null || state.gender!.isEmpty) {
        setError('Vui lòng chọn giới tính');
        showGlobalErrorSnackBar(
          message: 'Vui lòng chọn giới tính',
          duration: const Duration(seconds: 3),
        );
        return;
      }

      if (state.address == null || state.address!.isEmpty) {
        setError('Vui lòng nhập địa chỉ');
        showGlobalErrorSnackBar(
          message: 'Vui lòng nhập địa chỉ',
          duration: const Duration(seconds: 3),
        );
        return;
      }

      // Send OTP after profile setup is complete
      final authNotifier = ref.read(authNotifierProvider.notifier);
      await authNotifier.sendOtp(state.phoneNumber?.e164 ?? '');

      nextStep(AuthStep.otp);
    } on ApiException catch (e) {
      setError(e.message.toString());
      showGlobalErrorSnackBar(
        message: e.message.toString(),
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      setError(e.toString());
      showGlobalErrorSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 5),
      );
    } finally {
      setLoading(false);
    }
  }

  void reset() {
    state = const AuthFlowState();
  }
}
