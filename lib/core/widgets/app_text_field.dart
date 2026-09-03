import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';

// ============================================================
// APP TEXT FIELD
// ------------------------------------------------------------
// ONE reusable text field for the whole app.
// Pass only what you need — label above, floating label,
// icons, password, multiline, validator, etc.
//
// Examples:
//   AppTextField(label: 'Title')
//   AppTextField(labelText: 'Email', prefixIcon: Icon(...), validator: ...)
// ============================================================

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.label,
    this.isRequired = false,
    this.labelText,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.hasError = false,
  });

  /// Label drawn ABOVE the field (profile forms style).
  final String? label;

  /// Shows a red * next to [label].
  final bool isRequired;

  /// Floating / Material label inside the border (login style).
  final String? labelText;

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;

  /// Red border only — used by edit-employee step validation.
  final bool hasError;

  /// TextField crashes if fontSize is 0 (Android first frame).
  TextStyle get _safeBodyStyle {
    final style = AppTextStyles.body;
    final size = style.fontSize;
    if (size == null || size <= 0) {
      return style.copyWith(fontSize: 14);
    }
    return style;
  }

  /// Shared rounded InputDecoration for text / date / similar fields.
  static InputDecoration decoration({
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool hasError = false,
  }) {
    final radius = BorderRadius.circular(12.r);
    final normal = OutlineInputBorder(
      borderRadius: radius,
      borderSide: const BorderSide(color: AppColors.border),
    );
    final focused = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: AppColors.primary, width: 1.5.w),
    );
    final error = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: AppColors.error, width: 1.5.w),
    );
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: AppTextStyles.body.copyWith(color: AppColors.textMuted),
      labelStyle: AppTextStyles.bodySmall,
      filled: true,
      fillColor: AppColors.surface,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      border: hasError ? error : normal,
      enabledBorder: hasError ? error : normal,
      focusedBorder: hasError ? error : focused,
      errorBorder: error,
      focusedErrorBorder: error,
      disabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: AppColors.border),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      textInputAction: textInputAction,
      style: _safeBodyStyle,
      strutStyle: StrutStyle.fromTextStyle(_safeBodyStyle),
      decoration: decoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hasError: hasError,
      ),
    );

    if (label == null) {
      return field;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFieldLabel(label: label!, isRequired: isRequired),
        SizedBox(height: 8.h),
        field,
      ],
    );
  }
}
