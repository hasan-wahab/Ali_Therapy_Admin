import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PATIENT DUES MONEY LINE
// ------------------------------------------------------------
// Label + amount row inside a dues card.
// ============================================================

class PatientDuesMoneyLine extends StatelessWidget {
  const PatientDuesMoneyLine({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.bold = false,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: AppSizes.iconSm,
              color: iconColor ?? AppColors.textMuted,
            ),
            SizedBox(width: 6.w),
          ],
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
