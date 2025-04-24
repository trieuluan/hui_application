class AppConfig {
  static const String environment = String.fromEnvironment('ENV', defaultValue: 'development');

  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';
  static bool get isStaging => environment == 'staging';

  static String get baseUrl {
    switch (environment) {
      case 'production':
        return 'https://api.example.com';
      case 'staging':
        return 'https://api.staging.example.com';
      default:
        return 'http://localhost:3000';
    }
  }
}
