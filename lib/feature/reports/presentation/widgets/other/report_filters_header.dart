import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// REPORT FILTERS HEADER
// ------------------------------------------------------------
// Compact "Filters" title row with Reset + Apply actions.
// ============================================================

class ReportFiltersHeader extends StatelessWidget {
  const ReportFiltersHeader({
    super.key,
    this.title = 'Filters',
    this.onReset,
    this.onApply,
    this.applyEnabled = false,
    this.applyLabel = 'Apply',
  });

  final String title;
  final VoidCallback? onReset;
  final VoidCallback? onApply;
  final bool applyEnabled;
  final String applyLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.filter_alt_outlined,
          size: AppSizes.iconSm,
          color: AppColors.primary,
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.label.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
        if (onReset != null)
          TextButton(
            onPressed: onReset,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
              minimumSize: Size(0, 28.h),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            child: Text(
              'Reset',
              style: AppTextStyles.label.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        if (onApply != null)
          TextButton(
            onPressed: applyEnabled ? onApply : null,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              disabledForegroundColor:
                  AppColors.primary.withValues(alpha: 0.45),
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
              minimumSize: Size(0, 28.h),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            child: Text(
              applyLabel,
              style: AppTextStyles.label.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}
