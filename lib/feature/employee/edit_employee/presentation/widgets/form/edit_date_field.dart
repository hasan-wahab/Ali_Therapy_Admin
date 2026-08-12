import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// EDIT DATE FIELD
// ------------------------------------------------------------
// Date-looking field for edit form (picker later).
// ============================================================

class EditDateField extends StatelessWidget {
  const EditDateField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.value,
    this.hintText = 'mm/dd/yyyy',
  });

  final String label;
  final bool isRequired;
  final String? value;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final display = (value != null && value!.trim().isNotEmpty) ? value! : null;

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
            display ?? hintText,
            style: AppTextStyles.body.copyWith(
              color: display == null
                  ? AppColors.textMuted
                  : AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
