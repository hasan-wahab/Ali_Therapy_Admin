import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/entities/refer_by_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/refer_by_card.dart';

// ============================================================
// REFER BY CARD LIST
// ------------------------------------------------------------
// Builds expandable referral-source cards from API rows.
// ============================================================

class ReferByCardList extends StatelessWidget {
  const ReferByCardList({
    super.key,
    required this.rows,
  });

  final List<ReferByReportEntity> rows;

  static final NumberFormat _money = NumberFormat('#,##0.00', 'en_US');

  static String pkr(double value) => 'PKR ${_money.format(value)}';

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No referral records found',
            style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
          ),
        ),
      );
    }

    return SliverList.separated(
      itemCount: rows.length,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final row = rows[index];
        return ReferByCard(
          initiallyExpanded: index == 0,
          referralSource: row.referralSource,
          referralType: row.referralType,
          patientCount: row.patientCount,
          grossBilled: pkr(row.grossBilled),
          consultation: pkr(row.consultation),
          packageBilled: pkr(row.packageBilled),
          directDiscount: pkr(row.directDiscount),
          insuranceDiscount: pkr(row.insuranceDiscount),
          packagePaid: pkr(row.packagePaid),
          totalReceived: pkr(row.totalReceived),
          dues: pkr(row.dues),
        );
      },
    );
  }
}
