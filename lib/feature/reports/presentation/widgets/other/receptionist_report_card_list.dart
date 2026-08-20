import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/entities/receptionist_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/receptionist_report_card.dart';

// ============================================================
// RECEPTIONIST REPORT CARD LIST
// ------------------------------------------------------------
// Builds expandable receptionist cards from API rows.
// ============================================================

class ReceptionistReportCardList extends StatelessWidget {
  const ReceptionistReportCardList({
    super.key,
    required this.rows,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<ReceptionistReportEntity> rows;
  final bool hasMore;
  final bool isLoadingMore;

  static final NumberFormat _money = NumberFormat('#,##0', 'en_US');

  static String pkr(double value) => 'PKR ${_money.format(value)}';

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No receptionist records found',
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
    ReceptionistReportEntity row, {
    required int index,
    required bool initiallyExpanded,
  }) {
    return ReceptionistReportCard(
      initiallyExpanded: initiallyExpanded,
      index: index,
      receptionistName: row.receptionistName,
      patientName: row.patientName,
      visitDate: row.visitDate,
      patientPhone: row.patientPhone,
      patientCnic: row.patientCnic,
      clinic: row.clinicName,
      amountCollected: pkr(row.amountCollected),
    );
  }
}
