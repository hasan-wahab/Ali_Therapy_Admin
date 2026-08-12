import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// APP DROPDOWN FIELD
// ------------------------------------------------------------
// Shared dropdown using dropdown_button2, matched to AppTextField.
// ============================================================

class AppDropdownField extends StatefulWidget {
  const AppDropdownField({
    super.key,
    this.label,
    this.isRequired = false,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
  });

  final String? label;
  final bool isRequired;
  final String hintText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;

  @override
  State<AppDropdownField> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  late final ValueNotifier<String?> _valueListenable;

  @override
  void initState() {
    super.initState();
    final initial = widget.value != null && widget.items.contains(widget.value)
        ? widget.value
        : null;
    _valueListenable = ValueNotifier<String?>(initial);
  }

  @override
  void didUpdateWidget(covariant AppDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      final next = widget.value != null && widget.items.contains(widget.value)
          ? widget.value
          : null;
      _valueListenable.value = next;
    }
  }

  @override
  void dispose() {
    _valueListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final field = DropdownButtonFormField2<String>(
      isExpanded: true,
      valueListenable: _valueListenable,
      decoration: AppTextField.decoration(hintText: widget.hintText).copyWith(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 4.h,
        ),
      ),
      hint: Text(
        widget.hintText,
        style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
        overflow: TextOverflow.ellipsis,
      ),
      style: AppTextStyles.body,
      items: widget.items
          .map(
            (item) => DropdownItem<String>(
              value: item,
              height: 42.h,
              child: Text(
                item,
                style: AppTextStyles.body,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      validator: widget.isRequired
          ? (value) => value == null
              ? 'Please select ${widget.label ?? 'an option'}'
              : null
          : null,
      onChanged: (value) {
        _valueListenable.value = value;
        widget.onChanged?.call(value);
      },
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: AppSizes.iconLg,
          color: AppColors.textMuted,
        ),
        openMenuIcon: Icon(
          Icons.keyboard_arrow_up_rounded,
          size: AppSizes.iconLg,
          color: AppColors.primary,
        ),
        iconSize: AppSizes.iconLg,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 260.h,
        elevation: 4,
        offset: Offset(0, 6.h),
        padding: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.08),
              blurRadius: 16.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        scrollbarTheme: ScrollbarThemeData(
          radius: Radius.circular(8.r),
          thickness: WidgetStateProperty.all(4.w),
          thumbVisibility: WidgetStateProperty.all(true),
          thumbColor: WidgetStateProperty.all(
            AppColors.primary.withValues(alpha: 0.45),
          ),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(
        useDecorationHorizontalPadding: true,
        borderRadius: BorderRadius.circular(10.r),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected) ||
              states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return AppColors.primaryLight;
          }
          return null;
        }),
        selectedMenuItemBuilder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                Expanded(child: child),
                Icon(
                  Icons.check_rounded,
                  size: AppSizes.iconSm,
                  color: AppColors.primary,
                ),
              ],
            ),
          );
        },
      ),
    );

    if (widget.label == null) {
      return field;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFieldLabel(label: widget.label!, isRequired: widget.isRequired),
        SizedBox(height: 8.h),
        field,
      ],
    );
  }
}
