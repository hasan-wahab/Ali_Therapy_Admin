import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/survey_samples.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/survey_visit_card.dart';

// ============================================================
// PATIENT DETAIL SURVEY SECTION
// ------------------------------------------------------------
// Visit feedback surveys under the Survey tab.
// ============================================================

class PatientDetailSurveySection extends StatelessWidget {
  const PatientDetailSurveySection({super.key});

  @override
  Widget build(BuildContext context) {
    final surveys = SurveySamples.all;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Survey Results',
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          '${surveys.length} visit feedbacks',
          style: AppTextStyles.label.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        for (var i = 0; i < surveys.length; i++) ...[
          SurveyVisitCard(data: surveys[i], initiallyExpanded: i == 0),
          if (i < surveys.length - 1) SizedBox(height: 14.h),
        ],
      ],
    );
  }
}
