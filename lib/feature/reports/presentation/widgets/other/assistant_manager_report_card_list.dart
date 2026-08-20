import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/assistant_manager_report_card.dart';

// ============================================================
// ASSISTANT MANAGER REPORT CARD LIST
// ------------------------------------------------------------
// Builds expandable AM cards from API rows.
// ============================================================

class AssistantManagerReportCardList extends StatelessWidget {
  const AssistantManagerReportCardList({
    super.key,
    required this.rows,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<AssistantManagerReportEntity> rows;
  final bool hasMore;
  final bool isLoadingMore;

  static String _stageLabel(String stage) {
    if (stage.isEmpty) return stage;
    return stage[0].toUpperCase() + stage.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No assistant manager records found',
            style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
          ),
        ),
      );
    }

    final extra = hasMore ? 1 : 0;

    return SliverList.separated(
      itemCount: rows.length + extra,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        if (index == rows.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: isLoadingMore
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink(),
            ),
          );
        }
        return _card(
          rows[index],
          index: index + 1,
          initiallyExpanded: index == 0,
        );
      },
    );
  }

  Widget _card(
    AssistantManagerReportEntity row, {
    required int index,
    required bool initiallyExpanded,
  }) {
    return AssistantManagerReportCard(
      initiallyExpanded: initiallyExpanded,
      index: index,
      assistantManagerName: row.assistantManagerName,
      patientName: row.patientName,
      visitDate: row.visitDate,
      patientPhone: row.patientPhone,
      clinic: row.clinicName,
      type: _stageLabel(row.stage),
      consultantName: row.consultantName,
    );
  }
}
