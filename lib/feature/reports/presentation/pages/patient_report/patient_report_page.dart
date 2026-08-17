import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_report_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_report_filters.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_report_staff_filters.dart';

// ============================================================
// PATIENT REPORT PAGE
// ------------------------------------------------------------
// Mobile All Patients Report: filters + cards.
// ============================================================

class PatientReportPage extends StatelessWidget {
  const PatientReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBackAppBar(title: 'Patient Report'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
              child: AppSearchFilterSection(
                searchHint: 'Search patient…',
                filtersPanel: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const PatientReportFilters(),
                    SizedBox(height: 6.h),
                    const PatientReportStaffFilters(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                children: [
                  const PatientReportCard(
                    initiallyExpanded: true,
                    index: 1,
                    name: 'Muhammad Ali',
                    email: 'muhammadali@gmail.com',
                    visitsCount: 1,
                    createdAt: 'Aug 11, 2026',
                    createdBy: 'FIZZA BIBI',
                  ),
                  SizedBox(height: 10.h),
                  const PatientReportCard(
                    index: 2,
                    name: 'Farid Ullah',
                    email: '',
                    visitsCount: 1,
                    createdAt: 'Aug 11, 2026',
                    createdBy: 'FIZZA BIBI',
                  ),
                  SizedBox(height: 10.h),
                  const PatientReportCard(
                    index: 3,
                    name: 'Muhammad Ali',
                    email: '',
                    visitsCount: 1,
                    createdAt: 'Aug 11, 2026',
                    createdBy: 'FIZZA BIBI',
                  ),
                  SizedBox(height: 10.h),
                  const PatientReportCard(
                    index: 4,
                    name: 'Amina Bibi',
                    email: '',
                    visitsCount: 1,
                    createdAt: 'Aug 11, 2026',
                    createdBy: 'FIZZA BIBI',
                  ),
                  SizedBox(height: 10.h),
                  const PatientReportCard(
                    index: 5,
                    name: 'Muhammad Ali',
                    email: '',
                    visitsCount: 1,
                    createdAt: 'Aug 11, 2026',
                    createdBy: 'FIZZA BIBI',
                  ),
                  SizedBox(height: 10.h),
                  const PatientReportCard(
                    index: 6,
                    name: 'Noor Fatima',
                    email: '',
                    visitsCount: 1,
                    createdAt: 'Aug 11, 2026',
                    createdBy: 'FIZZA BIBI',
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
