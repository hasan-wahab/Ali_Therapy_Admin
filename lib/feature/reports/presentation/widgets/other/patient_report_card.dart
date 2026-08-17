import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_report_detail_row.dart';

// ============================================================
// PATIENT REPORT CARD
// ------------------------------------------------------------
// One patient row as a mobile-friendly expandable card.
// ============================================================

class PatientReportCard extends StatelessWidget {
  const PatientReportCard({
    super.key,
    required this.index,
    required this.name,
    required this.email,
    required this.visitsCount,
    required this.createdAt,
    required this.createdBy,
    this.initiallyExpanded = false,
  });

  final int index;
  final String name;
  final String email;
  final int visitsCount;
  final String createdAt;
  final String createdBy;

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
                      Text(name, style: AppTextStyles.name),
                      SizedBox(height: 4.h),
                      Text(
                        email.trim().isEmpty ? 'No email' : email,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: email.trim().isEmpty
                              ? AppColors.textMuted
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.infoSoft,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '$visitsCount visit${visitsCount == 1 ? '' : 's'}',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.info,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(height: 1.h, color: AppColors.divider),
            SizedBox(height: 10.h),
            AppTabletFieldsGrid(
              phoneColumns: 1,
              tabletColumns: 2,
              children: [
                PatientReportDetailRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: email,
                ),
                PatientReportDetailRow(
                  icon: Icons.event_available_outlined,
                  label: 'Visits Count',
                  value: '$visitsCount',
                ),
                PatientReportDetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Created At',
                  value: createdAt,
                ),
                PatientReportDetailRow(
                  icon: Icons.person_outline_rounded,
                  label: 'Created By',
                  value: createdBy,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
