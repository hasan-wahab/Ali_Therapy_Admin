import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PROGRESS STATUS CHIP
// ------------------------------------------------------------
// Small Completed / In Progress badge on timeline cards.
// ============================================================

enum ProgressEventStatus {
  completed,
  inProgress,
}

class ProgressStatusChip extends StatelessWidget {
  const ProgressStatusChip({
    super.key,
    required this.status,
  });

  final ProgressEventStatus status;

  @override
  Widget build(BuildContext context) {
    final isDone = status == ProgressEventStatus.completed;
    final color = isDone ? AppColors.success : AppColors.info;
    final bg = isDone ? AppColors.successSoft : AppColors.infoSoft;
    final label = isDone ? 'Completed' : 'In Progress';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: AppTextStyles.label.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
