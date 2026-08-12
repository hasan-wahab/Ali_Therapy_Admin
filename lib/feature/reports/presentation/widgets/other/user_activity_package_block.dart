import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// USER ACTIVITY PACKAGE BLOCK
// ------------------------------------------------------------
// Package name + sessions used progress + remaining.
// ============================================================

class UserActivityPackageBlock extends StatelessWidget {
  const UserActivityPackageBlock({
    super.key,
    required this.packageName,
    required this.sessionsUsed,
    required this.sessionsTotal,
    required this.remaining,
  });

  final String packageName;
  final int sessionsUsed;
  final int sessionsTotal;
  final int remaining;

  @override
  Widget build(BuildContext context) {
    final progress = sessionsTotal == 0 ? 0.0 : sessionsUsed / sessionsTotal;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.softGray,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Package Detail',
            style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4.h),
          Text(
            packageName,
            style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6.h),
          Text(
            'Sessions used $sessionsUsed/$sessionsTotal',
            style: AppTextStyles.label.copyWith(color: AppColors.textMuted),
          ),
          SizedBox(height: 4.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 5.h,
              backgroundColor: AppColors.border,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Text(
                'Remaining',
                style: AppTextStyles.label.copyWith(color: AppColors.textMuted),
              ),
              const Spacer(),
              Text(
                '$remaining',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
