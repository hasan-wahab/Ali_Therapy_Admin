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
// compact: true → shorter field for filter panels (same look).
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
    this.enableSearch = false,
    this.searchHintText = 'Search...',
    this.compact = false,
  });

  final String? label;
  final bool isRequired;
  final String hintText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;

  /// Shows a search box at the top of the open menu (like web filters).
  final bool enableSearch;
  final String searchHintText;

  /// Smaller height / gaps for filter panels.
  final bool compact;

  @override
  State<AppDropdownField> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  late final ValueNotifier<String?> _valueListenable;
  final TextEditingController _searchController = TextEditingController();

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
    _searchController.dispose();
    _valueListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compact = widget.compact;
    final textStyle = compact ? AppTextStyles.bodySmall : AppTextStyles.body;
    final iconSize = compact ? AppSizes.iconMd : AppSizes.iconLg;
    final radius = compact ? 10.r : 12.r;

    final field = DropdownButtonFormField2<String>(
      isExpanded: true,
      valueListenable: _valueListenable,
      decoration: AppTextField.decoration(hintText: widget.hintText).copyWith(
        isDense: compact,
        contentPadding: EdgeInsets.symmetric(
          horizontal: compact ? 8.w : 12.w,
          vertical: compact ? 6.h : 4.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5.w),
        ),
      ),
      hint: Text(
        widget.hintText,
        style: textStyle.copyWith(color: AppColors.textMuted),
        overflow: TextOverflow.ellipsis,
      ),
      style: textStyle,
      items: widget.items
          .map(
            (item) => DropdownItem<String>(
              value: item,
              height: compact ? 36.h : 42.h,
              child: Text(
                item,
                style: textStyle,
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
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          _searchController.clear();
        }
      },
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: iconSize,
          color: AppColors.textMuted,
        ),
        openMenuIcon: Icon(
          Icons.keyboard_arrow_up_rounded,
          size: iconSize,
          color: AppColors.primary,
        ),
        iconSize: iconSize,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: compact ? 220.h : 280.h,
        elevation: 4,
        offset: Offset(0, compact ? 4.h : 6.h),
        padding: EdgeInsets.symmetric(vertical: compact ? 4.h : 6.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(compact ? 10.r : 14.r),
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
      dropdownSearchData: widget.enableSearch
          ? DropdownSearchData(
              searchController: _searchController,
              searchBarWidgetHeight: compact ? 44.h : 56.h,
              searchBarWidget: Container(
                height: compact ? 44.h : 56.h,
                padding: EdgeInsets.fromLTRB(
                  8.w,
                  compact ? 4.h : 6.h,
                  8.w,
                  compact ? 4.h : 8.h,
                ),
                child: AppTextField(
                  controller: _searchController,
                  hintText: widget.searchHintText,
                ),
              ),
              noResultsWidget: Padding(
                padding: EdgeInsets.all(compact ? 8.w : 12.w),
                child: Text(
                  'No results found',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                final value = item.value?.toString() ?? '';
                return value.toLowerCase().contains(searchValue.toLowerCase());
              },
            )
          : null,
      menuItemStyleData: MenuItemStyleData(
        useDecorationHorizontalPadding: true,
        borderRadius: BorderRadius.circular(compact ? 8.r : 10.r),
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
              borderRadius: BorderRadius.circular(compact ? 8.r : 10.r),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        AppFieldLabel(label: widget.label!, isRequired: widget.isRequired),
        SizedBox(height: compact ? 3.h : 8.h),
        field,
      ],
    );
  }
}
