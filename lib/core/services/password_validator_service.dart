import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/core/validators/password_strength_validator.dart';

class PasswordValidatorService {
  static Map<String, dynamic>? _cachedConfig;
  static DateTime? _cacheTime;
  static const Duration _cacheDuration = Duration(minutes: 5);

  /// Load password configuration from backend
  static Future<Map<String, dynamic>> loadPasswordConfig(WidgetRef ref) async {
    // Check cache first
    if (_cachedConfig != null && _cacheTime != null) {
      final timeDiff = DateTime.now().difference(_cacheTime!);
      if (timeDiff < _cacheDuration) {
        return _cachedConfig!;
      }
    }

    try {
      final result =
          await ref.read(authNotifierProvider.notifier).getPasswordConfig();
      if (result != null) {
        _cachedConfig = result;
        _cacheTime = DateTime.now();
        return result;
      }
    } catch (e) {
      print('Failed to load password config: $e');
    }

    // Return default config if API fails
    final defaultConfig = {
      'minLength': 6,
      'maxLength': 128,
      'requirements': {
        'uppercase': false,
        'lowercase': false,
        'numbers': false,
        'specialChars': false,
      },
    };

    _cachedConfig = defaultConfig;
    _cacheTime = DateTime.now();
    return defaultConfig;
  }

  /// Create password validators based on config
  static List<Validator> createPasswordValidators(Map<String, dynamic> config) {
    final validators = [Validators.required];

    final minLength = config['minLength'] as int? ?? 6;
    final maxLength = config['maxLength'] as int? ?? 128;

    validators.add(Validators.minLength(minLength));
    validators.add(Validators.maxLength(maxLength));

    // Add custom requirement validators
    final requirements = config['requirements'] as Map<String, dynamic>?;
    if (requirements != null) {
      if (requirements['uppercase'] == true) {
        validators.add(
          _createRequirementValidator(
            RegExp(r'[A-Z]'),
            'Mật khẩu phải có ít nhất 1 chữ hoa',
          ),
        );
      }

      if (requirements['lowercase'] == true) {
        validators.add(
          _createRequirementValidator(
            RegExp(r'[a-z]'),
            'Mật khẩu phải có ít nhất 1 chữ thường',
          ),
        );
      }

      if (requirements['numbers'] == true) {
        validators.add(
          _createRequirementValidator(
            RegExp(r'[0-9]'),
            'Mật khẩu phải có ít nhất 1 số',
          ),
        );
      }

      if (requirements['specialChars'] == true) {
        validators.add(
          _createRequirementValidator(
            RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
            'Mật khẩu phải có ít nhất 1 ký tự đặc biệt',
          ),
        );
      }
    }

    return validators;
  }

  /// Create confirm password validators
  static List<Validator> createConfirmPasswordValidators(
    Map<String, dynamic> config,
  ) {
    final validators = <Validator>[Validators.required];

    final minLength = config['minLength'] as int? ?? 6;
    validators.add(Validators.minLength(minLength));

    return validators;
  }

  /// Create async validators for password strength
  static List<AsyncValidator> createPasswordAsyncValidators(WidgetRef ref) {
    return [
      DelegateAsyncValidator((control) async {
        final password = control.value as String?;
        final errorMessage = await PasswordStrengthValidator.validatePassword(
          password,
          ref,
        );
        return errorMessage != null ? {'passwordStrength': errorMessage} : null;
      }),
    ];
  }

  /// Create validation messages
  static Map<String, String Function(Object)> createPasswordValidationMessages(
    Map<String, dynamic> config,
  ) {
    return {
      'required': (error) => 'Vui lòng nhập mật khẩu',
      'minLength':
          (error) =>
              'Mật khẩu phải có ít nhất ${config['minLength'] ?? 6} ký tự',
      'maxLength':
          (error) =>
              'Mật khẩu không được quá ${config['maxLength'] ?? 128} ký tự',
      'passwordStrength': (error) => error.toString(),
      'requirement': (error) => error.toString(),
    };
  }

  /// Create confirm password validation messages
  static Map<String, String Function(Object)>
  createConfirmPasswordValidationMessages(Map<String, dynamic> config) {
    return {
      'required': (error) => 'Vui lòng xác nhận mật khẩu',
      'minLength':
          (error) =>
              'Mật khẩu phải có ít nhất ${config['minLength'] ?? 6} ký tự',
      'mustMatch': (error) => 'Mật khẩu không khớp',
    };
  }

  /// Clear cache (useful for testing or when config changes)
  static void clearCache() {
    _cachedConfig = null;
    _cacheTime = null;
  }

  /// Create requirement validator helper
  static Validator _createRequirementValidator(
    RegExp regex,
    String errorMessage,
  ) {
    return DelegateValidator((AbstractControl control) {
      final value = control.value as String?;
      if (value == null || value.isEmpty) return null;

      if (!regex.hasMatch(value)) {
        return {'requirement': errorMessage};
      }
      return null;
    });
  }
}
