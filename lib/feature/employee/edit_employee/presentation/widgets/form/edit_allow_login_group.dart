import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';

// ============================================================
// EDIT ALLOW LOGIN GROUP
// ------------------------------------------------------------
// Yes / No radio for Allow Login (UI only).
// ============================================================

class EditAllowLoginGroup extends StatefulWidget {
  const EditAllowLoginGroup({
    super.key,
    this.initialValue = 'Yes',
  });

  final String initialValue;

  @override
  State<EditAllowLoginGroup> createState() => _EditAllowLoginGroupState();
}

class _EditAllowLoginGroupState extends State<EditAllowLoginGroup> {
  static const _options = ['Yes', 'No'];
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppFieldLabel(label: 'Allow Login?', isRequired: true),
        SizedBox(height: 8.h),
        RadioGroup<String>(
          groupValue: _selected,
          onChanged: (value) {
            if (value == null) return;
            setState(() => _selected = value);
          },
          child: Row(
            children: [
              for (final option in _options) ...[
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
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
