import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';

// ============================================================
// PATIENT RADIO GROUP
// ------------------------------------------------------------
// Horizontal radio options under a label (UI only).
// ============================================================

class PatientRadioGroup extends StatefulWidget {
  const PatientRadioGroup({
    super.key,
    required this.label,
    required this.options,
    this.isRequired = false,
    this.initialValue,
  });

  final String label;
  final List<String> options;
  final bool isRequired;
  final String? initialValue;

  @override
  State<PatientRadioGroup> createState() => _PatientRadioGroupState();
}

class _PatientRadioGroupState extends State<PatientRadioGroup> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue ?? widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFieldLabel(label: widget.label, isRequired: widget.isRequired),
        SizedBox(height: 8.h),
        RadioGroup<String>(
          groupValue: _selected,
          onChanged: (value) {
            if (value == null) return;
            setState(() => _selected = value);
          },
          child: Wrap(
            spacing: 8.w,
            runSpacing: 4.h,
            children: [
              for (final option in widget.options)
                InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () => setState(() => _selected = option),
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
