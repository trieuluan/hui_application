import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/core/constants/endpoints.dart';
import 'package:hui_application/core/network/api_client.dart';
import 'package:hui_application/core/network/api_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@riverpod
AuthService authService(Ref ref) {
  final api = ref.read(apiclientProvider);
  return AuthService(api);
}

class AuthService {
  final ApiClient _api;

  AuthService(this._api);

  Future<Map<String, dynamic>?> login({
    required String emailOrPhone,
    required String password,
  }) async {
    try {
      final response = await _api.post(
        Endpoints.login,
        data: {'emailOrPhone': emailOrPhone, 'password': password},
      );
      return response.data;
    } on ApiException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> register({
    required String emailOrPhone,
    required String name,
    required String password,
    required String passwordConfirm,
    required String email,
  }) async {
    try {
      final response = await _api.post(
        Endpoints.register,
        data: {
          'emailOrPhone': emailOrPhone,
          'fullName': name,
          'password': password,
          'retypePassword': passwordConfirm,
          'email': email,
        },
      );
      return response.data;
    } on ApiException {
      rethrow;
    }
  }

  Future<bool> checkAvailability({required String emailOrPhone}) async {
    try {
      final response = await _api.post(
        Endpoints.checkAvailability,
        data: {'emailOrPhone': emailOrPhone},
      );
      return response.data['available'] as bool;
    } on ApiException {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _api.post(Endpoints.logout);
    } on ApiException {
      rethrow;
    }
  }
}
