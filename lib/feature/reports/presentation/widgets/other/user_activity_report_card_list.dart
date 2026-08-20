import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/entities/user_activity_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/user_activity_report_card.dart';

// ============================================================
// USER ACTIVITY REPORT CARD LIST
// ------------------------------------------------------------
// Builds expandable activity cards from API rows.
// ============================================================

class UserActivityReportCardList extends StatelessWidget {
  const UserActivityReportCardList({
    super.key,
    required this.rows,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<UserActivityReportEntity> rows;
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
            'No user activity records found',
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
        return UserActivityReportCard(
          initiallyExpanded: index == 0,
          index: index + 1,
          patientName: row.patientName,
          cnic: row.patientCnic,
          packageName: row.packageName,
          sessionsUsed: row.sessionsUsed,
          sessionsTotal: row.sessionsTotal,
          remaining: row.remaining,
          invoiceType: row.invoiceType,
          paymentDate: row.paymentDate,
          paymentMethod: row.paymentMethod,
          amount: pkr(row.amount),
        );
      },
    );
  }
}
