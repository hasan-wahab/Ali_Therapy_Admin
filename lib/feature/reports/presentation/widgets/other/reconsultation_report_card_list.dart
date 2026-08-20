import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/entities/reconsultation_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/reconsultation_report_card.dart';

// ============================================================
// RECONSULTATION REPORT CARD LIST
// ------------------------------------------------------------
// Builds expandable reconsultation cards from API rows.
// ============================================================

class ReconsultationReportCardList extends StatelessWidget {
  const ReconsultationReportCardList({
    super.key,
    required this.rows,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<ReconsultationReportEntity> rows;
  final bool hasMore;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No reconsultation records found',
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
    ReconsultationReportEntity row, {
    required int index,
    required bool initiallyExpanded,
  }) {
    return ReconsultationReportCard(
      initiallyExpanded: initiallyExpanded,
      index: index,
      consultantName: row.consultantName,
      patientName: row.patientName,
      visitDate: row.visitDate,
      patientPhone: row.patientPhone,
      clinic: row.clinicName,
    );
  }
}
