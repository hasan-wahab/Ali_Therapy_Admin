import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// INSURANCE PANEL TOTAL BUTTON
// ------------------------------------------------------------
// Opens the totals card above the panel list.
// ============================================================

class InsurancePanelTotalButton extends StatelessWidget {
  const InsurancePanelTotalButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(
          Icons.summarize_outlined,
          size: AppSizes.iconSm,
          color: AppColors.textOnPrimary,
        ),
        label: Text(
          'Total',
          style: AppTextStyles.body.copyWith(
            color: AppColors.textOnPrimary,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
