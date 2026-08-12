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
  // UI DEFAULTS
  // Design size used by flutter_screenutil in main.dart later.
  // ----------------------------------------------------------
  static const double designWidth = 390;
  static const double designHeight = 844;

  // ----------------------------------------------------------
  // PAGINATION DEFAULTS
  // ----------------------------------------------------------
  static const int defaultPageSize = 20;
}
