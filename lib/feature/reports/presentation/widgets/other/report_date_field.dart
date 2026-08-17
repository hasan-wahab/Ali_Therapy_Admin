import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// REPORT DATE FIELD
// ------------------------------------------------------------
// Compact labeled date field for filter panels.
// ============================================================

class ReportDateField extends StatelessWidget {
  const ReportDateField({
    super.key,
    required this.label,
    this.valueText,
    this.onTap,
    this.hintText = 'mm/dd/yyyy',
  });

  final String label;

  /// Display value; empty / null shows [hintText].
  final String? valueText;
  final VoidCallback? onTap;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final hasValue = valueText != null && valueText!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppFieldLabel(label: label),
        SizedBox(height: 3.h),
        Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10.r),
            child: InputDecorator(
              decoration: AppTextField.decoration(
                hintText: hintText,
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  size: AppSizes.iconSm,
                  color: AppColors.textMuted,
                ),
              ).copyWith(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 8.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 1.5.w,
                  ),
                ),
              ),
              child: Text(
                hasValue ? valueText! : hintText,
                style: AppTextStyles.bodySmall.copyWith(
                  color: hasValue
                      ? AppColors.textPrimary
                      : AppColors.textMuted,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Shared date picker → mm/dd/yyyy.
  static Future<String?> pickDate(
    BuildContext context, {
    DateTime? initialDate,
  }) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 5),
    );
    if (picked == null) return null;
    return Helpers.formatDate(picked, pattern: 'MM/dd/yyyy');
  }
}
