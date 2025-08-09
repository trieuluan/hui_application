import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hui_application/core/models/password_strength_response.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_strength_provider.freezed.dart';
part 'password_strength_provider.g.dart';

@freezed
abstract class PasswordStrengthState with _$PasswordStrengthState {
  const factory PasswordStrengthState({
    PasswordStrengthResponse? response,
    @Default(false) bool isLoading,
    String? error,
  }) = _PasswordStrengthState;
}

@riverpod
class PasswordStrengthNotifier extends _$PasswordStrengthNotifier {
  @override
  PasswordStrengthState build() {
    return const PasswordStrengthState();
  }

  Future<void> checkPasswordStrength(String password) async {
    if (password.isEmpty) {
      state = const PasswordStrengthState();
      return;
    }

    // Set loading state
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await ref
          .read(authNotifierProvider.notifier)
          .checkPasswordStrength(password);

      if (result != null) {
        final response = PasswordStrengthResponse.fromJson(result);
        state = state.copyWith(
          response: response,
          isLoading: false,
          error: null,
        );
      } else {
        state = state.copyWith(
          response: null,
          isLoading: false,
          error: 'Không thể kiểm tra độ mạnh mật khẩu',
        );
      }
    } catch (e) {
      print('Password strength check failed: $e');
      state = state.copyWith(
        response: null,
        isLoading: false,
        error: 'Lỗi khi kiểm tra độ mạnh mật khẩu',
      );
    }
  }

  void clear() {
    state = const PasswordStrengthState();
  }

  /// Update state directly (for external use)
  void updateState(
    PasswordStrengthResponse? response, {
    bool isLoading = false,
    String? error,
  }) {
    state = state.copyWith(
      response: response,
      isLoading: isLoading,
      error: error,
    );
  }
}
