import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_filters.dart';

// ============================================================
// CONSULTATION REPORT PAGE
// ------------------------------------------------------------
// Mobile Consultant Visits/Sessions report.
// ============================================================

class ConsultationReportPage extends StatelessWidget {
  const ConsultationReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBackAppBar(title: 'Consultation Report'),
      body: AppTabletSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
              child: AppSearchFilterSection(
                searchHint: 'Search consultant, patient…',
                filtersPanel: const ConsultationReportFilters(),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                children: [
                  const ConsultationReportCard(
                    initiallyExpanded: true,
                    index: 1,
                    consultantName: 'DR BILAL AHMED',
                    receptionist: 'FIZZA BIBI',
                    assistantManager: 'SABA NOOR',
                    therapist: 'AMNA RIAZ',
                    patientName: 'Fahad Tufail',
                    visitDateTime: 'Aug 11, 2026 · 10:30 AM',
                    phone: '0300-1234567',
                    clinic: 'Clinic 1',
                    patientType: 'OLD PATIENT',
                    totalBilled: 'PKR 30,000.00',
                    paid: 'PKR 30,000.00',
                    discount: 'PKR 0.00',
                    insurance: 'PKR 0.00',
                    remainingBalance: 'PKR 0.00',
                    sessionsCompleted: 10,
                    sessionsTotal: 10,
                    sessionsRemaining: 0,
                    sessionsSuggested: 0,
                  ),
                  SizedBox(height: 10.h),
                  const ConsultationReportCard(
                    index: 2,
                    consultantName: 'DR BILAL AHMED',
                    receptionist: 'FIZZA BIBI',
                    assistantManager: 'SABA NOOR',
                    therapist: 'AMNA RIAZ',
                    patientName: 'Muhammad Ali',
                    visitDateTime: 'Aug 11, 2026 · 11:00 AM',
                    phone: '0301-7654321',
                    clinic: 'Clinic 1',
                    patientType: 'walkin',
                    totalBilled: 'PKR 45,000.00',
                    paid: 'PKR 45,000.00',
                    discount: 'PKR 0.00',
                    insurance: 'PKR 0.00',
                    remainingBalance: 'PKR 0.00',
                    sessionsCompleted: 15,
                    sessionsTotal: 15,
                    sessionsRemaining: 0,
                    sessionsSuggested: 0,
                  ),
                  SizedBox(height: 10.h),
                  const ConsultationReportCard(
                    index: 3,
                    consultantName: 'DR BILAL AHMED',
                    receptionist: 'KAINAT RASHEED',
                    assistantManager: 'SABA NOOR',
                    therapist: 'ANEELA BIBI',
                    patientName: 'Amina Bibi',
                    visitDateTime: 'Aug 11, 2026 · 12:15 PM',
                    phone: '0321-9988776',
                    clinic: 'Clinic 2',
                    patientType: 'OLD PATIENT',
                    totalBilled: 'PKR 30,000.00',
                    paid: 'PKR 25,000.00',
                    discount: 'PKR 0.00',
                    insurance: 'PKR 0.00',
                    remainingBalance: 'PKR 5,000.00',
                    sessionsCompleted: 10,
                    sessionsTotal: 10,
                    sessionsRemaining: 0,
                    sessionsSuggested: 0,
                  ),
                  SizedBox(height: 10.h),
                  const ConsultationReportCard(
                    index: 4,
                    consultantName: 'DR BILAL AHMED',
                    receptionist: 'FIZZA BIBI',
                    assistantManager: 'SABA NOOR',
                    therapist: 'AMNA RIAZ',
                    patientName: 'Farid Ullah',
                    visitDateTime: 'Aug 11, 2026 · 01:45 PM',
                    phone: '0333-4455667',
                    clinic: 'Clinic 1',
                    patientType: 'walkin',
                    totalBilled: 'PKR 30,000.00',
                    paid: 'PKR 20,000.00',
                    discount: 'PKR 0.00',
                    insurance: 'PKR 0.00',
                    remainingBalance: 'PKR 10,000.00',
                    sessionsCompleted: 8,
                    sessionsTotal: 10,
                    sessionsRemaining: 2,
                    sessionsSuggested: 2,
                  ),
                  SizedBox(height: 10.h),
                  const ConsultationReportCard(
                    index: 5,
                    consultantName: 'DR BILAL AHMED',
                    receptionist: 'FIZZA BIBI',
                    assistantManager: 'SABA NOOR',
                    therapist: 'AMNA RIAZ',
                    patientName: 'Noor Fatima',
                    visitDateTime: 'Aug 11, 2026 · 03:00 PM',
                    phone: '0345-1122334',
                    clinic: 'Clinic 3 (Neuro and Stroke)',
                    patientType: 'OLD PATIENT',
                    totalBilled: 'PKR 36,000.00',
                    paid: 'PKR 36,000.00',
                    discount: 'PKR 0.00',
                    insurance: 'PKR 0.00',
                    remainingBalance: 'PKR 0.00',
                    sessionsCompleted: 12,
                    sessionsTotal: 12,
                    sessionsRemaining: 0,
                    sessionsSuggested: 0,
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
