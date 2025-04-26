import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:hui_application/features/auth/utils/auth_persistence.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  void setEmailOrPhone(String value) {
    state = state.copyWith(emailOrPhone: value);
  }

  void setToken(String value) {
    state = state.copyWith(token: value);
  }

  void setUser(Map<String, dynamic> value) {
    state = state.copyWith(user: value);
  }

  void login(bool value) {
    state = state.copyWith(isLoggedIn: value);
  }

  void logout() {
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

final authLoadProvider = FutureProvider.autoDispose<void>((ref) async {
  await AuthPersistence.loadAuthData(ref);
});
