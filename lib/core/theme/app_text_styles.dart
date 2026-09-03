import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';

// ============================================================
// APP TEXT STYLES
// ------------------------------------------------------------
// Font sizes use ScreenUtil (.sp) so text stays responsive.
//
// How to use:
//   Text('Dashboard', style: AppTextStyles.heading1)
// ============================================================

class AppTextStyles {
  AppTextStyles._();

  /// ScreenUtil can return 0 while Android viewport is still 0×0.
  /// TextField crashes if fontSize is not greater than 0.
  static double _sp(double size) {
    final scaled = size.sp;
    return scaled > 0 ? scaled : size;
  }

  // ----------------------------------------------------------
  // HEADINGS
  // ----------------------------------------------------------

  static TextStyle get heading1 => TextStyle(
        fontSize: _sp(28),
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get heading2 => TextStyle(
        fontSize: _sp(22),
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get heading3 => TextStyle(
        fontSize: _sp(18),
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  // ----------------------------------------------------------
  // BODY
  // ----------------------------------------------------------

  static TextStyle get bodyLarge => TextStyle(
        fontSize: _sp(16),
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get body => TextStyle(
        fontSize: _sp(14),
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: _sp(12),
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  // ----------------------------------------------------------
  // LABELS / BUTTONS
  // ----------------------------------------------------------

  static TextStyle get label => TextStyle(
        fontSize: _sp(12),
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
        letterSpacing: 0.2,
      );

  static TextStyle get button => TextStyle(
        fontSize: _sp(16),
        fontWeight: FontWeight.w600,
        color: AppColors.textOnPrimary,
        letterSpacing: 0.3,
      );

  static TextStyle get link => TextStyle(
        fontSize: _sp(14),
        fontWeight: FontWeight.w500,
        color: AppColors.info,
        decoration: TextDecoration.underline,
      );

  /// AppBar title (teal).
  static TextStyle get appBarTitle => TextStyle(
        fontSize: _sp(18),
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      );

  /// Profile / card name line.
  static TextStyle get name => TextStyle(
        fontSize: _sp(16),
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: 0.2,
      );

  /// Chip / tag text (primary color).
  static TextStyle get chipPrimary => TextStyle(
        fontSize: _sp(12),
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      );

  /// Chip / tag text (muted).
  static TextStyle get chipMuted => TextStyle(
        fontSize: _sp(12),
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );
}
