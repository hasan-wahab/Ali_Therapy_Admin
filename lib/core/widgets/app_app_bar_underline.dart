import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';

// ============================================================
// APP APP BAR UNDERLINE
// ------------------------------------------------------------
// Thin line under every app bar.
// Default: rainbow gradient.
// Loading: solid teal linear progress.
// ============================================================

class AppAppBarUnderline {
  AppAppBarUnderline._();

  static double get height => 1.5.h;

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

  /// Rainbow line (default, no loading).
  static PreferredSizeWidget get bar => _AppBarUnderlineWidget(isLoading: false);

  /// Loading line (teal linear progress replaces rainbow).
  static PreferredSizeWidget get loadingBar =>
      _AppBarUnderlineWidget(isLoading: true);

  /// Choose between rainbow and loading bar.
  static PreferredSizeWidget forState({required bool isLoading}) =>
      _AppBarUnderlineWidget(isLoading: isLoading);
}

class _AppBarUnderlineWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const _AppBarUnderlineWidget({required this.isLoading});

  final bool isLoading;

  @override
  Size get preferredSize => Size.fromHeight(AppAppBarUnderline.height);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: AppAppBarUnderline.height,
        child: LinearProgressIndicator(
          minHeight: AppAppBarUnderline.height,
          color: AppColors.primary,
          backgroundColor: AppColors.primaryLight,
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: AppAppBarUnderline.height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: AppAppBarUnderline._rainbow,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.18),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
