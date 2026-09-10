// ============================================================
// APP CONSTANTS
// ------------------------------------------------------------
// Values used across the whole app (names, sizes, keys…).
// Prefer constants instead of "magic numbers" in widgets.
// ============================================================

class AppConstants {
  AppConstants._(); // no instances needed

  // ----------------------------------------------------------
  // APP INFO
  // ----------------------------------------------------------
  static const String appName = 'Ali Therapy Admin';

  /// In-app clinic logo (red splash mark, transparent background).
  static const String appLogo = 'assets/images/app_logo.png';

  /// Native splash — Figma 651:2 center clinic logo.
  static const String nativeSplashLogo =
      'assets/images/native_splash_logo.png';

  /// Native splash — Figma 651:2 bottom Neon Web branding.
  static const String nativeSplashBranding =
      'assets/images/native_splash_branding.png';

  // ----------------------------------------------------------
  // UI DEFAULTS — ScreenUtil design sizes
  // Phone stays locked. Tablet uses iPad Pro 11" frame.
  // ----------------------------------------------------------
  static const double designWidth = 390;
  static const double designHeight = 844;

  /// iPad Pro 11" portrait (Figma tablet base).
  static const double tabletDesignWidth = 834;
  static const double tabletDesignHeight = 1194;

  /// iPad Pro 11" landscape.
  static const double tabletLandscapeDesignWidth = 1194;
  static const double tabletLandscapeDesignHeight = 834;

  // ----------------------------------------------------------
  // PAGINATION DEFAULTS
  // ----------------------------------------------------------
  static const int defaultPageSize = 20;

  // ----------------------------------------------------------
  // BLOOD GROUPS (shared — dropdowns)
  // ----------------------------------------------------------
  static const List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
}
