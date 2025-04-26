import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthPersistence {
  static const _tokenKey = 'authToken';
  static const _userInfoKey = 'userInfo';
  static const _isLoggedInKey = 'isLoggedIn';

  static Future<void> saveAuthData(AuthState authState) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, authState.token);
    await prefs.setString(_userInfoKey, jsonEncode(authState.user));
    await prefs.setBool(_isLoggedInKey, authState.isLoggedIn);
  }

  static Future<void> loadAuthData(Ref ref) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey) ?? '';
    final userInfo = prefs.getString(_userInfoKey);
    final user =
        userInfo != null
            ? Map<String, dynamic>.from(jsonDecode(userInfo))
            : <String, dynamic>{};
    final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    ref.read(authProvider.notifier)
      ..setToken(token)
      ..setUser(user)
      ..login(isLoggedIn);
  }

  static Future<void> clearAuthData(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userInfoKey);
    await prefs.remove(_isLoggedInKey);
    ref.read(authProvider.notifier).logout();
  }
}
