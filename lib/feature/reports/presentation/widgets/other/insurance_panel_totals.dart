import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_money_line.dart';

// ============================================================
// INSURANCE PANEL TOTALS
// ------------------------------------------------------------
// Outlined dropdown: tap header to slide totals open / closed.
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
    required this.expanded,
    required this.onToggle,
  });

  final int totalInvoices;
  final String consultationBilled;
  final String packageBilled;
  final String totalBilled;
  final String totalCovered;
  final String totalPaidCash;
  final String outstandingBalance;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final radius = 12.r;
    final borderWidth = 1.5.w;
    final borderColor = expanded ? AppColors.primary : AppColors.border;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          (radius - borderWidth).clamp(0.0, radius),
        ),
        child: ColoredBox(
          color: AppColors.primaryLight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Material(
                color: AppColors.primaryLight,
                child: InkWell(
                  onTap: onToggle,
                  splashColor: AppColors.primary.withValues(alpha: 0.08),
                  highlightColor: AppColors.primary.withValues(alpha: 0.04),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.summarize_outlined,
                          size: AppSizes.iconMd,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Total',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                        ),
                        AnimatedRotation(
                          turns: expanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 320),
                          curve: Curves.easeOutCubic,
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: AppSizes.iconLg,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ClipRect(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 320),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.topCenter,
                  child: expanded
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '$totalInvoices invoices',
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
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
                        )
                      : const SizedBox(width: double.infinity),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
