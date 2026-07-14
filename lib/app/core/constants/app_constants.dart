class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'EduSkill';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyIsFirstLaunch = 'is_first_launch';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserToken = 'user_token';
  static const String keyUserId = 'user_id';

  // API Endpoints (placeholder)
  static const String baseUrl = 'https://api.eduskill.com';

  // Animation Durations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration splashDuration = Duration(seconds: 2);

  // Padding & Margins
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
}
