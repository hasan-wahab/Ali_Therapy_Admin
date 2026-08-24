import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_summary_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/assistant_manager_report_stat_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_stats_cards_grid.dart';

// ============================================================
// ASSISTANT MANAGER REPORT TOTALS
// ------------------------------------------------------------
// Same open/close chrome as ReceptionistReportTotals.
// Expanded body: total visits + per-clinic visit cards.
// ============================================================

class AssistantManagerReportTotals extends StatelessWidget {
  const AssistantManagerReportTotals({
    super.key,
    required this.summary,
    required this.expanded,
    required this.onToggle,
  });

  final AssistantManagerReportSummaryEntity summary;
  final bool expanded;
  final VoidCallback onToggle;

  static const _clinicColors = [
    AppColors.success,
    AppColors.info,
    AppColors.warning,
    AppColors.error,
    AppColors.secondary,
  ];

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
                              AssistantManagerReportStatCard(
                                title: 'Total Visits',
                                value: '${summary.totalVisits}',
                                subtitle: 'Filtered total',
                                accentColor: AppColors.primary,
                                icon: Icons.event_available_outlined,
                              ),
                              for (var i = 0; i < summary.clinics.length; i++)
                                AssistantManagerReportStatCard(
                                  title: summary.clinics[i].name,
                                  value: '${summary.clinics[i].visits}',
                                  subtitle: 'Visits',
                                  accentColor:
                                      _clinicColors[i % _clinicColors.length],
                                  icon: Icons.apartment_outlined,
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
