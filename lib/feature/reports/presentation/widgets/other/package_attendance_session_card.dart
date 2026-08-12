import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_session_info_row.dart';

// ============================================================
// PACKAGE ATTENDANCE SESSION CARD
// ------------------------------------------------------------
// One attended session in the timeline.
// ============================================================

class PackageAttendanceSessionCard extends StatelessWidget {
  const PackageAttendanceSessionCard({
    super.key,
    required this.sessionNumber,
    required this.date,
    required this.therapist,
    required this.clinic,
    required this.timeDuration,
    this.notes,
  });

  final int sessionNumber;
  final String date;
  final String therapist;
  final String clinic;
  final String timeDuration;
  final String? notes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.successSoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: AppSizes.iconSm,
                  color: AppColors.success,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'Session #$sessionNumber',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.softGray,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: AppSizes.iconSm,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      timeDuration,
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(height: 1.h, color: AppColors.divider),
          SizedBox(height: 10.h),
          PackageAttendanceSessionInfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Date',
            text: date,
          ),
          PackageAttendanceSessionInfoRow(
            icon: Icons.handshake_outlined,
            label: 'Therapist',
            text: therapist,
          ),
          PackageAttendanceSessionInfoRow(
            icon: Icons.local_hospital_outlined,
            label: 'Clinic',
            text: clinic,
          ),
          if (notes != null && notes!.trim().isNotEmpty) ...[
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.infoSoft,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notes',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.info,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    notes!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
