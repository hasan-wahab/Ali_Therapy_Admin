import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// APP SEE MORE TOGGLE
// ------------------------------------------------------------
// Soft footer control inside expandable cards (not a loud bar).
// ============================================================

class AppSeeMoreToggle extends StatelessWidget {
  const AppSeeMoreToggle({
    super.key,
    required this.expanded,
    required this.onTap,
  });

  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryLight,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.primary.withValues(alpha: 0.08),
        highlightColor: AppColors.primary.withValues(alpha: 0.04),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7.h),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.18),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                expanded ? 'See less' : 'See all',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 2.w),
              Icon(
                expanded
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: AppSizes.iconSm,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
