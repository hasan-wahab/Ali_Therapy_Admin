import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';

// ============================================================
// EDIT ROLE FIELD
// ------------------------------------------------------------
// Role dropdown. Selected roles show as chips.
// ============================================================

class EditRoleField extends StatelessWidget {
  const EditRoleField({
    super.key,
    required this.options,
    required this.selected,
    required this.onAdd,
    required this.onRemove,
  });

  final List<String> options;
  final List<String> selected;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    final available = options.where((role) => !selected.contains(role)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppFieldLabel(label: 'Role'),
        SizedBox(height: 8.h),
        if (selected.isNotEmpty) ...[
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: [
              for (final role in selected)
                Container(
                  padding: EdgeInsets.fromLTRB(10.w, 5.h, 6.w, 5.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        role,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      InkWell(
                        onTap: () => onRemove(role),
                        borderRadius: BorderRadius.circular(12.r),
                        child: Icon(
                          Icons.close_rounded,
                          size: AppSizes.iconSm - 4.sp,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
        if (available.isEmpty)
          Text(
            selected.isEmpty ? 'No roles available' : 'All roles selected',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          )
        else
          AppDropdownField(
            key: ValueKey(available.join('|')),
            hintText: 'Select Role',
            items: available,
            onChanged: (role) {
              if (role == null) return;
              onAdd(role);
            },
          ),
      ],
    );
  }
}
