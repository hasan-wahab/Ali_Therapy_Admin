import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PATIENT BALANCE ROW
// ------------------------------------------------------------
// One line in Remaining Balance (label + amount).
// ============================================================

class PatientBalanceRow extends StatelessWidget {
  const PatientBalanceRow({
    super.key,
    required this.label,
    required this.amount,
    this.isHighlight = false,
    this.amountColor,
  });

  final String label;
  final String amount;
  final bool isHighlight;
  final Color? amountColor;

  @override
  Widget build(BuildContext context) {
    final color = amountColor ??
        (isHighlight ? AppColors.success : AppColors.textPrimary);

    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: isHighlight ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Flexible(
            child: Text(
              amount,
              style: AppTextStyles.bodySmall.copyWith(
                color: color,
                fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
