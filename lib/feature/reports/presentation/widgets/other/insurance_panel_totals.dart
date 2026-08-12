import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_money_line.dart';

// ============================================================
// INSURANCE PANEL TOTALS
// ------------------------------------------------------------
// Totals card shown after tapping the Total button.
// ============================================================

class InsurancePanelTotals extends StatelessWidget {
  const InsurancePanelTotals({
    super.key,
    required this.totalInvoices,
    required this.consultationBilled,
    required this.packageBilled,
    required this.totalBilled,
    required this.totalCovered,
    required this.totalPaidCash,
    required this.outstandingBalance,
    this.onClose,
  });

  final int totalInvoices;
  final String consultationBilled;
  final String packageBilled;
  final String totalBilled;
  final String totalCovered;
  final String totalPaidCash;
  final String outstandingBalance;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Total',
                  style: AppTextStyles.name.copyWith(color: AppColors.primary),
                ),
              ),
              if (onClose != null)
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
                  onPressed: onClose,
                  icon: Icon(
                    Icons.close_rounded,
                    size: AppSizes.iconSm,
                    color: AppColors.textMuted,
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            '$totalInvoices invoices',
            style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8.h),
          PatientDuesMoneyLine(
            label: 'Consultation Billed',
            value: consultationBilled,
            bold: true,
          ),
          PatientDuesMoneyLine(
            label: 'Package Billed',
            value: packageBilled,
            bold: true,
          ),
          PatientDuesMoneyLine(
            label: 'Total Billed',
            value: totalBilled,
            bold: true,
          ),
          PatientDuesMoneyLine(
            label: 'Total Covered',
            value: totalCovered,
            bold: true,
          ),
          PatientDuesMoneyLine(
            label: 'Total Paid Cash',
            value: totalPaidCash,
            bold: true,
          ),
          PatientDuesMoneyLine(
            label: 'Outstanding Balance',
            value: outstandingBalance,
            bold: true,
          ),
        ],
      ),
    );
  }
}
