import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/entities/user_activity_report_summary_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_stats_cards_grid.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/user_activity_report_stat_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/user_activity_report_stat_line.dart';

// ============================================================
// USER ACTIVITY REPORT TOTALS
// ------------------------------------------------------------
// Same open/close chrome as InsurancePanelTotals.
// Expanded body shows packages / consultations / top-ups / grand.
// ============================================================

class UserActivityReportTotals extends StatelessWidget {
  const UserActivityReportTotals({
    super.key,
    required this.summary,
    required this.expanded,
    required this.onToggle,
  });

  final UserActivityReportSummaryEntity summary;
  final bool expanded;
  final VoidCallback onToggle;

  static final NumberFormat _money = NumberFormat('#,##0.00', 'en_US');

  static String money(double value) => _money.format(value);

  List<UserActivityReportStatLine> _methodLines(
    UserActivityPaymentBreakdownEntity bucket, {
    required bool includeWallet,
  }) {
    return [
      UserActivityReportStatLine(label: 'Cash', value: money(bucket.cash)),
      if (includeWallet)
        UserActivityReportStatLine(
          label: 'Wallet',
          value: money(bucket.wallet),
        ),
      UserActivityReportStatLine(label: 'Card', value: money(bucket.card)),
      UserActivityReportStatLine(label: 'QR', value: money(bucket.qr)),
      UserActivityReportStatLine(
        label: 'Account Transfer',
        value: money(bucket.accountTransfer),
      ),
    ];
  }

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
                            phoneColumns: 1,
                            tabletLandscapeColumns: 2,
                            children: [
                              UserActivityReportStatCard(
                                title: 'Packages Total',
                                total: money(summary.packages.total),
                                totalColor: AppColors.primary,
                                lines: _methodLines(
                                  summary.packages,
                                  includeWallet: true,
                                ),
                              ),
                              UserActivityReportStatCard(
                                title: 'Consultations Total',
                                total: money(summary.consultations.total),
                                totalColor: AppColors.primary,
                                lines: _methodLines(
                                  summary.consultations,
                                  includeWallet: true,
                                ),
                              ),
                              UserActivityReportStatCard(
                                title: 'Wallet Top-ups Total',
                                total: money(summary.walletTopups.total),
                                totalColor: AppColors.warning,
                                lines: _methodLines(
                                  summary.walletTopups,
                                  includeWallet: false,
                                ),
                              ),
                              UserActivityReportStatCard(
                                title: 'Grand Total',
                                total: money(summary.grandTotal),
                                totalColor: AppColors.primary,
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
