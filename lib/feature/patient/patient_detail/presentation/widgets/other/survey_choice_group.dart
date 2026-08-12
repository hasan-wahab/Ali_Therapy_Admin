import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// SURVEY CHOICE GROUP
// ------------------------------------------------------------
// Read-only choice chips; selected answer uses primary fill.
// ============================================================

class SurveyChoiceGroup extends StatelessWidget {
  const SurveyChoiceGroup({
    super.key,
    required this.options,
    required this.selected,
  });

  final List<String> options;
  final String selected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children: [
        for (final option in options)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: option == selected
                  ? AppColors.primary
                  : AppColors.softGray,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: option == selected
                    ? AppColors.primary
                    : AppColors.border,
              ),
            ),
            child: Text(
              option,
              style: AppTextStyles.label.copyWith(
                color: option == selected
                    ? AppColors.textOnPrimary
                    : AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}
