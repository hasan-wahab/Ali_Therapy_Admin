import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_day_block.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_visit_samples.dart';

// ============================================================
// PATIENT DETAIL PROGRESS SECTION
// ------------------------------------------------------------
// Mobile Patient Progress Timeline under the Progress tab.
// ============================================================

class PatientDetailProgressSection extends StatelessWidget {
  const PatientDetailProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final visits = ProgressVisitSamples.all;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Patient Progress Timeline',
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          '${visits.length} visits recorded',
          style: AppTextStyles.label.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        for (var i = 0; i < visits.length; i++) ...[
          ProgressDayBlock(
            visitTitle: visits[i].visitTitle,
            dateTime: visits[i].dateTime,
            visitType: visits[i].visitType,
            status: visits[i].status,
            events: visits[i].events,
          ),
          if (i < visits.length - 1) SizedBox(height: 14.h),
        ],
      ],
    );
  }
}
