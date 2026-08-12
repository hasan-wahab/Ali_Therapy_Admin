import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_session_badge.dart';

// ============================================================
// CONSULTATION REPORT SESSIONS BLOCK
// ------------------------------------------------------------
// Session progress + Remaining / Suggested badges.
// ============================================================

class ConsultationReportSessionsBlock extends StatelessWidget {
  const ConsultationReportSessionsBlock({
    super.key,
    required this.completed,
    required this.total,
    required this.remaining,
    required this.suggested,
  });

  final int completed;
  final int total;
  final int remaining;
  final int suggested;

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : completed / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Remaining Sessions',
          style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 4.h),
        Text(
          '$completed / $total',
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 4.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 4.h,
            backgroundColor: AppColors.border,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 4.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 4.h,
          children: [
            ConsultationReportSessionBadge(
              label: 'Remaining $remaining',
              bg: AppColors.infoSoft,
              fg: AppColors.info,
            ),
            ConsultationReportSessionBadge(
              label: 'Suggested $suggested',
              bg: AppColors.warningSoft,
              fg: AppColors.warning,
            ),
          ],
        ),
      ],
    );
  }
}
