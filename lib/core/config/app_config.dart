import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class AppConfig {
  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'development',
  );

  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';
  static bool get isStaging => environment == 'staging';

  static String get baseUrl {
    if (isProduction) return 'https://hui-api.fly.dev';
    if (isStaging) return 'https://hui-api.fly.dev';

    // Handle local baseUrl based on platform
    if (kIsWeb) {
      return 'http://localhost:3000'; // Flutter Web chạy local
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000'; // Android Emulator
    } else {
      return 'http://localhost:3000'; // iOS Simulator & Desktop
    }
  }
}
