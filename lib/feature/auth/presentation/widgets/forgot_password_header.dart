import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// FORGOT PASSWORD HEADER
// ------------------------------------------------------------
// Icon + title + short help text.
// ============================================================

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 84.w,
          height: 84.w,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_reset_rounded,
            size: AppSizes.iconXl,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 18.h),
        Text(
          'Forgot Password?',
          textAlign: TextAlign.center,
          style: AppTextStyles.heading2,
        ),
        SizedBox(height: 8.h),
        Text(
          'Enter your registered email and we will send you a reset link.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
