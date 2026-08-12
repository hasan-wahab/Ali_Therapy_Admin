import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/receptionist_report_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/receptionist_report_filters.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_search_app_bar.dart';

// ============================================================
// RECEPTIONIST REPORT PAGE
// ------------------------------------------------------------
// Mobile receptionist visits/sessions report.
// ============================================================

class ReceptionistReportPage extends StatelessWidget {
  const ReceptionistReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const ReportSearchAppBar(
        title: 'Receptionist Report',
        searchHint: 'Search patient, receptionist…',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          children: [
            const ReceptionistReportFilters(),
            SizedBox(height: 12.h),
            const ReceptionistReportCard(
              initiallyExpanded: true,
              index: 1,
              receptionistName: 'FIZZA BIBI',
              patientName: 'Mrs Hina Atif',
              visitDate: 'Aug 11, 2026 10:22 PM',
              patientPhone: '0302-8451828',
              clinic: 'Clinic 2',
              type: 'Therapy Session',
            ),
            SizedBox(height: 10.h),
            const ReceptionistReportCard(
              index: 2,
              receptionistName: 'KAINAT RASHEED',
              patientName: 'Umer Farooq',
              visitDate: 'Aug 11, 2026 09:45 PM',
              patientPhone: '0333-1122334',
              clinic: 'Clinic 1',
              type: 'Consultation',
            ),
            SizedBox(height: 10.h),
            const ReceptionistReportCard(
              index: 3,
              receptionistName: 'SABA NOOR',
              patientName: 'Amina Bibi',
              visitDate: 'Aug 11, 2026 08:20 PM',
              patientPhone: '0321-9988776',
              clinic: 'Clinic 3 (Neuro and Stroke)',
              type: 'Therapy Session',
            ),
            SizedBox(height: 10.h),
            const ReceptionistReportCard(
              index: 4,
              receptionistName: 'FIZZA BIBI',
              patientName: 'Farid Ullah',
              visitDate: 'Aug 11, 2026 07:10 PM',
              patientPhone: '0345-5566778',
              clinic: 'Clinic 2',
              type: 'Consultation',
            ),
            SizedBox(height: 10.h),
            const ReceptionistReportCard(
              index: 5,
              receptionistName: 'KAINAT RASHEED',
              patientName: 'Noor Fatima',
              visitDate: 'Aug 11, 2026 06:00 PM',
              patientPhone: '0312-2233445',
              clinic: 'Clinic 1',
              type: 'Therapy Session',
            ),
          ],
        ),
      ),
    );
  }
}
