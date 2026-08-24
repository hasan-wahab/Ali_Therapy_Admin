import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';
import 'package:ali_therapy_admin/core/widgets/app_network_avatar.dart';

// ============================================================
// EDIT PROFILE PICTURE FIELD
// ------------------------------------------------------------
// Shows current employee photo. Choose File replaces it locally
// until Submit sends profile_picture.
// ============================================================

class EditProfilePictureField extends StatelessWidget {
  const EditProfilePictureField({
    super.key,
    this.imageUrl,
    this.localBytes,
    this.fileName,
    this.onChooseFile,
  });

  final String? imageUrl;
  final List<int>? localBytes;
  final String? fileName;
  final VoidCallback? onChooseFile;

  @override
  Widget build(BuildContext context) {
    final bytes = localBytes;
    final hasLocal = bytes != null && bytes.isNotEmpty;
    final chosenName = fileName?.trim() ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppFieldLabel(label: 'Profile Picture'),
        SizedBox(height: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasLocal)
              ClipOval(
                child: Image.memory(
                  Uint8List.fromList(bytes),
                  width: 64.r,
                  height: 64.r,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
              )
            else
              AppNetworkAvatar(
                imageUrl: imageUrl,
                radius: 32.r,
                iconSize: AppSizes.iconXl,
              ),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: onChooseFile,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softGray,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Choose File',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        chosenName.isNotEmpty
                            ? chosenName
                            : (imageUrl != null && imageUrl!.trim().isNotEmpty
                                ? 'Current photo'
                                : 'No file chosen'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
