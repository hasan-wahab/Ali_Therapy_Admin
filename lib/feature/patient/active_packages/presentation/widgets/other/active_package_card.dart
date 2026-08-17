import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/patient/active_packages/presentation/widgets/other/active_package_progress.dart';
import 'package:ali_therapy_admin/feature/patient/active_packages/presentation/widgets/other/active_package_status_badge.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';

// ============================================================
// ACTIVE PACKAGE CARD
// ------------------------------------------------------------
// Package card: title, sessions progress, price, status.
// ============================================================

class ActivePackageCard extends StatelessWidget {
  const ActivePackageCard({
    super.key,
    required this.packageName,
    required this.completedSessions,
    required this.totalSessions,
    required this.price,
    required this.status,
    this.initiallyExpanded = false,
  });

  final String packageName;
  final int completedSessions;
  final int totalSessions;
  final String price;
  final String status;

  final bool initiallyExpanded;
  @override
  Widget build(BuildContext context) {
    return AppExpandableCard(
      initiallyExpanded: initiallyExpanded,
      child: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
        child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left teal accent bar
            Container(width: 4.w, color: AppColors.primary),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      packageName,
                      style: AppTextStyles.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 12.h),
                    ActivePackageProgress(
                      completedSessions: completedSessions,
                      totalSessions: totalSessions,
                    ),
                    SizedBox(height: 14.h),
                    AppTabletFieldsGrid(
                      phoneColumns: 2,
                      tabletColumns: 2,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              price,
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Status',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            ActivePackageStatusBadge(status: status),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
