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

  static Future<bool> checkAvailability(String emailOrPhone) async {
    return await AuthService.checkAvailability(emailOrPhone: emailOrPhone);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await AuthService.logout();
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
