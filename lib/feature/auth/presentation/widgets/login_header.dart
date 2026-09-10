import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_constants.dart';

// ============================================================
// LOGIN HEADER
// ------------------------------------------------------------
// Logo + welcome title for the login screen.
// ============================================================

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 96.w,
          height: 96.w,
          child: Image.asset(
            AppConstants.appLogo,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'Welcome Admin',
          textAlign: TextAlign.center,
          style: AppTextStyles.heading2,
        ),
        SizedBox(height: 6.h),
        Text(
          'Sign in to manage Ali Therapy',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
