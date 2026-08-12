import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_metric_card.dart';

// ============================================================
// PATIENT DETAIL METRICS GRID
// ------------------------------------------------------------
// Metric cards open their feature screens on tap.
// ============================================================

class PatientDetailMetricsGrid extends StatelessWidget {
  const PatientDetailMetricsGrid({
    super.key,
    this.totalVisits = '2',
    this.activePackages = '1',
    this.totalSpent = 'Rs. 3,000.00',
    this.therapySessions = '1',
  });

  final String totalVisits;
  final String activePackages;
  final String totalSpent;
  final String therapySessions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PatientDetailMetricCard(
                title: 'Total Visits',
                value: totalVisits,
                icon: Icons.calendar_month_outlined,
                onTap: () => AppNavigation.openTotalVisits(context),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: PatientDetailMetricCard(
                title: 'Active Packages',
                value: activePackages,
                icon: Icons.inventory_2_outlined,
                onTap: () => AppNavigation.openActivePackages(context),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: PatientDetailMetricCard(
                title: 'Total Spent',
                value: totalSpent,
                icon: Icons.payments_outlined,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: PatientDetailMetricCard(
                title: 'Therapy Sessions',
                value: therapySessions,
                icon: Icons.monitor_heart_outlined,
                accentColor: AppColors.warning,
                onTap: () => AppNavigation.openTherapySessions(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
