class AppConstants {
  static const String appName = 'CoreDesk';
  static const String appVersion = '1.0.0';

  static const String apiBaseUrl = 'https://api.example.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int apiRetries = 3;

  static const String keyToken = 'auth_token';
  static const String keyUser = 'user_data';
  static const String keyIsLoggedIn = 'is_logged_in';

  static const String emptyString = '';
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;

  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };
}


