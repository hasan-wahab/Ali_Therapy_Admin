import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/entities/patient_detail_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_display.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_metric_card.dart';

// ============================================================
// PATIENT DETAIL METRICS GRID
// ------------------------------------------------------------
// Metric cards open their feature screens on tap.
// ============================================================

class PatientDetailMetricsGrid extends StatelessWidget {
  const PatientDetailMetricsGrid({
    super.key,
    required this.detail,
  });

  final PatientDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    final profile = detail.profile;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PatientDetailMetricCard(
                title: 'Total Visits',
                value: '${profile.totalVisits}',
                icon: Icons.calendar_month_outlined,
                onTap: () => AppNavigation.openTotalVisits(
                  context,
                  detail: detail,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: PatientDetailMetricCard(
                title: 'Active Packages',
                value: '${profile.activePackages}',
                icon: Icons.inventory_2_outlined,
                onTap: () => AppNavigation.openActivePackages(
                  context,
                  detail: detail,
                ),
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
                value: PatientDetailDisplay.moneyRs(profile.totalSpent),
                icon: Icons.payments_outlined,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: PatientDetailMetricCard(
                title: 'Therapy Sessions',
                value: '${profile.therapySessions}',
                icon: Icons.monitor_heart_outlined,
                accentColor: AppColors.warning,
                onTap: () => AppNavigation.openTherapySessions(
                  context,
                  detail: detail,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
