import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// THERAPIST REPORT TYPE BADGE
// ------------------------------------------------------------
// Therapy Session / Consultation / Reconsultation chip.
// ============================================================

class TherapistReportTypeBadge extends StatelessWidget {
  const TherapistReportTypeBadge({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final lower = text.toLowerCase();
    final isCompleted = lower == 'completed';
    final isPending = lower == 'pending';
    final isTherapistStage = lower == 'therapist';
    final isTherapySession = lower.contains('therapy');

    final Color bg;
    final Color fg;
    if (isCompleted) {
      bg = AppColors.successSoft;
      fg = AppColors.success;
    } else if (isPending || isTherapistStage) {
      bg = AppColors.warningSoft;
      fg = AppColors.warning;
    } else if (isTherapySession) {
      bg = AppColors.infoSoft;
      fg = AppColors.info;
    } else {
      bg = AppColors.infoSoft;
      fg = AppColors.info;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        text,
        style: AppTextStyles.label.copyWith(
          color: fg,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
