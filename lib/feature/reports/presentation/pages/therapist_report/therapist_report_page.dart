import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/therapist_report_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/therapist_report_filters.dart';

// ============================================================
// THERAPIST REPORT PAGE
// ------------------------------------------------------------
// Mobile therapist visits/sessions report.
// ============================================================

class TherapistReportPage extends StatelessWidget {
  const TherapistReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBackAppBar(title: 'Therapist Report'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
              child: AppSearchFilterSection(
                searchHint: 'Search patient, therapist…',
                filtersPanel: const TherapistReportFilters(),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                children: [
                  const TherapistReportCard(
                    initiallyExpanded: true,
                    index: 1,
                    visitId: '10421',
                    therapistName: 'DR SUHAIL MEHMOOD',
                    patientName: 'Muhammad Zohaib Awais',
                    therapyDate: 'Aug 11, 2026 10:18 PM',
                    patientCnic: 'N/A',
                    clinic: 'Clinic 3 (Neuro and Stroke)',
                    type: 'Therapy Session',
                  ),
                  SizedBox(height: 10.h),
                  const TherapistReportCard(
                    index: 2,
                    visitId: '10420',
                    therapistName: 'DR SUHAIL MEHMOOD',
                    patientName: 'Haaris Suhail Qadir',
                    therapyDate: 'Aug 11, 2026 09:40 PM',
                    patientCnic: 'N/A',
                    clinic: 'Clinic 2',
                    type: 'Reconsultation',
                  ),
                  SizedBox(height: 10.h),
                  const TherapistReportCard(
                    index: 3,
                    visitId: '10419',
                    therapistName: 'AMNA RIAZ',
                    patientName: 'Amina Bibi',
                    therapyDate: 'Aug 11, 2026 08:15 PM',
                    patientCnic: '35202-1234567-8',
                    clinic: 'Clinic 1',
                    type: 'Consultation',
                  ),
                  SizedBox(height: 10.h),
                  const TherapistReportCard(
                    index: 4,
                    visitId: '10418',
                    therapistName: 'DR ARSALAN JAMIL',
                    patientName: 'Farid Ullah',
                    therapyDate: 'Aug 11, 2026 07:05 PM',
                    patientCnic: 'N/A',
                    clinic: 'Clinic 3 (Neuro and Stroke)',
                    type: 'Therapy Session',
                  ),
                  SizedBox(height: 10.h),
                  const TherapistReportCard(
                    index: 5,
                    visitId: '10417',
                    therapistName: 'DR SUHAIL MEHMOOD',
                    patientName: 'Noor Fatima',
                    therapyDate: 'Aug 11, 2026 06:20 PM',
                    patientCnic: '37105-0248077-0',
                    clinic: 'Clinic 2',
                    type: 'Reconsultation',
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
