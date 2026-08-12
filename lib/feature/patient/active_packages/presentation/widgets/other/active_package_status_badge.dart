import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// ACTIVE PACKAGE STATUS BADGE
// ------------------------------------------------------------
// Teal "Active" (or other) status pill.
// ============================================================

class ActivePackageStatusBadge extends StatelessWidget {
  const ActivePackageStatusBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final bool isActive = status.toLowerCase() == 'active';
    final Color bg = isActive ? AppColors.primary : AppColors.softGray;
    final Color fg = isActive ? AppColors.textOnPrimary : AppColors.textSecondary;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status,
        style: AppTextStyles.bodySmall.copyWith(
          color: fg,
          fontWeight: FontWeight.w700,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
