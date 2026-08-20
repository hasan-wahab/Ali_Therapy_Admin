import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/free_consultation_report_domain/entities/free_consultation_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/free_consultation_report_card.dart';

// ============================================================
// FREE CONSULTATION REPORT CARD LIST
// ------------------------------------------------------------
// Builds expandable free consultation cards from API rows.
// ============================================================

class FreeConsultationReportCardList extends StatelessWidget {
  const FreeConsultationReportCardList({
    super.key,
    required this.rows,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<FreeConsultationReportEntity> rows;
  final bool hasMore;
  final bool isLoadingMore;

  static final NumberFormat _money = NumberFormat('#,##0.00', 'en_US');

  static String pkr(double value) => 'PKR ${_money.format(value)}';

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No free consultation records found',
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
    FreeConsultationReportEntity row, {
    required int index,
    required bool initiallyExpanded,
  }) {
    return FreeConsultationReportCard(
      initiallyExpanded: initiallyExpanded,
      index: index,
      consultantName: row.consultantName,
      patientName: row.patientName,
      visitDate: row.visitDate,
      patientPhone: row.patientPhone,
      clinic: row.clinicName,
      fee: pkr(row.fee),
    );
  }
}
