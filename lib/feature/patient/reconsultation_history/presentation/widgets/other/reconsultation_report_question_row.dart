import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_report_answer_chip.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_report_sample.dart';

// ============================================================
// RECONSULTATION REPORT QUESTION ROW
// ------------------------------------------------------------
// Numbered feedback question + Yes/No chip.
// ============================================================

class ReconsultationReportQuestionRow extends StatelessWidget {
  const ReconsultationReportQuestionRow({
    super.key,
    required this.item,
  });

  final ReconsultationReportQuestion item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              '${item.number}. ${item.question}',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          ReconsultationReportAnswerChip(answer: item.answer),
        ],
      ),
    );
  }
}
