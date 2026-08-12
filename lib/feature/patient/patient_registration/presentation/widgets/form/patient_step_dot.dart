import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PATIENT STEP DOT
// ------------------------------------------------------------
// Circle number / check mark for the step indicator.
// ============================================================

class PatientStepDot extends StatelessWidget {
  const PatientStepDot({
    super.key,
    required this.index,
    required this.isActive,
    required this.isDone,
  });

  final int index;
  final bool isActive;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    final filled = isActive || isDone;

    return Container(
      width: 28.w,
      height: 28.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? AppColors.primary : AppColors.surface,
        border: Border.all(
          color: filled ? AppColors.primary : AppColors.border,
          width: 1.5.w,
        ),
      ),
      child: isDone
          ? Icon(
              Icons.check,
              size: AppSizes.iconSm,
              color: AppColors.textOnPrimary,
            )
          : Text(
              '${index + 1}',
              style: AppTextStyles.bodySmall.copyWith(
                color: filled ? AppColors.textOnPrimary : AppColors.textMuted,
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}
