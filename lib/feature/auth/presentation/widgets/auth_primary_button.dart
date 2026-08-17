import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_keyboard.dart';

// ============================================================
// AUTH PRIMARY BUTTON
// ------------------------------------------------------------
// Full-width teal button used on auth screens.
// No button spinner here — page uses AppLoadingOverlay when needed.
// ============================================================

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed == null
            ? null
            : () {
                // Close keyboard first, then run the action / loading.
                AppKeyboard.dismiss();
                onPressed!();
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(label, style: AppTextStyles.button),
      ),
    );
  }
}
