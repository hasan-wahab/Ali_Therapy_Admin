import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_stat_card.dart';

// ============================================================
// DASHBOARD STATS GRID
// ------------------------------------------------------------
// 2-column overview cards (sample data — wire API later).
// ============================================================

class DashboardStatsGrid extends StatelessWidget {
  const DashboardStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DashboardStatCard(
                title: 'Total Employees',
                value: '155',
                accentColor: AppColors.primary,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: DashboardStatCard(
                title: 'Total Patients',
                value: '1016',
                subtitle: '+20 this week',
                accentColor: AppColors.success,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DashboardStatCard(
                title: 'Monthly Income',
                value: '192,370',
                subtitle: 'this month',
                accentColor: AppColors.info,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: DashboardStatCard(
                title: 'Monthly Expenses',
                value: '0',
                subtitle: 'this month',
                accentColor: AppColors.error,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
