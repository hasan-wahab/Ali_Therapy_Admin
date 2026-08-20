import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';

// ============================================================
// APP TOP LINEAR LOADING (shared)
// ------------------------------------------------------------
// Thin teal line under AppBar / top of body during API calls.
// List stays visible — no full-screen blocking loader.
// ============================================================

class AppTopLinearLoading extends StatelessWidget {
  const AppTopLinearLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      minHeight: 2.h,
      color: AppColors.primary,
      backgroundColor: AppColors.primaryLight,
    );
  }
}
