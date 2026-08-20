import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/insurance_panel_card.dart';

// ============================================================
// INSURANCE PANEL CARD LIST
// ------------------------------------------------------------
// Builds expandable panel cards from API rows.
// ============================================================

class InsurancePanelCardList extends StatelessWidget {
  const InsurancePanelCardList({
    super.key,
    required this.rows,
  });

  final List<InsurancePanelReportEntity> rows;

  static final NumberFormat _money = NumberFormat('#,##0.00', 'en_US');

  static String pkr(double value) => 'PKR ${_money.format(value)}';

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No insurance panels found',
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
        return InsurancePanelCard(
          initiallyExpanded: index == 0,
          panelName: row.panelName,
          policyType: row.policyType,
          totalInvoices: row.totalInvoices,
          consultationBilled: pkr(row.consultationBilled),
          packageBilled: pkr(row.packageBilled),
          totalBilled: pkr(row.totalBilled),
          totalCovered: pkr(row.totalCovered),
          totalPaidCash: pkr(row.totalPaidCash),
          outstandingBalance: pkr(row.outstandingBalance),
        );
      },
    );
  }
}
