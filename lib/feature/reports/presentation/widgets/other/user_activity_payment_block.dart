import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/entities/user_activity_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/user_activity_payment_line.dart';

// ============================================================
// USER ACTIVITY PAYMENT BLOCK
// ------------------------------------------------------------
// One or more payments from payments_breakdown.
// ============================================================

class UserActivityPaymentBlock extends StatelessWidget {
  const UserActivityPaymentBlock({
    super.key,
    required this.payments,
  });

  final List<UserActivityPaymentEntity> payments;

  static final NumberFormat _money = NumberFormat('#,##0.00', 'en_US');

  static String _pkr(double value) => 'PKR ${_money.format(value)}';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Payment Detail',
            style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6.h),
          if (payments.isEmpty)
            UserActivityPaymentLine(label: 'Amount', value: _pkr(0), bold: true)
          else
            for (var i = 0; i < payments.length; i++) ...[
              if (i > 0) SizedBox(height: 8.h),
              if (payments.length > 1)
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Text(
                    'Payment ${i + 1}',
                    style: AppTextStyles.label.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              UserActivityPaymentLine(
                label: 'Payment Date',
                value: payments[i].date,
              ),
              UserActivityPaymentLine(
                label: 'Method',
                value: payments[i].method,
              ),
              UserActivityPaymentLine(
                label: 'Amount',
                value: _pkr(payments[i].amount),
                bold: true,
              ),
            ],
        ],
      ),
    );
  }
}
