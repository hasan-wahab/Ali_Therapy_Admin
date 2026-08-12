import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_detail_header.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_purchased_package_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_session_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_summary_chip.dart';

// ============================================================
// PACKAGE ATTENDANCE DETAIL PAGE
// ------------------------------------------------------------
// Patient packages + attendance timeline (mobile).
// ============================================================

class PackageAttendanceDetailPage extends StatefulWidget {
  const PackageAttendanceDetailPage({
    super.key,
    required this.patientName,
    required this.mrNo,
    required this.phone,
  });

  final String patientName;
  final String mrNo;
  final String phone;

  @override
  State<PackageAttendanceDetailPage> createState() =>
      _PackageAttendanceDetailPageState();
}

class _PackageAttendanceDetailPageState
    extends State<PackageAttendanceDetailPage> {
  int _selectedPackageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Package Attendance'),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          children: [
            PackageAttendanceDetailHeader(
              patientName: widget.patientName,
              mrNo: widget.mrNo,
              phone: widget.phone,
            ),
            SizedBox(height: 18.h),
            Text(
              'Purchased Packages',
              style: AppTextStyles.heading3,
            ),
            SizedBox(height: 4.h),
            Text(
              'Tap a package to view its session attendance.',
              style: AppTextStyles.bodySmall,
            ),
            SizedBox(height: 12.h),
            PackageAttendancePurchasedPackageCard(
              packageName: 'Neuro 10 days package',
              purchasedDate: '08 Aug, 2026',
              attended: 5,
              totalSessions: 10,
              isActive: true,
              isSelected: _selectedPackageIndex == 0,
              onTap: () => setState(() => _selectedPackageIndex = 0),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: AppSizes.iconMd,
                  color: AppColors.primary,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Attendance Timeline',
                    style: AppTextStyles.heading3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              'Sessions for the selected package.',
              style: AppTextStyles.bodySmall,
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 42.h,
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  AppSnackbar.info(
                    context,
                    'Print Attendance Card coming soon',
                  );
                },
                icon: Icon(
                  Icons.print_outlined,
                  size: AppSizes.iconSm,
                  color: AppColors.primary,
                ),
                label: Text(
                  'Print Attendance Card',
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                PackageAttendanceSummaryChip(
                  label: 'Total',
                  value: '10',
                  bg: AppColors.softGray,
                  fg: AppColors.textPrimary,
                ),
                SizedBox(width: 8.w),
                PackageAttendanceSummaryChip(
                  label: 'Attended',
                  value: '5',
                  bg: AppColors.successSoft,
                  fg: AppColors.success,
                ),
                SizedBox(width: 8.w),
                PackageAttendanceSummaryChip(
                  label: 'Remaining',
                  value: '5',
                  bg: AppColors.warningSoft,
                  fg: AppColors.warning,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            const PackageAttendanceSessionCard(
              sessionNumber: 1,
              date: '06 Aug, 2026',
              therapist: 'DR AIFA MUSHTAQ',
              clinic: 'Clinic 3 (Neuro and Stroke)',
              timeDuration: '08:39 PM (56 mins)',
            ),
            SizedBox(height: 10.h),
            const PackageAttendanceSessionCard(
              sessionNumber: 2,
              date: '07 Aug, 2026',
              therapist: 'DR AIFA MUSHTAQ',
              clinic: 'Clinic 3 (Neuro and Stroke)',
              timeDuration: '07:20 PM (45 mins)',
            ),
            SizedBox(height: 10.h),
            const PackageAttendanceSessionCard(
              sessionNumber: 3,
              date: '08 Aug, 2026',
              therapist: 'DR AIFA MUSHTAQ',
              clinic: 'Clinic 3 (Neuro and Stroke)',
              timeDuration: '06:10 PM (50 mins)',
            ),
            SizedBox(height: 10.h),
            const PackageAttendanceSessionCard(
              sessionNumber: 4,
              date: '09 Aug, 2026',
              therapist: 'DR AIFA MUSHTAQ',
              clinic: 'Clinic 3 (Neuro and Stroke)',
              timeDuration: '05:45 PM (40 mins)',
              notes: 'Session late start in software due to payment issue',
            ),
            SizedBox(height: 10.h),
            const PackageAttendanceSessionCard(
              sessionNumber: 5,
              date: '10 Aug, 2026',
              therapist: 'DR AIFA MUSHTAQ',
              clinic: 'Clinic 3 (Neuro and Stroke)',
              timeDuration: '04:30 PM (55 mins)',
            ),
          ],
        ),
      ),
    );
  }
}
