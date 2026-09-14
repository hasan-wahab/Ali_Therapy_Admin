import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// RECONSULTATION HISTORY SCORE
// ------------------------------------------------------------
// Recovery percent + teal linear progress bar.
// ============================================================

class ReconsultationHistoryScore extends StatelessWidget {
  const ReconsultationHistoryScore({
    super.key,
    required this.score,
    this.showLabel = false,
  });

  final String score;
  final bool showLabel;

  double get _progress {
    final raw = score.replaceAll('%', '').trim();
    final value = double.tryParse(raw) ?? 0;
    return (value / 100).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            'Recovery Score',
            style: AppTextStyles.label.copyWith(
              color: AppColors.textMuted,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 4.h),
        ],
        Text(
          score.trim().isEmpty ? '_' : score,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(99.r),
          child: LinearProgressIndicator(
            value: _progress,
            minHeight: 6.h,
            backgroundColor: AppColors.primaryLight,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
