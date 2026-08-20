import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_progress_block.dart';

// ============================================================
// PACKAGE ATTENDANCE CARD
// ------------------------------------------------------------
// One patient package attendance row (mobile).
// ============================================================

class PackageAttendanceCard extends StatelessWidget {
  const PackageAttendanceCard({
    super.key,
    required this.patientId,
    required this.patientName,
    required this.mrNo,
    required this.gender,
    required this.phone,
    required this.hasNfc,
    required this.packagesTaken,
    required this.activePackageName,
    required this.attended,
    required this.totalSessions,
    this.initiallyExpanded = false,
  });

  final String patientId;

  final String patientName;
  final String mrNo;
  final String gender;
  final String phone;
  final bool hasNfc;
  final int packagesTaken;
  final String activePackageName;
  final int attended;
  final int totalSessions;
  final bool initiallyExpanded;

  String get _initial {
    final trimmed = patientName.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return AppExpandableCard(
      initiallyExpanded: initiallyExpanded,
      collapsedHeight: 180.h,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    _initial,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(patientName, style: AppTextStyles.name),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.badge_outlined,
                            size: AppSizes.iconSm,
                            color: AppColors.success,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              'MR: $mrNo · $gender',
                              style: AppTextStyles.label.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: AppSizes.iconSm,
                            color: AppColors.success,
                          ),
                          SizedBox(width: 4.w),
                          Text(phone, style: AppTextStyles.label),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.infoSoft,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    hasNfc ? 'NFC: Yes' : 'NFC: No',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.info,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.work_outline_rounded,
                      size: AppSizes.iconSm,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '$packagesTaken Package(s)',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            PackageAttendanceProgressBlock(
              packageName: activePackageName,
              attended: attended,
              totalSessions: totalSessions,
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 40.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  AppNavigation.openPackageAttendanceDetail(
                    context,
                    patientId: patientId,
                    patientName: patientName,
                    mrNo: mrNo,
                    phone: phone,
                  );
                },
                icon: Icon(
                  Icons.folder_open_outlined,
                  size: AppSizes.iconSm,
                  color: AppColors.textOnPrimary,
                ),
                label: Text(
                  'View Packages & Attendance',
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.info,
                  foregroundColor: AppColors.textOnPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
