import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/entities/consultation_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_card.dart';

// ============================================================
// CONSULTATION REPORT CARD LIST
// ------------------------------------------------------------
// Builds expandable consultation cards from API rows.
// ============================================================

class ConsultationReportCardList extends StatelessWidget {
  const ConsultationReportCardList({
    super.key,
    required this.rows,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<ConsultationReportEntity> rows;
  final bool hasMore;
  final bool isLoadingMore;

  static final NumberFormat _money = NumberFormat('#,##0.00', 'en_US');

  static String pkr(double value) => 'PKR ${_money.format(value)}';

  static String _visitDateTime(String raw) {
    final parsed = Helpers.tryParseDate(raw);
    if (parsed == null) return raw;
    return Helpers.formatDateTime(
      parsed,
      pattern: 'MMM dd, yyyy · hh:mm a',
    );
  }

  static String _patientType(String referBy) {
    final cleaned = referBy.trim();
    if (cleaned.endsWith(':')) {
      return cleaned.substring(0, cleaned.length - 1).trim();
    }
    return cleaned;
  }

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No consultation records found',
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
        return _card(rows[index], index: index + 1, initiallyExpanded: index == 0);
      },
    );
  }

  Widget _card(
    ConsultationReportEntity row, {
    required int index,
    required bool initiallyExpanded,
  }) {
    final sessionsSuggested =
        row.isPackageSuggested ? row.sessionsRemaining : 0;

    return ConsultationReportCard(
      initiallyExpanded: initiallyExpanded,
      index: index,
      consultantName: row.consultantName,
      receptionist: row.receptionistName,
      assistantManager: row.assistantManagerName,
      therapist: row.therapistName,
      patientName: row.patientName,
      visitDateTime: _visitDateTime(row.visitDate),
      phone: row.patientPhone,
      clinic: row.clinicName,
      patientType: _patientType(row.referBy),
      totalBilled: pkr(row.totalBilled),
      paid: pkr(row.paidAmount),
      discount: pkr(row.discountAmount),
      insurance: pkr(row.insuranceDiscount),
      remainingBalance: pkr(row.remainingBalance),
      sessionsCompleted: row.sessionsUsed,
      sessionsTotal: row.sessionsTotal,
      sessionsRemaining: row.sessionsRemaining,
      sessionsSuggested: sessionsSuggested,
      reviewDone: row.isReviewDone,
    );
  }
}
