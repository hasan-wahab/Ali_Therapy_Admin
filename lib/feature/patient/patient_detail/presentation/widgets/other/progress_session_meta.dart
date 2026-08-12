import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_session_stat_box.dart';

// ============================================================
// PROGRESS SESSION META
// ------------------------------------------------------------
// Package line + Start / End / Duration stats grid.
// ============================================================

class ProgressSessionMeta extends StatelessWidget {
  const ProgressSessionMeta({
    super.key,
    required this.packageLine,
    required this.startTime,
    required this.endTime,
    required this.duration,
  });

  final String packageLine;
  final String startTime;
  final String endTime;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            packageLine,
            textAlign: TextAlign.left,
            style: AppTextStyles.label.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Expanded(
              child: ProgressSessionStatBox(label: 'Start', value: startTime),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: ProgressSessionStatBox(label: 'End', value: endTime),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: ProgressSessionStatBox(label: 'Duration', value: duration),
            ),
          ],
        ),
      ],
    );
  }
}
