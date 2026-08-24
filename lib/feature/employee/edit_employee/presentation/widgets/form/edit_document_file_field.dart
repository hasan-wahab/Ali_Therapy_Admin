import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';

// ============================================================
// EDIT DOCUMENT FILE FIELD
// ------------------------------------------------------------
// Compact preview + Choose File for one document image.
// ============================================================

class EditDocumentFileField extends StatelessWidget {
  const EditDocumentFileField({
    super.key,
    this.fileName,
    this.localBytes,
    this.onChooseFile,
  });

  final String? fileName;
  final List<int>? localBytes;
  final VoidCallback? onChooseFile;

  @override
  Widget build(BuildContext context) {
    final bytes = localBytes;
    final hasLocal = bytes != null && bytes.isNotEmpty;
    final chosenName = fileName?.trim() ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppFieldLabel(label: 'File'),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: hasLocal
                    ? Image.memory(
                        Uint8List.fromList(bytes),
                        width: 44.w,
                        height: 44.w,
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                      )
                    : Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.insert_drive_file_outlined,
                          size: AppSizes.iconMd,
                          color: AppColors.primary,
                        ),
                      ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  chosenName.isNotEmpty ? chosenName : 'No file chosen',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: onChooseFile,
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
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
            ],
          ),
        ),
      ],
    );
  }
}
