import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_money_line.dart';

// ============================================================
// INSURANCE PANEL CARD
// ------------------------------------------------------------
// One insurance panel row as a mobile card.
// ============================================================

class InsurancePanelCard extends StatelessWidget {
  const InsurancePanelCard({
    super.key,
    required this.panelName,
    required this.policyType,
    required this.totalInvoices,
    required this.consultationBilled,
    required this.packageBilled,
    required this.totalBilled,
    required this.totalCovered,
    required this.totalPaidCash,
    required this.outstandingBalance,
    this.initiallyExpanded = false,
  });

  final String panelName;
  final String policyType;
  final int totalInvoices;
  final String consultationBilled;
  final String packageBilled;
  final String totalBilled;
  final String totalCovered;
  final String totalPaidCash;
  final String outstandingBalance;
  final bool initiallyExpanded;

  bool get _isCredit => policyType.toLowerCase().contains('credit');

  @override
  Widget build(BuildContext context) {
    final badgeBg = _isCredit ? AppColors.infoSoft : AppColors.primaryLight;
    final badgeFg = _isCredit ? AppColors.info : AppColors.primary;

    return AppExpandableCard(
      initiallyExpanded: initiallyExpanded,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text(panelName, style: AppTextStyles.name)),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    policyType,
                    style: AppTextStyles.label.copyWith(
                      color: badgeFg,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              '$totalInvoices invoices',
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 10.h),
            Divider(height: 1.h, color: AppColors.divider),
            SizedBox(height: 10.h),
            Text(
              'Billed',
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            AppTabletFieldsGrid(
              phoneColumns: 1,
              tabletColumns: 2,
              children: [
                PatientDuesMoneyLine(
                  label: 'Consultation Billed',
                  value: consultationBilled,
                ),
                PatientDuesMoneyLine(
                  label: 'Package Billed',
                  value: packageBilled,
                ),
                PatientDuesMoneyLine(
                  label: 'Total Billed',
                  value: totalBilled,
                  bold: true,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              'Coverage & Payments',
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            AppTabletFieldsGrid(
              phoneColumns: 1,
              tabletColumns: 2,
              children: [
                PatientDuesMoneyLine(
                  label: 'Total Covered',
                  value: totalCovered,
                ),
                PatientDuesMoneyLine(
                  label: 'Total Paid Cash',
                  value: totalPaidCash,
                ),
                PatientDuesMoneyLine(
                  label: 'Outstanding Balance',
                  value: outstandingBalance,
                  bold: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
