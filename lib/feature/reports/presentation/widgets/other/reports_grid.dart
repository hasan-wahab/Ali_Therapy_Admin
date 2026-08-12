import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_grid_tile.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_type.dart';

// ============================================================
// REPORTS GRID
// ------------------------------------------------------------
// Compact 2-column grid — all items visible without scroll.
// ============================================================

class ReportsGrid extends StatelessWidget {
  const ReportsGrid({
    super.key,
    required this.onReportSelected,
  });

  final ValueChanged<ReportType> onReportSelected;

  @override
  Widget build(BuildContext context) {
    const items = ReportType.values;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 6.h,
        crossAxisSpacing: 6.w,
        // Wider than tall → shorter boxes
        childAspectRatio: 2.15,
      ),
      itemBuilder: (context, index) {
        final type = items[index];
        return ReportGridTile(
          type: type,
          onTap: () => onReportSelected(type),
        );
      },
    );
  }
}
