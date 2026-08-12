import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/free_consultation_report_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/free_consultation_report_filters.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_search_app_bar.dart';

// ============================================================
// FREE CONSULTATION REPORT PAGE
// ------------------------------------------------------------
// Mobile free consultation visits report.
// ============================================================

class FreeConsultationReportPage extends StatelessWidget {
  const FreeConsultationReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const ReportSearchAppBar(
        title: 'Free Consultation Report',
        searchHint: 'Search patient, consultant…',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          children: [
            const FreeConsultationReportFilters(),
            SizedBox(height: 12.h),
            const FreeConsultationReportCard(
              initiallyExpanded: true,
              index: 1,
              consultantName: 'DR ARSALAN JAMIL',
              patientName: 'Haaris Suhail Qadir',
              visitDate: 'Aug 10, 2026 07:04 PM',
              patientPhone: '0321-4598000',
              clinic: 'Clinic 2',
            ),
            SizedBox(height: 10.h),
            const FreeConsultationReportCard(
              index: 2,
              consultantName: 'DR HIRA HASSAN',
              patientName: 'Hamza Maqsood',
              visitDate: 'Aug 10, 2026 06:30 PM',
              patientPhone: '0300-1122334',
              clinic: 'Clinic 2',
            ),
            SizedBox(height: 10.h),
            const FreeConsultationReportCard(
              index: 3,
              consultantName: 'N/A',
              patientName: 'Amina Bibi',
              visitDate: 'Aug 09, 2026 05:15 PM',
              patientPhone: '0333-9988776',
              clinic: 'Clinic 2',
            ),
            SizedBox(height: 10.h),
            const FreeConsultationReportCard(
              index: 4,
              consultantName: 'DR ARSALAN JAMIL',
              patientName: 'Farid Ullah',
              visitDate: 'Aug 09, 2026 03:40 PM',
              patientPhone: '0345-5566778',
              clinic: 'Clinic 2',
            ),
            SizedBox(height: 10.h),
            const FreeConsultationReportCard(
              index: 5,
              consultantName: 'DR HIRA HASSAN',
              patientName: 'Noor Fatima',
              visitDate: 'Aug 08, 2026 02:10 PM',
              patientPhone: '0312-2233445',
              clinic: 'Clinic 2',
            ),
          ],
        ),
      ),
    );
  }
}
