import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_step_dot.dart';

// ============================================================
// PATIENT STEP INDICATOR
// ------------------------------------------------------------
// Shows step 1 / 2 / 3 progress for registration.
// ============================================================

class PatientStepIndicator extends StatelessWidget {
  const PatientStepIndicator({
    super.key,
    required this.currentStep,
    required this.labels,
  });

  final int currentStep;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < labels.length; i++) ...[
              if (i > 0)
                Expanded(
                  child: Container(
                    height: 2.h,
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    color: i <= currentStep
                        ? AppColors.primary
                        : AppColors.border,
                  ),
                ),
              PatientStepDot(
                index: i,
                isActive: i == currentStep,
                isDone: i < currentStep,
              ),
            ],
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            for (var i = 0; i < labels.length; i++) ...[
              if (i > 0) SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  labels[i],
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: i == currentStep
                        ? AppColors.primary
                        : AppColors.textMuted,
                    fontWeight:
                        i == currentStep ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
