import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PACKAGE ATTENDANCE PROGRESS BLOCK
// ------------------------------------------------------------
// Active package name + progress bar + attended count.
// ============================================================

class PackageAttendanceProgressBlock extends StatelessWidget {
  const PackageAttendanceProgressBlock({
    super.key,
    required this.packageName,
    required this.attended,
    required this.totalSessions,
  });

  final String packageName;
  final int attended;
  final int totalSessions;

  @override
  Widget build(BuildContext context) {
    final progress = totalSessions == 0 ? 0.0 : attended / totalSessions;
    final percent = (progress * 100).round();

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
            'Active Package Progress',
            style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4.h),
          Text(
            packageName,
            style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 6.h,
                    backgroundColor: AppColors.border,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '$percent%',
                style: AppTextStyles.label.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            '$attended of $totalSessions sessions attended',
            style: AppTextStyles.label.copyWith(color: AppColors.success),
          ),
        ],
      ),
    );
  }
}
