import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// RECONSULTATION HISTORY VIEW BUTTON
// ------------------------------------------------------------
// Teal "View Report" pill used on mobile cards and tablet rows.
// ============================================================

class ReconsultationHistoryViewButton extends StatelessWidget {
  const ReconsultationHistoryViewButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.visibility_outlined,
                size: AppSizes.iconSm,
                color: AppColors.textOnPrimary,
              ),
              SizedBox(width: 6.w),
              Text(
                'View Report',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
