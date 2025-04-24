import 'package:dio/dio.dart';
import 'package:hui_application/core/config/app_config.dart';

class ApiClient {
  static final Dio dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl, // 👈 thay URL của bạn ở đây
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    )
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // TODO: Gắn token nếu cần
          // options.headers['Authorization'] = 'Bearer your_token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          return handler.next(error);
        },
      ),
    );

  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    return await dio.get(path, queryParameters: queryParams);
  }

  static Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }

  static Future<Response> put(String path, {dynamic data}) async {
    return await dio.put(path, data: data);
  }

  static Future<Response> pathch(String path, {dynamic data}) async {
    return await dio.patch(path, data: data);
  }

  static Future<Response> delete(String path) async {
    return await dio.delete(path);
  }
}

// Cách dùng:
// final res = await ApiClient.post('/login', data: { 'email': ..., 'password': ... });
