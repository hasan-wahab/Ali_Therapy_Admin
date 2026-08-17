import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/utils/app_device.dart';
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
          padding: EdgeInsets.fromLTRB(hPad, vPad, hPad, 28.h),
          child: landscape ? _landscape() : _portrait(),
        ),
      ),
    );
  }

  /// Matches tablet Figma: Overview → Quick Access → Create button.
  Widget _portrait() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const DashboardSectionTitle(title: 'Overview'),
        SizedBox(height: 12.h),
        const DashboardStatsGrid(),
        SizedBox(height: 28.h),
        const DashboardSectionTitle(title: 'Quick Access'),
        SizedBox(height: 12.h),
        const DashboardMenuList(),
        SizedBox(height: 28.h),
        const DashboardCreatePatientButton(),
      ],
    );
  }

  /// Landscape: use width — Overview left, Quick Access + CTA right.
  Widget _landscape() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        SizedBox(width: 24.w),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DashboardSectionTitle(title: 'Quick Access'),
              SizedBox(height: 12.h),
              const DashboardMenuList(),
              SizedBox(height: 24.h),
              const DashboardCreatePatientButton(),
            ],
          ),
        ),
      ],
    );
  }
}
