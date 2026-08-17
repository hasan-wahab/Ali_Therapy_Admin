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

  /// App logo path (use with Image.asset).
  static const String appLogo = 'assets/images/dr_ali_icon.png';

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
}
