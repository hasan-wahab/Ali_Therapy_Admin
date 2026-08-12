import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/reconsultation_report_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/reconsultation_report_filters.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_search_app_bar.dart';

// ============================================================
// RECONSULTATION REPORT PAGE
// ------------------------------------------------------------
// Mobile reconsultation visits report.
// ============================================================

class ReconsultationReportPage extends StatelessWidget {
  const ReconsultationReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const ReportSearchAppBar(
        title: 'Reconsultation Report',
        searchHint: 'Search patient, consultant…',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          children: [
            const ReconsultationReportFilters(),
            SizedBox(height: 12.h),
            const ReconsultationReportCard(
              initiallyExpanded: true,
              index: 1,
              consultantName: 'DR BILAL AHMED',
              patientName: 'mahlaka sheraz',
              visitDate: 'Aug 11, 2026 06:56 PM',
              patientPhone: '0332-5443880',
              clinic: 'Clinic 1',
            ),
            SizedBox(height: 10.h),
            const ReconsultationReportCard(
              index: 2,
              consultantName: 'DR BILAL AHMED',
              patientName: 'Muhammad Ali',
              visitDate: 'Aug 11, 2026 05:20 PM',
              patientPhone: '0300-1234567',
              clinic: 'Clinic 1',
            ),
            SizedBox(height: 10.h),
            const ReconsultationReportCard(
              index: 3,
              consultantName: 'DR BILAL AHMED',
              patientName: 'Amina Bibi',
              visitDate: 'Aug 11, 2026 04:10 PM',
              patientPhone: '0321-9988776',
              clinic: 'Clinic 2',
            ),
            SizedBox(height: 10.h),
            const ReconsultationReportCard(
              index: 4,
              consultantName: 'DR BILAL AHMED',
              patientName: 'Farid Ullah',
              visitDate: 'Aug 11, 2026 03:00 PM',
              patientPhone: '0333-4455667',
              clinic: 'Clinic 3 (Neuro and Stroke)',
            ),
            SizedBox(height: 10.h),
            const ReconsultationReportCard(
              index: 5,
              consultantName: 'DR BILAL AHMED',
              patientName: 'Noor Fatima',
              visitDate: 'Aug 11, 2026 01:45 PM',
              patientPhone: '0345-1122334',
              clinic: 'Clinic 1',
            ),
          ],
        ),
      ),
    );
  }
}
