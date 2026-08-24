import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';

// ============================================================
// REPORT STATS CARDS GRID
// ------------------------------------------------------------
// Compact Show Stats layout:
//   phone / tablet portrait → 2 columns
//   tablet landscape        → 4 columns
// Tall cards (e.g. User Activity) pass phoneColumns: 1.
// ============================================================

class ReportStatsCardsGrid extends StatelessWidget {
  const ReportStatsCardsGrid({
    super.key,
    required this.children,
    this.phoneColumns = 2,
    this.tabletPortraitColumns = 2,
    this.tabletLandscapeColumns = 4,
  });

  final List<Widget> children;
  final int phoneColumns;
  final int tabletPortraitColumns;
  final int tabletLandscapeColumns;

  @override
  Widget build(BuildContext context) {
    final tabletColumns = AppDevice.isLandscape(context)
        ? tabletLandscapeColumns
        : tabletPortraitColumns;

    return AppTabletFieldsGrid(
      phoneColumns: phoneColumns,
      tabletColumns: tabletColumns,
      gapW: 6.w,
      gapH: 6.h,
      children: children,
    );
  }
}
