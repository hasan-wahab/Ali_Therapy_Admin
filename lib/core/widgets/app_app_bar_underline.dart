import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';

// ============================================================
// APP APP BAR UNDERLINE
// ------------------------------------------------------------
// Thin rainbow gradient line under every app bar.
// ============================================================

class AppAppBarUnderline {
  AppAppBarUnderline._();

  static double get height => 1.h;

  /// Extra height to add on top of [kToolbarHeight].
  static double get preferredExtra => height;

  /// Classic rainbow (ROYGBIV).
  static const List<Color> _rainbow = [
    Color(0xFFE53935), // red
    Color(0xFFFB8C00), // orange
    Color(0xFFFDD835), // yellow
    Color(0xFF43A047), // green
    Color(0xFF1E88E5), // blue
    Color(0xFF3949AB), // indigo
    Color(0xFF8E24AA), // violet
  ];

  static PreferredSizeWidget get bar {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: _rainbow,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.18),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
