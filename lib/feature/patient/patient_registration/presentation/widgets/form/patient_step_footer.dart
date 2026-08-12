import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PATIENT STEP FOOTER
// ------------------------------------------------------------
// Back + Next / Register Patient actions.
// ============================================================

class PatientStepFooter extends StatelessWidget {
  const PatientStepFooter({
    super.key,
    required this.isFirstStep,
    required this.isLastStep,
    required this.onBack,
    required this.onNext,
    required this.onRegister,
    this.submitLabel = 'Register Patient',
  });

  final bool isFirstStep;
  final bool isLastStep;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onRegister;
  final String submitLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: TextButton(
              onPressed: isFirstStep ? null : onBack,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.softGray,
                foregroundColor: AppColors.textPrimary,
                disabledForegroundColor: AppColors.textMuted,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Back',
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: ElevatedButton(
              onPressed: isLastStep ? onRegister : onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                isLastStep ? submitLabel : 'Next',
                style: AppTextStyles.button,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
