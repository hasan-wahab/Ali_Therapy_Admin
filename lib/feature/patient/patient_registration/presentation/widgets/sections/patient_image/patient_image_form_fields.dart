import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_camera_button.dart';

// ============================================================
// PATIENT IMAGE FORM FIELDS
// ------------------------------------------------------------
// Step 3 — patient photo capture (UI only).
// ============================================================

class PatientImageFormFields extends StatelessWidget {
  const PatientImageFormFields({super.key});

  @override
  Widget build(BuildContext context) {
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
                'No photo selected yet',
                style: AppTextStyles.bodySmall,
              ),
              SizedBox(height: 18.h),
              PatientCameraButton(
                onPressed: () {
                  AppSnackbar.info(
                    context,
                    'Camera will be connected later.',
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
