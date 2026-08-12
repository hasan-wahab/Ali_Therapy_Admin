import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PROFILE SECTION CARD
// ------------------------------------------------------------
// White card with title, divider, optional + Add, and content.
// ============================================================

class ProfileSectionCard extends StatelessWidget {
  const ProfileSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.onAddTap,
  });

  final String title;
  final Widget child;
  final VoidCallback? onAddTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title, style: AppTextStyles.heading3),
              ),
              if (onAddTap != null)
                TextButton(
                  onPressed: onAddTap,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text('+ Add', style: AppTextStyles.chipPrimary),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          const Divider(color: AppColors.divider, height: 1),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }
}
