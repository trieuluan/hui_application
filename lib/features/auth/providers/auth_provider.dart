import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hui_application/core/network/api_exception.dart';
import 'package:hui_application/features/auth/services/auth_service.dart';
import 'package:hui_application/core/services/token_services.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hui_application/models/users.dart' as app_model;

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  @override
  AuthState build() {
    _loadAuthFromStorage();
    return const AuthState.initial();
  }

  void showLoading() {
    state = const AuthState.loading();
  }

  void hideLoading() {
    state = const AuthState.unauthenticated();
  }

  Future<void> _loadAuthFromStorage() async {
    final token = await TokenService.getToken();
    final user = await TokenService.getUser();
    if (token != null && token.isNotEmpty && user != null) {
      state = AuthState.authenticated(token: token, user: user);
    } else {
      state = AuthState.unauthenticated();
    }
  }

  static Future<void> saveVerificationId(String verificationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('verificationId', verificationId);
  }

  static Future<String?> getSavedVerificationId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('verificationId');
  }

  static Future<void> clearVerificationId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('verificationId');
  }

  Future<dynamic> login(String emailOrPhone, String password) async {
    showLoading();
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.login(
        emailOrPhone: emailOrPhone,
        password: password,
      );
      if (result != null) {
        final token = result['token'];
        final user = app_model.User.fromJson(result['user']);

        await TokenService.saveToken(token);
        await TokenService.saveUser(user.toJson());
        state = AuthState.authenticated(token: token, user: user);
        return result['message'];
      } else {
        state = AuthState.unauthenticated();
        return false;
      }
    } on ApiException catch (e) {
      state = AuthState.error(e.message.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    showLoading();
    try {
      await TokenService.clear();
      await FirebaseAuth.instance.signOut();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
      rethrow;
    }
  }

  Future<bool> register({
    required String emailOrPhone,
    required String name,
    required String password,
    required String passwordConfirm,
    required String email,
  }) async {
    showLoading();
    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.register(
        emailOrPhone: emailOrPhone,
        name: name,
        password: password,
        passwordConfirm: passwordConfirm,
        email: email,
      );
      if (result != null && result['success'] == true) {
        final token = result['token'];
        final user = app_model.User.fromJson(result['user']);

        await TokenService.saveToken(token);
        await TokenService.saveUser(user.toJson());
        state = AuthState.authenticated(token: token, user: user);
        return true;
      } else {
        state = AuthState.unauthenticated();
        return false;
      }
    } catch (e) {
      state = AuthState.error(e.toString());
      rethrow;
    }
  }

  Future<bool> checkAvailability(String emailOrPhone) async {
    try {
      final authService = ref.read(authServiceProvider);
      final isAvailable = await authService.checkAvailability(
        emailOrPhone: emailOrPhone,
      );
      print('isAvailable: $isAvailable');
      return isAvailable;
    } catch (e) {
      state = AuthState.error(e.toString());
      rethrow;
    }
  }

  Future<void> sendOtp(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Bạn có thể tự động sign in ở đây nếu cần (hoặc bỏ qua)
        },
        verificationFailed: (FirebaseAuthException e) {
          state = AuthState.error('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          saveVerificationId(verificationId);
          state = const AuthState.otpSent();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          saveVerificationId(verificationId);
        },
      );
    } catch (e) {
      print('Error sending OTP: $e');
      state = AuthState.error('Failed to send OTP: ${e.toString()}');
    }
  }

  Future<bool> verifyOtp(String otp) async {
    try {
      _verificationId = _verificationId ?? await getSavedVerificationId();
      if (_verificationId == null) {
        throw Exception('Verification ID not found');
      }

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      final result = await _auth.signInWithCredential(credential);
      if (result.user != null) {
        // Xác thực thành công
        state = const AuthState.otpVerified();
        await FirebaseAuth.instance.signOut();
        await clearVerificationId();
        return true;
      } else {
        state = const AuthState.error('OTP verification failed');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      state = AuthState.error('OTP verification failed: ${e.message}');
      return false;
    } catch (e) {
      state = AuthState.error('OTP verification error: ${e.toString()}');
      return false;
    }
  }

  Future<void> resendOtp(String phoneNumber) async {
    await sendOtp(phoneNumber);
  }
}
