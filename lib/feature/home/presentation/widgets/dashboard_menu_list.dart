import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_menu_item.dart';

// ============================================================
// DASHBOARD MENU LIST
// ------------------------------------------------------------
// Feature shortcuts. Add a new DashboardMenuItem here whenever
// a new feature screen is ready.
// ============================================================

class DashboardMenuList extends StatelessWidget {
  const DashboardMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardMenuItem(
          title: 'All Employees',
          subtitle: 'View and manage staff',
          icon: Icons.groups_outlined,
          onTap: () => AppNavigation.openAllEmployees(context),
        ),
        SizedBox(height: 10.h),
        DashboardMenuItem(
          title: 'All Patients',
          subtitle: 'View and manage patients',
          icon: Icons.personal_injury_outlined,
          iconColor: AppColors.info,
          onTap: () => AppNavigation.openAllPatients(context),
        ),
        SizedBox(height: 10.h),
        DashboardMenuItem(
          title: 'Reports',
          subtitle: 'Open reports menu',
          icon: Icons.assessment_outlined,
          iconColor: AppColors.warning,
          onTap: () => AppNavigation.openReports(context),
        ),
      ],
    );
  }
}
