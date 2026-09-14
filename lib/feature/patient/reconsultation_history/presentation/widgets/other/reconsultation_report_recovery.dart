import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// RECONSULTATION REPORT RECOVERY
// ------------------------------------------------------------
// Large score (e.g. 2/10) + teal linear progress bar.
// ============================================================

class ReconsultationReportRecovery extends StatelessWidget {
  const ReconsultationReportRecovery({
    super.key,
    required this.score,
    required this.maxScore,
  });

  final int score;
  final int maxScore;

  @override
  Widget build(BuildContext context) {
    final safeMax = maxScore <= 0 ? 10 : maxScore;
    final progress = (score / safeMax).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$score / $safeMax',
          style: AppTextStyles.heading1.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 10.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(99.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8.h,
            backgroundColor: AppColors.primaryLight,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
