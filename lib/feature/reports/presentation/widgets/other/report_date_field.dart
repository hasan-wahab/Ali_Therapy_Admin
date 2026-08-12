import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// REPORT DATE FIELD
// ------------------------------------------------------------
// Labeled date field for report filters (UI only).
// ============================================================

class ReportDateField extends StatelessWidget {
  const ReportDateField({
    super.key,
    required this.label,
    required this.valueText,
  });

  final String label;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFieldLabel(label: label),
        SizedBox(height: 6.h),
        InputDecorator(
          decoration: AppTextField.decoration(
            hintText: label,
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              size: AppSizes.iconSm,
              color: AppColors.textMuted,
            ),
          ),
          child: Text(
            valueText,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
