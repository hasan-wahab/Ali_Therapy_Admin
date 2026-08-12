import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// PATIENT DATE FIELD
// ------------------------------------------------------------
// Date-looking field (picker action comes later).
// ============================================================

class PatientDateField extends StatelessWidget {
  const PatientDateField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.hintText = 'mm/dd/yyyy',
  });

  final String label;
  final bool isRequired;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFieldLabel(label: label, isRequired: isRequired),
        SizedBox(height: 8.h),
        InputDecorator(
          decoration: AppTextField.decoration(
            hintText: hintText,
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              size: AppSizes.iconSm,
              color: AppColors.textMuted,
            ),
          ),
          child: Text(
            hintText,
            style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
          ),
        ),
      ],
    );
  }
}
