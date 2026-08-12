import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_report_detail_row.dart';

// ============================================================
// RECONSULTATION REPORT CARD
// ------------------------------------------------------------
// One reconsultation visit as a mobile-friendly card.
// ============================================================

class ReconsultationReportCard extends StatelessWidget {
  const ReconsultationReportCard({
    super.key,
    required this.index,
    required this.consultantName,
    required this.patientName,
    required this.visitDate,
    required this.patientPhone,
    required this.clinic,
    this.initiallyExpanded = false,
  });

  final int index;
  final String consultantName;
  final String patientName;
  final String visitDate;
  final String patientPhone;
  final String clinic;

  final bool initiallyExpanded;
  @override
  Widget build(BuildContext context) {
    return AppExpandableCard(
      initiallyExpanded: initiallyExpanded,
      collapsedHeight: 180.h,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '$index',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patientName,
                        style: AppTextStyles.name.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        consultantName,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(height: 1.h, color: AppColors.divider),
            SizedBox(height: 10.h),
            PatientReportDetailRow(
              icon: Icons.medical_services_outlined,
              label: 'Consultant',
              value: consultantName,
            ),
            PatientReportDetailRow(
              icon: Icons.event_outlined,
              label: 'Visit Date',
              value: visitDate,
            ),
            PatientReportDetailRow(
              icon: Icons.phone_outlined,
              label: 'Patient Phone',
              value: patientPhone,
            ),
            PatientReportDetailRow(
              icon: Icons.local_hospital_outlined,
              label: 'Clinic',
              value: clinic,
            ),
          ],
        ),
      ),
    );
  }
}
