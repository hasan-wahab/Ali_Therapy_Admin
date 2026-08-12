import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_field.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_list_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';

// ============================================================
// CONSULTANT MUSCLE CARD
// ------------------------------------------------------------
// One muscle block — clear stacked subsections.
// ============================================================

class ConsultantMuscleCard extends StatelessWidget {
  const ConsultantMuscleCard({
    super.key,
    required this.muscle,
    required this.conditions,
    required this.manualTreatments,
    required this.otherTreatment,
    required this.prescribedExercises,
    required this.defaultExercises,
    this.initiallyExpanded = false,
  });

  final String muscle;
  final List<String> conditions;
  final List<String> manualTreatments;
  final String otherTreatment;
  final List<String> prescribedExercises;
  final List<String> defaultExercises;

  final bool initiallyExpanded;
  @override
  Widget build(BuildContext context) {
    return AppExpandableCard(
      initiallyExpanded: initiallyExpanded,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            color: AppColors.softGray,
            child: Text(
              muscle,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConsultantListField(
                  label: 'Condition / Status',
                  values: conditions,
                ),
                ConsultantListField(
                  label: 'Manual Treatment',
                  values: manualTreatments,
                ),
                ConsultantField(
                  label: 'Other Treatment',
                  value: otherTreatment,
                ),
                ConsultantListField(
                  label: 'Prescribed Exercises',
                  values: prescribedExercises,
                ),
                ConsultantListField(
                  label: 'By Default Exercises',
                  values: defaultExercises,
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
