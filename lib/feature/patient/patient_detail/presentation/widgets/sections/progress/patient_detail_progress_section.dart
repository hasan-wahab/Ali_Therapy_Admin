import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/entities/patient_detail_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_display.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_progress_mapper.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_day_block.dart';

// ============================================================
// PATIENT DETAIL PROGRESS SECTION
// ------------------------------------------------------------
// Timeline from Full View patient_progress[].
// ============================================================

class PatientDetailProgressSection extends StatelessWidget {
  const PatientDetailProgressSection({
    super.key,
    required this.detail,
  });

  final PatientDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    final visits = detail.progress;

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
          visits.length == 1
              ? '1 visit recorded'
              : '${visits.length} visits recorded',
          style: AppTextStyles.label.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        for (var i = 0; i < visits.length; i++) ...[
          ProgressDayBlock(
            visitTitle: PatientDetailProgressMapper.visitTitle(visits[i]),
            dateTime: PatientDetailDisplay.dateTime(visits[i].dateTime),
            visitType: PatientDetailDisplay.text(visits[i].visitType),
            status: PatientDetailProgressMapper.status(visits[i].status),
            events: visits[i].events
                .map(PatientDetailProgressMapper.event)
                .toList(),
            detail: detail,
          ),
          if (i < visits.length - 1) SizedBox(height: 14.h),
        ],
      ],
    );
  }
}
