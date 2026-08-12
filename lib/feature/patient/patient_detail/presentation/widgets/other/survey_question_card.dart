import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/survey_choice_group.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/survey_star_rating.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/survey_text_answer.dart';

// ============================================================
// SURVEY QUESTION CARD
// ------------------------------------------------------------
// One Q&A block: choice, stars, or text answer.
// ============================================================

enum SurveyAnswerKind {
  choice,
  stars,
  text,
}

class SurveyQuestionData {
  const SurveyQuestionData.choice({
    required this.question,
    required this.options,
    required this.selected,
  })  : kind = SurveyAnswerKind.choice,
        rating = null,
        textAnswer = null;

  const SurveyQuestionData.stars({
    required this.question,
    required this.rating,
  })  : kind = SurveyAnswerKind.stars,
        options = const [],
        selected = null,
        textAnswer = null;

  const SurveyQuestionData.text({
    required this.question,
    required this.textAnswer,
  })  : kind = SurveyAnswerKind.text,
        options = const [],
        selected = null,
        rating = null;

  final String question;
  final SurveyAnswerKind kind;
  final List<String> options;
  final String? selected;
  final int? rating;
  final String? textAnswer;
}

class SurveyQuestionCard extends StatelessWidget {
  const SurveyQuestionCard({
    super.key,
    required this.data,
  });

  final SurveyQuestionData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            data.question,
            textAlign: TextAlign.left,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Answer:',
            style: AppTextStyles.label.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          switch (data.kind) {
            SurveyAnswerKind.choice => SurveyChoiceGroup(
                options: data.options,
                selected: data.selected ?? '',
              ),
            SurveyAnswerKind.stars => SurveyStarRating(
                rating: data.rating ?? 0,
              ),
            SurveyAnswerKind.text => SurveyTextAnswer(
                text: data.textAnswer ?? '',
              ),
          },
        ],
      ),
    );
  }
}
