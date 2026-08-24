import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_permission.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_create_patient_button.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_menu_list.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_section_title.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_stats_grid.dart';

// ============================================================
// DASHBOARD TABLET BODY
// ------------------------------------------------------------
// Tablet-only Home layout (iPad Pro 11" base: 834×1194).
// Mobile Home body is separate and must not be changed.
// Portrait: centered column (Figma).
// Landscape: Overview | Quick Access side by side.
// ============================================================

class DashboardTabletBody extends StatelessWidget {
  const DashboardTabletBody({super.key});

  @override
  Widget build(BuildContext context) {
    final landscape = AppDevice.isLandscape(context);
    final maxWidth = AppDevice.contentMaxWidth(context);
    final hPad = landscape ? 40.w : 56.w;
    final vPad = landscape ? 12.h : 16.h;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          padding: EdgeInsets.fromLTRB(hPad, vPad, hPad, 28.h),
          child: landscape ? _landscape() : _portrait(),
        ),
      ),
    );
  }

  /// Matches tablet Figma: Overview → Quick Access → Create button.
  Widget _portrait() {
    final showOverview = AppPermission.canViewDashboardOverview;
    final showQuickAccess = AppPermission.canViewQuickAccess;
    final showCreate = AppPermission.canAddPatient;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showOverview) ...[
          const DashboardSectionTitle(title: 'Overview'),
          SizedBox(height: 12.h),
          const DashboardStatsGrid(),
          if (showQuickAccess || showCreate) SizedBox(height: 28.h),
        ],
        if (showQuickAccess) ...[
          const DashboardSectionTitle(title: 'Quick Access'),
          SizedBox(height: 12.h),
          const DashboardMenuList(),
          if (showCreate) SizedBox(height: 28.h),
        ],
        if (showCreate) const DashboardCreatePatientButton(),
      ],
    );
  }

  /// Landscape: use width — Overview left, Quick Access + CTA right.
  Widget _landscape() {
    final showOverview = AppPermission.canViewDashboardOverview;
    final showQuickAccess = AppPermission.canViewQuickAccess;
    final showCreate = AppPermission.canAddPatient;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showOverview)
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DashboardSectionTitle(title: 'Overview'),
                SizedBox(height: 12.h),
                const DashboardStatsGrid(),
              ],
            ),
          ),
        if (showOverview && (showQuickAccess || showCreate))
          SizedBox(width: 24.w),
        if (showQuickAccess || showCreate)
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showQuickAccess) ...[
                  const DashboardSectionTitle(title: 'Quick Access'),
                  SizedBox(height: 12.h),
                  const DashboardMenuList(),
                  if (showCreate) SizedBox(height: 24.h),
                ],
                if (showCreate) const DashboardCreatePatientButton(),
              ],
            ),
          ),
      ],
    );
  }
}
