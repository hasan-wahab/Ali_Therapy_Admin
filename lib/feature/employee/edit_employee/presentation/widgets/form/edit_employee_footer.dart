import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// EDIT EMPLOYEE FOOTER
// ------------------------------------------------------------
// Back / Close + Next / Update for section steps.
// ============================================================

class EditEmployeeFooter extends StatelessWidget {
  const EditEmployeeFooter({
    super.key,
    required this.isFirstStep,
    required this.isLastStep,
    required this.onBack,
    required this.onNext,
  });

  final bool isFirstStep;
  final bool isLastStep;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: TextButton(
              onPressed: onBack,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.softGray,
                foregroundColor: AppColors.textPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                isFirstStep ? 'Close' : 'Back',
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 48.h,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                isLastStep ? 'Submit' : 'Next',
                style: AppTextStyles.button,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
