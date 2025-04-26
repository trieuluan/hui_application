import 'package:hui_application/core/network/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static const _tokenKey = 'auth_token';

  static Future<bool> login(String emailOrPhone, String password) async {
    final token = await AuthService.login(
      emailOrPhone: emailOrPhone,
      password: password,
    );
    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
      return true;
    }
    return false;
  }

  static Future<Map<String, dynamic>?> register({
    required String emailOrPhone,
    required String name,
    required String password,
    required String passwordConfirm,
    required String email,
  }) async {
    return await AuthService.register(
      emailOrPhone: emailOrPhone,
      name: name,
      password: password,
      passwordConfirm: passwordConfirm,
      email: email,
    );
  }

  static Future<bool> checkAvailability(String emailOrPhone) async {
    return await AuthService.checkAvailability(emailOrPhone: emailOrPhone);
  }
}
