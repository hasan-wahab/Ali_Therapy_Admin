import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_report_detail_row.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/user_activity_package_block.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/user_activity_payment_block.dart';

// ============================================================
// USER ACTIVITY REPORT CARD
// ------------------------------------------------------------
// One user activity row as a mobile-friendly card.
// ============================================================

class UserActivityReportCard extends StatelessWidget {
  const UserActivityReportCard({
    super.key,
    required this.index,
    required this.patientName,
    required this.cnic,
    required this.packageName,
    required this.sessionsUsed,
    required this.sessionsTotal,
    required this.remaining,
    required this.invoiceType,
    required this.paymentDate,
    required this.paymentMethod,
    required this.amount,
    this.initiallyExpanded = false,
  });

  final int index;
  final String patientName;
  final String cnic;
  final String packageName;
  final int sessionsUsed;
  final int sessionsTotal;
  final int remaining;
  final String invoiceType;
  final String paymentDate;
  final String paymentMethod;
  final String amount;

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
                      SizedBox(height: 2.h),
                      Text(
                        cnic,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.infoSoft,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    invoiceType,
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
            UserActivityPackageBlock(
              packageName: packageName,
              sessionsUsed: sessionsUsed,
              sessionsTotal: sessionsTotal,
              remaining: remaining,
            ),
            SizedBox(height: 8.h),
            PatientReportDetailRow(
              icon: Icons.receipt_long_outlined,
              label: 'Invoice Type',
              value: invoiceType,
            ),
            UserActivityPaymentBlock(
              paymentDate: paymentDate,
              method: paymentMethod,
              amount: amount,
            ),
          ],
        ),
      ),
    );
  }
}
