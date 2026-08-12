import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PATIENT LABELED AMOUNT
// ------------------------------------------------------------
// Label on left, amount on right (balance rows).
// ============================================================

class PatientLabeledAmount extends StatelessWidget {
  const PatientLabeledAmount({
    super.key,
    required this.label,
    required this.amount,
    this.amountColor,
    this.isBold = false,
  });

  final String label;
  final String amount;
  final Color? amountColor;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            child: Text(
              amount,
              textAlign: TextAlign.right,
              style: AppTextStyles.bodySmall.copyWith(
                color: amountColor ?? AppColors.textPrimary,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
