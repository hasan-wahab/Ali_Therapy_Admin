import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PROFILE EDUCATION ITEM
// ------------------------------------------------------------
// One education row + optional delete action.
// ============================================================

class ProfileEducationItem extends StatelessWidget {
  const ProfileEducationItem({
    super.key,
    required this.title,
    this.onDelete,
  });

  final String title;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(title, style: AppTextStyles.body),
        ),
        SizedBox(width: 8.w),
        InkWell(
          onTap: onDelete,
          borderRadius: BorderRadius.circular(6.r),
          child: Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: AppColors.error),
            ),
            child: Icon(
              Icons.delete_outline,
              color: AppColors.error,
              size: AppSizes.iconSm,
            ),
          ),
        ),
      ],
    );
  }
}
