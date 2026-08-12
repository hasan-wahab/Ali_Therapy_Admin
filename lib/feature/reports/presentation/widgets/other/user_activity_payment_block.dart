import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/user_activity_payment_line.dart';

// ============================================================
// USER ACTIVITY PAYMENT BLOCK
// ------------------------------------------------------------
// Payment date, method, and amount.
// ============================================================

class UserActivityPaymentBlock extends StatelessWidget {
  const UserActivityPaymentBlock({
    super.key,
    required this.paymentDate,
    required this.method,
    required this.amount,
  });

  final String paymentDate;
  final String method;
  final String amount;

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
          UserActivityPaymentLine(label: 'Payment Date', value: paymentDate),
          UserActivityPaymentLine(label: 'Method', value: method),
          UserActivityPaymentLine(label: 'Amount', value: amount, bold: true),
        ],
      ),
    );
  }
}
