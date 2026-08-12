import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// ACTIVE PACKAGE PROGRESS
// ------------------------------------------------------------
// Sessions progress bar with completed/total label.
// ============================================================

class ActivePackageProgress extends StatelessWidget {
  const ActivePackageProgress({
    super.key,
    required this.completedSessions,
    required this.totalSessions,
  });

  final int completedSessions;
  final int totalSessions;

  double get _progress {
    if (totalSessions <= 0) return 0;
    return (completedSessions / totalSessions).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sessions Progress',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMuted,
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 8.h,
                  backgroundColor: AppColors.softGray,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              '$completedSessions/$totalSessions',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
