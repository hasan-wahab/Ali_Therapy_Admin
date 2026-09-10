import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';

// ============================================================
// PATIENT RADIO GROUP
// ------------------------------------------------------------
// Horizontal radio options under a label.
// ============================================================

class PatientRadioGroup extends StatefulWidget {
  const PatientRadioGroup({
    super.key,
    required this.label,
    required this.options,
    this.isRequired = false,
    this.value,
    this.onChanged,
  });

  final String label;
  final List<String> options;
  final bool isRequired;
  final String? value;
  final ValueChanged<String>? onChanged;

  @override
  State<PatientRadioGroup> createState() => _PatientRadioGroupState();
}

class _PatientRadioGroupState extends State<PatientRadioGroup> {
  String _selected = '';

  @override
  void initState() {
    super.initState();
    _selected = _resolveSelection();
  }

  @override
  void didUpdateWidget(covariant PatientRadioGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.options != oldWidget.options ||
        widget.value != oldWidget.value) {
      final next = _resolveSelection();
      if (next != _selected) {
        _selected = next;
      }
    }
  }

  String get _groupValue {
    final controlled = widget.value?.trim() ?? '';
    if (controlled.isNotEmpty) return controlled;
    return _selected;
  }

  String _resolveSelection() {
    final initial = widget.value;
    if (initial != null && widget.options.contains(initial)) {
      return initial;
    }
    if (widget.onChanged != null) {
      return '';
    }
    if (_selected.isNotEmpty && widget.options.contains(_selected)) {
      return _selected;
    }
    return widget.options.isNotEmpty ? widget.options.first : '';
  }

  void _select(String option) {
    if (widget.onChanged != null) {
      widget.onChanged!(option);
      return;
    }
    setState(() => _selected = option);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFieldLabel(label: widget.label, isRequired: widget.isRequired),
        SizedBox(height: 8.h),
        RadioGroup<String>(
          groupValue: _groupValue,
          onChanged: (value) {
            if (value == null) return;
            _select(value);
          },
          child: Wrap(
            spacing: 8.w,
            runSpacing: 4.h,
            children: [
              for (final option in widget.options)
                InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () => _select(option),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<String>(
                        value: option,
                        activeColor: AppColors.primary,
                      ),
                      Text(option, style: AppTextStyles.body),
                      SizedBox(width: 4.w),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
