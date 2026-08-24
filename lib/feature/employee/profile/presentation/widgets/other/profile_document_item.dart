import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_document_action_button.dart';

// ============================================================
// PROFILE DOCUMENT ITEM
// ------------------------------------------------------------
// One document row (thumbnail + title + expiry + actions).
// Tap opens document details.
// ============================================================

class ProfileDocumentItem extends StatelessWidget {
  const ProfileDocumentItem({
    super.key,
    required this.title,
    required this.expiry,
    this.onOpen,
    this.onDelete,
  });

  final String title;
  final String expiry;
  final VoidCallback? onOpen;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.softGray,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(
                  Icons.badge_outlined,
                  color: AppColors.primary,
                  size: AppSizes.iconMd,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.name),
                    SizedBox(height: 4.h),
                    Text('Expiry: $expiry', style: AppTextStyles.bodySmall),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ProfileDocumentActionButton(
                          icon: Icons.open_in_new,
                          color: AppColors.info,
                          onTap: onOpen,
                        ),
                        if (onDelete != null) ...[
                          SizedBox(width: 8.w),
                          ProfileDocumentActionButton(
                            icon: Icons.delete_outline,
                            color: AppColors.error,
                            onTap: onDelete,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
