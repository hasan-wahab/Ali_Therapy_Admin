import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_history_item.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_history_tablet_header.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_history_tablet_row.dart';

// ============================================================
// RECONSULTATION HISTORY TABLET BODY
// ------------------------------------------------------------
// Tablet-only table: header + rows. Mobile stays on cards.
// ============================================================

class ReconsultationHistoryTabletBody extends StatelessWidget {
  const ReconsultationHistoryTabletBody({
    super.key,
    required this.items,
    required this.onViewReport,
  });

  final List<ReconsultationHistoryItem> items;
  final ValueChanged<ReconsultationHistoryItem> onViewReport;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(0, 8.h, 0, 24.h),
      children: [
        Text(
          items.length == 1
              ? '1 reconsultation'
              : '${items.length} reconsultations',
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        if (items.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Center(
              child: Text(
                'No reconsultations found',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                const ReconsultationHistoryTabletHeader(),
                ...List.generate(items.length, (index) {
                  final item = items[index];
                  return ReconsultationHistoryTabletRow(
                    item: item,
                    onViewReport: () => onViewReport(item),
                    showBottomDivider: index != items.length - 1,
                  );
                }),
              ],
            ),
          ),
      ],
    );
  }
}
