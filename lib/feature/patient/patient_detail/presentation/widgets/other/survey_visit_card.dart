import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/survey_question_card.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/survey_visit_header.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';

// ============================================================
// SURVEY VISIT CARD
// ------------------------------------------------------------
// One visit feedback: header + stacked question cards.
// ============================================================

class SurveyVisitData {
  const SurveyVisitData({
    required this.visitTitle,
    required this.visitDate,
    required this.therapist,
    required this.submittedAt,
    required this.questions,
  });

  final String visitTitle;
  final String visitDate;
  final String therapist;
  final String submittedAt;
  final List<SurveyQuestionData> questions;
}

class SurveyVisitCard extends StatelessWidget {
  const SurveyVisitCard({
    super.key,
    required this.data,
    this.initiallyExpanded = false,
  });

  final SurveyVisitData data;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return AppExpandableCard(
      initiallyExpanded: initiallyExpanded,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 12.h),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SurveyVisitHeader(
            visitTitle: data.visitTitle,
            visitDate: data.visitDate,
            therapist: data.therapist,
            submittedAt: data.submittedAt,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < data.questions.length; i++) ...[
                  SurveyQuestionCard(data: data.questions[i]),
                  if (i < data.questions.length - 1) SizedBox(height: 8.h),
                ],
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
