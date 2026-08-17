import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/assistant_manager_report_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/assistant_manager_report_filters.dart';

// ============================================================
// ASSISTANT MANAGER REPORT PAGE
// ------------------------------------------------------------
// Mobile assistant manager visits report.
// ============================================================

class AssistantManagerReportPage extends StatelessWidget {
  const AssistantManagerReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBackAppBar(title: 'Assistant Manager Report'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
              child: AppSearchFilterSection(
                searchHint: 'Search patient, AM…',
                filtersPanel: const AssistantManagerReportFilters(),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                children: [
                  const AssistantManagerReportCard(
                    initiallyExpanded: true,
                    index: 1,
                    assistantManagerName: 'DR SONIA AHMED',
                    patientName: 'Mrs Hina Atif',
                    visitDate: 'Aug 11, 2026 10:22 PM',
                    patientPhone: '0302-8451828',
                    clinic: 'Clinic 2',
                    type: 'Therapy Session',
                  ),
                  SizedBox(height: 10.h),
                  const AssistantManagerReportCard(
                    index: 2,
                    assistantManagerName: 'DR SHAGUFTA ARIF',
                    patientName: 'Umer Farooq',
                    visitDate: 'Aug 11, 2026 09:50 PM',
                    patientPhone: '0333-1122334',
                    clinic: 'Clinic 1',
                    type: 'Consultation',
                  ),
                  SizedBox(height: 10.h),
                  const AssistantManagerReportCard(
                    index: 3,
                    assistantManagerName: 'DR HIRA HASSAN',
                    patientName: 'Amina Bibi',
                    visitDate: 'Aug 11, 2026 08:30 PM',
                    patientPhone: '0321-9988776',
                    clinic: 'Clinic 3 (Neuro and Stroke)',
                    type: 'Therapy Session',
                  ),
                  SizedBox(height: 10.h),
                  const AssistantManagerReportCard(
                    index: 4,
                    assistantManagerName: 'DR SONIA AHMED',
                    patientName: 'Farid Ullah',
                    visitDate: 'Aug 11, 2026 07:15 PM',
                    patientPhone: '0345-5566778',
                    clinic: 'Clinic 2',
                    type: 'Consultation',
                  ),
                  SizedBox(height: 10.h),
                  const AssistantManagerReportCard(
                    index: 5,
                    assistantManagerName: 'DR SHAGUFTA ARIF',
                    patientName: 'Noor Fatima',
                    visitDate: 'Aug 11, 2026 06:05 PM',
                    patientPhone: '0312-2233445',
                    clinic: 'Clinic 1',
                    type: 'Therapy Session',
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
