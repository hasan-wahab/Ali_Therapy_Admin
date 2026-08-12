import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_status_chip.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_visit_type_chip.dart';

// ============================================================
// PROGRESS DAY HEADER
// ------------------------------------------------------------
// Visit title band with date + type / status chips.
// ============================================================

class ProgressDayHeader extends StatelessWidget {
  const ProgressDayHeader({
    super.key,
    required this.visitTitle,
    required this.dateTime,
    required this.visitType,
    this.status = ProgressEventStatus.completed,
  });

  final String visitTitle;
  final String dateTime;
  final String visitType;
  final ProgressEventStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.12),
            AppColors.primaryLight,
          ],
        ),
        border: Border(
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  visitTitle,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: AppSizes.iconSm - 4.sp,
                      color: AppColors.textMuted,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        dateTime,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ProgressVisitTypeChip(label: visitType),
              SizedBox(height: 4.h),
              ProgressStatusChip(status: status),
            ],
          ),
        ],
      ),
    );
  }
}
