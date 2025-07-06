import 'dart:convert';

import 'package:dio/dio.dart';

class ApiException extends DioException {
  final String _customMessage;
  final int? statusCode;

  ApiException({
    required String message,
    this.statusCode,
    required super.requestOptions,
  }) : _customMessage = message;

  @override
  String get message => _customMessage;

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiException(
          message: "Connection timeout",
          statusCode: 408,
          requestOptions: error.requestOptions,
        );
      case DioExceptionType.badResponse:
        final response = error.response;
        if (response != null && response.data != null) {
          try {
            final data = response.data;
            if (data is String) {
              final decoded = jsonDecode(data);
              return ApiException(
                message:
                    _extractErrorMessage(decoded) ?? 'Bad response from server',
                statusCode: response.statusCode,
                requestOptions: error.requestOptions,
              );
            } else if (data is Map<String, dynamic>) {
              print('data: $data');
              print(_extractErrorMessage(data));
              return ApiException(
                message:
                    _extractErrorMessage(data) ?? 'Bad response from server',
                statusCode: response.statusCode,
                requestOptions: error.requestOptions,
              );
            }
          } catch (e) {
            return ApiException(
              message: "Failed to parse error response",
              statusCode: response.statusCode,
              requestOptions: error.requestOptions,
            );
          }
        }
        return ApiException(
          message:
              response?.data['message'] ??
              response?.statusMessage ??
              'Bad response from server',
          statusCode: response?.statusCode,
          requestOptions: error.requestOptions,
        );
      case DioExceptionType.cancel:
        return ApiException(
          message: "Request was cancelled",
          requestOptions: error.requestOptions,
        );
      default:
        return ApiException(
          message: "Unexpected error occurred",
          requestOptions: error.requestOptions,
        );
    }
  }

  @override
  String toString() {
    return 'ApiException: $message (statusCode: $statusCode)';
  }
}

String? _extractErrorMessage(Map<String, dynamic>? data) {
  if (data == null) return null;
  if (data['details'] is List) {
    final details = data['details'] as List;
    final messages = details
        .map((item) {
          // final field =
          //     item['field']?.toString().capitalize() ?? 'unknown field';
          final message = item['message'] ?? 'unknown error';
          return "$message";
        })
        .join('\n');
    return messages;
  }
  final buffer = StringBuffer();

  if (data['error'] != null) {
    buffer.writeln(data['error']);
  }

  if (data['warning']?.isNotEmpty == true) {
    buffer.writeln('${data['warning']}');
  }

  if (data['suggestions'] is List) {
    final suggestions = data['suggestions'] as List;
    for (var suggestion in suggestions) {
      buffer.writeln('• $suggestion');
    }
  }
  if (buffer.isNotEmpty) return buffer.toString().trim();

  return data['message'];
}
