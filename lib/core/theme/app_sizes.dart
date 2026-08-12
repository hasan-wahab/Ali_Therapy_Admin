import 'package:flutter_screenutil/flutter_screenutil.dart';

// ============================================================
// APP SIZES
// ------------------------------------------------------------
// Fixed icon / UI sizes (via ScreenUtil).
// Use these instead of writing 22.sp / 24.sp in every widget.
//
//   Icon(..., size: AppSizes.iconMd)
// ============================================================

class AppSizes {
  AppSizes._();

  /// Small icons (chips, dense rows).
  static double get iconSm => 20.sp;

  /// Default icons (menu rows, list tiles).
  static double get iconMd => 22.sp;

  /// AppBar / leading / actions.
  static double get iconLg => 24.sp;

  /// Large icons (avatars, empty states).
  static double get iconXl => 30.sp;
}
