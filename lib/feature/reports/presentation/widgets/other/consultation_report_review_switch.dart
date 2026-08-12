import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// CONSULTATION REPORT REVIEW LABEL
// ------------------------------------------------------------
// Shows Review: Yes / No (text only, no switch).
// ============================================================

class ConsultationReportReviewSwitch extends StatelessWidget {
  const ConsultationReportReviewSwitch({
    super.key,
    this.value = false,
  });

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Review: ',
        style: AppTextStyles.label.copyWith(color: AppColors.textMuted),
        children: [
          TextSpan(
            text: value ? 'Yes' : 'No',
            style: AppTextStyles.label.copyWith(
              color: value ? AppColors.primary : AppColors.info,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
