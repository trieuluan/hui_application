import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hui_application/core/config/app_config.dart';
import 'package:hui_application/core/network/api_exception.dart';
import 'package:hui_application/core/providers/app_locale_provider.dart';
import 'package:hui_application/core/services/token_services.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

@riverpod
ApiClient apiclient(Ref ref) {
  return ApiClient(ref);
}

class ApiClient {
  final Ref ref;
  late final Dio _dio;

  ApiClient(this.ref) {
    _dio = Dio(
        BaseOptions(
          baseUrl: AppConfig.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
            'Accept-Language': _getCurrentLanguage(),
          },
        ),
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final token = await TokenService.getToken();
            if (token != null) {
              options.headers['Authorization'] =
                  'Bearer ${ref.read(authNotifierProvider).token}';
            }
            options.headers['Accept-Language'] = _getCurrentLanguage();
            return handler.next(options);
          },
          onResponse: (response, handler) => handler.next(response),
          onError: (error, handler) => handler.next(error),
        ),
      );
  }

  String _getCurrentLanguage() {
    final locale = ref.read(appLocaleProvider).valueOrNull;
    return locale?.languageCode ??
        PlatformDispatcher.instance.locale.languageCode;
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(path, queryParameters: queryParams);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response> patch(String path, {dynamic data}) async {
    try {
      return await _dio.patch(path, data: data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response> delete(String path, {dynamic data = const {}}) async {
    try {
      return await _dio.delete(path, data: data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
