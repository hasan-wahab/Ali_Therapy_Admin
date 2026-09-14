import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// RECONSULTATION REPORT ANSWER CHIP
// ------------------------------------------------------------
// Teal Yes / No pill on feedback rows.
// ============================================================

class ReconsultationReportAnswerChip extends StatelessWidget {
  const ReconsultationReportAnswerChip({
    super.key,
    required this.answer,
  });

  final String answer;

  @override
  Widget build(BuildContext context) {
    final isYes = answer.trim().toLowerCase() == 'yes';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: isYes ? AppColors.primary : AppColors.primaryLight,
        borderRadius: BorderRadius.circular(20.r),
        border: isYes ? null : Border.all(color: AppColors.primary),
      ),
      child: Text(
        answer,
        style: AppTextStyles.bodySmall.copyWith(
          color: isYes ? AppColors.textOnPrimary : AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
