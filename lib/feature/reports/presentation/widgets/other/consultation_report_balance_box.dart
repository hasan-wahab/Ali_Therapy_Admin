import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_money_line.dart';

// ============================================================
// CONSULTATION REPORT BALANCE BOX
// ------------------------------------------------------------
// Billing breakdown + remaining amount.
// ============================================================

class ConsultationReportBalanceBox extends StatelessWidget {
  const ConsultationReportBalanceBox({
    super.key,
    required this.totalBilled,
    required this.paid,
    required this.discount,
    required this.insurance,
    required this.remaining,
  });

  final String totalBilled;
  final String paid;
  final String discount;
  final String insurance;
  final String remaining;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.softGray,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Remaining Balance',
            style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4.h),
          AppTabletFieldsGrid(
            phoneColumns: 1,
            tabletColumns: 2,
            children: [
              PatientDuesMoneyLine(label: 'Total Billed', value: totalBilled),
              PatientDuesMoneyLine(label: 'Paid', value: paid),
              PatientDuesMoneyLine(label: 'Discount', value: discount),
              PatientDuesMoneyLine(label: 'Insurance', value: insurance),
            ],
          ),
          SizedBox(height: 4.h),
          Divider(height: 1.h, color: AppColors.divider),
          SizedBox(height: 4.h),
          Row(
            children: [
              Text(
                'Remaining',
                style: AppTextStyles.label.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                remaining,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
