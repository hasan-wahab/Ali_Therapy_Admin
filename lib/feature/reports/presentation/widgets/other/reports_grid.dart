import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_grid_tile.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_type.dart';

// ============================================================
// REPORTS GRID
// ------------------------------------------------------------
// Compact 2-column grid — tiles follow login permissions.
// ============================================================

class ReportsGrid extends StatelessWidget {
  const ReportsGrid({
    super.key,
    required this.onReportSelected,
  });

  final ValueChanged<ReportType> onReportSelected;

  @override
  Widget build(BuildContext context) {
    final items = ReportType.values.where((type) => type.isPermitted).toList();

    if (items.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 24.h),
        child: Center(
          child: Text(
            'No reports available',
            style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
          ),
        ),
      );
    }

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
