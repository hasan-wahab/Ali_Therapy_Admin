import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_section_title.dart';

// ============================================================
// PATIENT SESSIONS BLOCK
// ------------------------------------------------------------
// Labeled sessions progress for patient card.
// ============================================================

class PatientSessionsBlock extends StatelessWidget {
  const PatientSessionsBlock({
    super.key,
    required this.remainingSessions,
    this.totalSessions = 0,
  });

  final int remainingSessions;
  final int totalSessions;

  int get _used {
    if (totalSessions <= 0) return 0;
    return (totalSessions - remainingSessions).clamp(0, totalSessions);
  }

  double get _progress {
    if (totalSessions <= 0) return 0;
    return (remainingSessions / totalSessions).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.softGray,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PatientSectionTitle(title: 'Remaining Sessions'),
          SizedBox(height: 8.h),
          Text(
            totalSessions > 0
                ? '$remainingSessions / $totalSessions'
                : '$remainingSessions',
            style: AppTextStyles.name.copyWith(color: AppColors.primary),
          ),
          SizedBox(height: 2.h),
          Text(
            totalSessions > 0 ? 'sessions left' : 'sessions',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 6.h,
              backgroundColor: AppColors.border,
              color: AppColors.primary,
            ),
          ),
          if (totalSessions > 0) ...[
            SizedBox(height: 6.h),
            Text(
              'Used: $_used of $totalSessions',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
