import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_balance_box.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_info_line.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_patient_type_badge.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_review_switch.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_sessions_block.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_staff_line.dart';

// ============================================================
// CONSULTATION REPORT CARD
// ------------------------------------------------------------
// One consultant visit/session row as a mobile card.
// ============================================================

class ConsultationReportCard extends StatelessWidget {
  const ConsultationReportCard({
    super.key,
    required this.index,
    required this.consultantName,
    required this.receptionist,
    required this.assistantManager,
    required this.therapist,
    required this.patientName,
    required this.visitDateTime,
    required this.phone,
    required this.clinic,
    required this.patientType,
    required this.totalBilled,
    required this.paid,
    required this.discount,
    required this.insurance,
    required this.remainingBalance,
    required this.sessionsCompleted,
    required this.sessionsTotal,
    required this.sessionsRemaining,
    required this.sessionsSuggested,
    this.reviewDone = false,
    this.initiallyExpanded = false,
  });

  final int index;
  final String consultantName;
  final String receptionist;
  final String assistantManager;
  final String therapist;
  final String patientName;
  final String visitDateTime;
  final String phone;
  final String clinic;
  final String patientType;
  final String totalBilled;
  final String paid;
  final String discount;
  final String insurance;
  final String remainingBalance;
  final int sessionsCompleted;
  final int sessionsTotal;
  final int sessionsRemaining;
  final int sessionsSuggested;
  final bool reviewDone;

  final bool initiallyExpanded;
  @override
  Widget build(BuildContext context) {
    return AppExpandableCard(
      initiallyExpanded: initiallyExpanded,
      collapsedHeight: 210.h,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Index + consultant + review text
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 26.w,
                  height: 26.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    '$index',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    consultantName,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ConsultationReportReviewSwitch(value: reviewDone),
              ],
            ),
            SizedBox(height: 4.h),
            ConsultationReportStaffLine(
              icon: Icons.support_agent_outlined,
              label: 'Receptionist',
              value: receptionist,
            ),
            ConsultationReportStaffLine(
              icon: Icons.badge_outlined,
              label: 'Assistant Mgr',
              value: assistantManager,
            ),
            ConsultationReportStaffLine(
              icon: Icons.handshake_outlined,
              label: 'Therapist',
              value: therapist,
            ),
            SizedBox(height: 6.h),
            Divider(height: 1.h, color: AppColors.divider),
            SizedBox(height: 6.h),

            // Patient details
            Text(
              'Patient Details',
              style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    patientName,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ConsultationReportPatientTypeBadge(text: patientType),
              ],
            ),
            SizedBox(height: 4.h),
            ConsultationReportInfoLine(
              icon: Icons.event_outlined,
              text: visitDateTime,
            ),
            ConsultationReportInfoLine(
              icon: Icons.phone_outlined,
              text: phone,
            ),
            ConsultationReportInfoLine(
              icon: Icons.local_hospital_outlined,
              text: clinic,
            ),
            SizedBox(height: 6.h),

            ConsultationReportBalanceBox(
              totalBilled: totalBilled,
              paid: paid,
              discount: discount,
              insurance: insurance,
              remaining: remainingBalance,
            ),
            SizedBox(height: 6.h),
            ConsultationReportSessionsBlock(
              completed: sessionsCompleted,
              total: sessionsTotal,
              remaining: sessionsRemaining,
              suggested: sessionsSuggested,
            ),
          ],
        ),
      ),
    );
  }
}
