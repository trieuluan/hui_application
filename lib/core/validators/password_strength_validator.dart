import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/core/models/password_strength_response.dart';
import 'package:hui_application/features/auth/providers/password_strength_provider.dart';

class PasswordStrengthValidator {
  static Timer? _debounceTimer;
  static String? _lastPassword;
  static PasswordStrengthResponse? _lastResult;
  static Completer<String?>? _currentCompleter;

  static Future<String?> validatePassword(
    String? password,
    WidgetRef ref,
  ) async {
    if (password == null || password.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }

    if (password.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }

    // Return cached result if same password
    if (_lastPassword == password && _lastResult != null) {
      return _getValidationMessage(_lastResult!);
    }

    // Cancel previous timer and completer
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
      // Safely complete completer if it's not already completed
      if (_currentCompleter != null && !_currentCompleter!.isCompleted) {
        _currentCompleter!.complete(null);
      }
    }

    // Create a new completer to wait for the API result
    _currentCompleter = Completer<String?>();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        final result = await ref
            .read(authNotifierProvider.notifier)
            .checkPasswordStrength(password);
        _lastPassword = password;
        _lastResult =
            result != null ? PasswordStrengthResponse.fromJson(result) : null;

        // Update the provider state
        if (_lastResult != null) {
          ref
              .read(passwordStrengthNotifierProvider.notifier)
              .updateState(_lastResult, isLoading: false, error: null);
        }

        // Return the validation message
        final errorMessage =
            _lastResult != null ? _getValidationMessage(_lastResult!) : null;

        // Safely complete completer if it's not already completed
        if (_currentCompleter != null && !_currentCompleter!.isCompleted) {
          _currentCompleter!.complete(errorMessage);
        }
      } catch (e) {
        // Handle API errors
        print('Password strength check failed: $e');

        // Safely complete completer if it's not already completed
        if (_currentCompleter != null && !_currentCompleter!.isCompleted) {
          _currentCompleter!.complete('Không thể kiểm tra độ mạnh mật khẩu');
        }
      }
    });

    // Wait for the debounced API call to complete
    return await _currentCompleter!.future;
  }

  /// Update password strength provider directly (for real-time feedback)
  static void updatePasswordStrengthProvider(String? password, WidgetRef ref) {
    if (password == null || password.isEmpty) {
      ref.read(passwordStrengthNotifierProvider.notifier).clear();
      return;
    }

    // Debounce the provider update
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      await ref
          .read(passwordStrengthNotifierProvider.notifier)
          .checkPasswordStrength(password);
    });
  }

  static String? _getValidationMessage(PasswordStrengthResponse result) {
    // Check if password is strong based on API response
    if (result.isStrong) {
      return null; // Password is strong
    }

    // Check additional validation errors first (from API)
    final errors = result.additionalValidation['errors'] as List<dynamic>?;
    if (errors != null && errors.isNotEmpty) {
      return errors.first.toString();
    }

    // Check zxcvbn feedback from API
    final warning = result.feedback['warning'] as String?;
    final suggestions = result.feedback['suggestions'] as List<dynamic>?;

    if (warning != null && warning.isNotEmpty) {
      return warning;
    }

    if (suggestions != null && suggestions.isNotEmpty) {
      return suggestions.first.toString();
    }

    // Default message
    return 'Mật khẩu không đủ mạnh';
  }

  static void clearCache() {
    _lastPassword = null;
    _lastResult = null;
    // Safely complete completer if it's not already completed
    if (_currentCompleter != null && !_currentCompleter!.isCompleted) {
      _currentCompleter!.complete(null);
    }
    _currentCompleter = null;
  }
}
