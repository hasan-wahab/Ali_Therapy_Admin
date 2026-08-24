import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';

// ============================================================
// EDIT ALLOW LOGIN GROUP
// ------------------------------------------------------------
// Yes / No radio for Allow Login.
// ============================================================

class EditAllowLoginGroup extends StatelessWidget {
  const EditAllowLoginGroup({
    super.key,
    required this.value,
    required this.onChanged,
  });

  /// "Yes" or "No"
  final String value;
  final ValueChanged<String> onChanged;

  static const _options = ['Yes', 'No'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppFieldLabel(label: 'Allow Login?'),
        SizedBox(height: 8.h),
        RadioGroup<String>(
          groupValue: value,
          onChanged: (selected) {
            if (selected == null) return;
            onChanged(selected);
          },
          child: Row(
            children: [
              for (final option in _options) ...[
                InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () => onChanged(option),
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
