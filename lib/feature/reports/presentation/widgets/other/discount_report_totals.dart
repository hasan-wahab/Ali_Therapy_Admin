import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_summary_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/discount_report_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/discount_report_stat_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_stats_cards_grid.dart';

// ============================================================
// DISCOUNT REPORT TOTALS
// ------------------------------------------------------------
// Same open/close chrome as UserActivityReportTotals.
// Expanded body: four summary cards in a vertical list.
// ============================================================

class DiscountReportTotals extends StatelessWidget {
  const DiscountReportTotals({
    super.key,
    required this.summary,
    required this.expanded,
    required this.onToggle,
  });

  final DiscountReportSummaryEntity summary;
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
                      horizontal: 10.w,
                      vertical: 6.h,
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
                            'Show Stats',
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
                          padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.h),
                          child: ReportStatsCardsGrid(
                            children: [
                              DiscountReportStatCard(
                                title: 'Discounted Invoices',
                                value: '${summary.discountedInvoices}',
                                subtitle: 'Total invoices',
                                accentColor: AppColors.primary,
                                icon: Icons.receipt_long_outlined,
                              ),
                              DiscountReportStatCard(
                                title: 'Total Gross Billed',
                                value: DiscountReportCard.pkr(
                                  summary.totalGrossBilled,
                                ),
                                subtitle: 'Before discount',
                                accentColor: AppColors.info,
                                icon: Icons.calculate_outlined,
                              ),
                              DiscountReportStatCard(
                                title: 'Total Discount Given',
                                value: DiscountReportCard.pkr(
                                  summary.totalDiscountGiven,
                                ),
                                subtitle: 'Discounts waived',
                                accentColor: AppColors.warning,
                                icon: Icons.local_offer_outlined,
                              ),
                              DiscountReportStatCard(
                                title: 'Net Billed Amount',
                                value: DiscountReportCard.pkr(
                                  summary.netBilledAmount,
                                ),
                                subtitle: 'After discount',
                                accentColor: AppColors.success,
                                icon: Icons.payments_outlined,
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
