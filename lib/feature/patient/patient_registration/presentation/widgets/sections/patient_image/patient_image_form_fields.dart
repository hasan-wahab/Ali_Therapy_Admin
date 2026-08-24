import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_camera_button.dart';

// ============================================================
// PATIENT IMAGE FORM FIELDS
// ------------------------------------------------------------
// Step 3 — patient photo (camera or gallery).
// ============================================================

class PatientImageFormFields extends StatelessWidget {
  const PatientImageFormFields({
    super.key,
    this.photoBytes,
    this.fileName,
    this.onPickCamera,
    this.onPickGallery,
  });

  final List<int>? photoBytes;
  final String? fileName;
  final VoidCallback? onPickCamera;
  final VoidCallback? onPickGallery;

  @override
  Widget build(BuildContext context) {
    final bytes = photoBytes;
    final hasPhoto = bytes != null && bytes.isNotEmpty;
    final chosenName = fileName?.trim() ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppFieldLabel(label: 'Patient Image'),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              if (hasPhoto)
                ClipOval(
                  child: Image.memory(
                    Uint8List.fromList(bytes),
                    width: 96.w,
                    height: 96.w,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                )
              else
                Container(
                  width: 96.w,
                  height: 96.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: AppSizes.iconXl,
                    color: AppColors.primary,
                  ),
                ),
              SizedBox(height: 12.h),
              Text(
                hasPhoto
                    ? (chosenName.isNotEmpty ? chosenName : 'Photo selected')
                    : 'No photo selected yet',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall,
              ),
              SizedBox(height: 18.h),
              PatientCameraButton(onPressed: onPickCamera),
              SizedBox(height: 10.h),
              InkWell(
                onTap: onPickGallery,
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
