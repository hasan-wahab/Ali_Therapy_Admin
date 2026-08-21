import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/discount_report_card.dart';

// ============================================================
// DISCOUNT REPORT CARD LIST
// ------------------------------------------------------------
// Builds expandable discount cards from API rows.
// ============================================================

class DiscountReportCardList extends StatelessWidget {
  const DiscountReportCardList({
    super.key,
    required this.rows,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<DiscountReportEntity> rows;
  final bool hasMore;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No discount records found',
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
        final row = rows[index];
        return DiscountReportCard(
          initiallyExpanded: index == 0,
          patientName: row.patientName,
          phone: row.patientPhone,
          cnic: row.patientCnic,
          clinic: row.clinicName,
          consultantName: row.consultantName,
          receptionistName: row.receptionistName,
          grossBilled: row.grossAmount,
          discountAmount: row.totalDiscount,
          discountPercent: row.discountPercent,
          netAmount: row.netAmount,
          status: row.paymentStatus,
        );
      },
    );
  }
}
