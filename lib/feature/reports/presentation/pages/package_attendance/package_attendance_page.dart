import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_filters.dart';

// ============================================================
// PACKAGE ATTENDANCE PAGE
// ------------------------------------------------------------
// Patients package attendance directory (list).
// ============================================================

class PackageAttendancePage extends StatelessWidget {
  const PackageAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBackAppBar(title: 'Package Attendance'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
              child: AppSearchFilterSection(
                searchHint: 'Name, Phone, MR No…',
                filtersPanel: const PackageAttendanceFilters(),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: AppColors.successSoft,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      'Select a patient to view their purchased packages & attendance history.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const PackageAttendanceCard(
                    initiallyExpanded: true,
                    patientName: 'Rida Fatima',
                    mrNo: 'MR-10231',
                    gender: 'Female',
                    phone: '0300-1234567',
                    hasNfc: false,
                    packagesTaken: 1,
                    activePackageName: 'single session',
                    attended: 0,
                    totalSessions: 1,
                  ),
                  SizedBox(height: 10.h),
                  const PackageAttendanceCard(
                    patientName: 'Maria Kifayat',
                    mrNo: 'MR-01081',
                    gender: 'Female',
                    phone: '0332-5392720',
                    hasNfc: false,
                    packagesTaken: 1,
                    activePackageName: 'Neuro 10 days package',
                    attended: 5,
                    totalSessions: 10,
                  ),
                  SizedBox(height: 10.h),
                  const PackageAttendanceCard(
                    patientName: 'Muhammad Ali',
                    mrNo: 'MR-10230',
                    gender: 'Male',
                    phone: '0321-9988776',
                    hasNfc: false,
                    packagesTaken: 1,
                    activePackageName: 'NEURO 15 DAYS',
                    attended: 1,
                    totalSessions: 15,
                  ),
                  SizedBox(height: 10.h),
                  const PackageAttendanceCard(
                    patientName: 'Amina Bibi',
                    mrNo: 'MR-10229',
                    gender: 'Female',
                    phone: '0333-4455667',
                    hasNfc: true,
                    packagesTaken: 2,
                    activePackageName: '15 days session 45000',
                    attended: 2,
                    totalSessions: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
