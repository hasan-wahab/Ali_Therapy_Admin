import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PATIENT CAMERA BUTTON
// ------------------------------------------------------------
// Green "Open Camera" button (UI only for now).
// ============================================================

class PatientCameraButton extends StatelessWidget {
  const PatientCameraButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          Icons.camera_alt_outlined,
          size: AppSizes.iconMd,
          color: AppColors.textOnPrimary,
        ),
        label: Text(
          'Open Camera',
          style: AppTextStyles.button,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
          foregroundColor: AppColors.textOnPrimary,
          disabledBackgroundColor: AppColors.success.withValues(alpha: 0.7),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
