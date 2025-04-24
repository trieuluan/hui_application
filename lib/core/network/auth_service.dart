import 'package:dio/dio.dart';
import 'package:hui_application/core/constants/endpoints.dart';
import 'package:hui_application/core/network/api_client.dart';

class AuthService {
  static Future<String?> login({
    required String emailOrPhone,
    required String password,
  }) async {
    try {
      final response = await ApiClient.post(
        Endpoints.login,
        data: {'emailOrPhone': emailOrPhone, 'password': password},
      );
      final token = response.data['token'] as String?;
      return token;
    } on DioException catch (e) {
      print('❌ Login error: ${e.response?.data ?? e.message}');
      return null;
    }
  }

  static Future<bool> checkAvailability({required String emailOrPhone}) async {
    try {
      final response = await ApiClient.post(
        Endpoints.checkAvailability,
        data: {'emailOrPhone': emailOrPhone},
      );
      return response.data['available'] as bool;
    } on DioException catch (e) {
      final errorMessage =
          e.response!.data['details'][0]['message'] ??
          'Failed to check availability.';
      throw errorMessage;
    }
  }

  static Future<void> logout() async {
    try {
      await ApiClient.post(Endpoints.logout);
    } on DioException catch (e) {
      print('❌ Logout error: ${e.response?.data ?? e.message}');
    }
  }
}
