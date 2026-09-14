import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_report_sample.dart';

// ============================================================
// RECONSULTATION REPORT ASSESSMENT ITEM
// ------------------------------------------------------------
// Numbered internal assessment label + value.
// ============================================================

class ReconsultationReportAssessmentItem extends StatelessWidget {
  const ReconsultationReportAssessmentItem({
    super.key,
    required this.item,
  });

  final ReconsultationReportAssessment item;

  @override
  Widget build(BuildContext context) {
    final value = item.value.trim().isEmpty ? '_' : item.value;

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${item.number}. ${item.label}'.toUpperCase(),
            style: AppTextStyles.label.copyWith(
              color: AppColors.textMuted,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              color: value == '_' || value == 'N/A'
                  ? AppColors.textMuted
                  : AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
