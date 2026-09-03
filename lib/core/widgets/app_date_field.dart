import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/core/widgets/app_cupertino_date_picker.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// APP DATE FIELD (shared — whole app)
// ------------------------------------------------------------
// Tappable date field. Opens the shared Cupertino picker.
// Display format: mm/dd/yyyy.
// ============================================================

class AppDateField extends StatefulWidget {
  const AppDateField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.value,
    this.hintText = 'mm/dd/yyyy',
    this.onChanged,
    this.hasError = false,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final bool isRequired;

  /// Controlled value (mm/dd/yyyy). When [onChanged] is set, parent owns it.
  final String? value;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool hasError;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  static final _displayFormat = DateFormat('MM/dd/yyyy');
  String? _localValue;

  String? get _display {
    if (widget.onChanged != null) {
      final raw = widget.value?.trim();
      if (raw == null || raw.isEmpty) return null;
      return raw;
    }
    return _localValue;
  }

  Future<void> _pickDate() async {
    final picked = await showAppCupertinoDatePicker(
      context: context,
      initialDate: _parseDisplay(_display),
      firstDate: widget.firstDate ?? DateTime(1950),
      lastDate: widget.lastDate ?? DateTime(DateTime.now().year + 5, 12, 31),
    );
    if (picked == null) return;
    final text = Helpers.formatDate(picked, pattern: 'MM/dd/yyyy');
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    } else {
      setState(() => _localValue = text);
    }
  }

  DateTime? _parseDisplay(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    try {
      return _displayFormat.parse(raw.trim());
    } catch (_) {
      return DateTime.tryParse(raw.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final display = _display;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFieldLabel(label: widget.label, isRequired: widget.isRequired),
        SizedBox(height: 8.h),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(12.r),
            child: InputDecorator(
              decoration: AppTextField.decoration(
                hintText: widget.hintText,
                hasError: widget.hasError,
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  size: AppSizes.iconSm,
                  color: widget.hasError
                      ? AppColors.error
                      : AppColors.textMuted,
                ),
              ),
              child: Text(
                display ?? widget.hintText,
                style: AppTextStyles.body.copyWith(
                  color: display == null
                      ? AppColors.textMuted
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
