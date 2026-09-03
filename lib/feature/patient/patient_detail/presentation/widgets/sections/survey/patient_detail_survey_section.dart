import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/entities/patient_detail_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_survey_mapper.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/survey_visit_card.dart';

// ============================================================
// PATIENT DETAIL SURVEY SECTION
// ------------------------------------------------------------
// Visit feedback from Full View surveys[].
// ============================================================

class PatientDetailSurveySection extends StatelessWidget {
  const PatientDetailSurveySection({
    super.key,
    required this.detail,
  });

  final PatientDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    final surveys = detail.surveys;

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
          surveys.length == 1
              ? '1 visit feedback'
              : '${surveys.length} visit feedbacks',
          style: AppTextStyles.label.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        for (var i = 0; i < surveys.length; i++) ...[
          SurveyVisitCard(
            data: PatientDetailSurveyMapper.visit(surveys[i]),
            initiallyExpanded: i == 0,
          ),
          if (i < surveys.length - 1) SizedBox(height: 14.h),
        ],
      ],
    );
  }
}
