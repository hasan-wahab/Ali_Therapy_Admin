import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// APP LOADING DIALOG (shared — whole app)
// ------------------------------------------------------------
// ONE professional loading UI for every screen.
// Matches app theme: primary teal, white surface, 12.r radius.
//
// Two ways to use (same look):
//
// 1) Dialog route (API / long jobs):
//      AppLoadingDialog.show(context, message: 'Logging out...');
//      ...
//      AppLoadingDialog.hide(context);
//
// 2) Stack overlay (BlocBuilder AuthLoading):
//      if (isLoading) AppLoadingOverlay(message: 'Logging in...')
//
// UI only — no UseCase / business logic here.
// ============================================================

class AppLoadingDialog {
  AppLoadingDialog._();

  /// Shows the shared loading dialog (blocks back + outside taps).
  static Future<void> show(
    BuildContext context, {
    String message = 'Please wait...',
    String? subtitle,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.textPrimary.withValues(alpha: 0.45),
      builder: (_) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding: EdgeInsets.symmetric(horizontal: 48.w),
            child: AppLoadingCard(
              message: message,
              subtitle: subtitle,
            ),
          ),
        );
      },
    );
  }

  /// Closes the loading dialog if it is still open.
  static void hide(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
    }
  }
}

// ============================================================
// APP LOADING CARD
// ------------------------------------------------------------
// The visual card used by dialog + overlay (same design).
// ============================================================

class AppLoadingCard extends StatelessWidget {
  const AppLoadingCard({
    super.key,
    required this.message,
    this.subtitle,
  });

  final String message;

  /// Optional second line (default: "Please wait").
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final detail = subtitle ?? 'Please wait';

    return Material(
      color: AppColors.surface,
      elevation: 8,
      shadowColor: AppColors.primary.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 260.w,
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 22.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Soft primary ring behind the spinner (brand look).
            Container(
              width: 64.w,
              height: 64.w,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: 28.w,
                height: 28.w,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.primary,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// APP LOADING OVERLAY
// ------------------------------------------------------------
// Same card as [AppLoadingDialog], for Stack / BlocBuilder use.
// Prefer this when the page already rebuilds on a loading state.
// ============================================================

class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({
    super.key,
    required this.message,
    this.subtitle,
  });

  final String message;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: ColoredBox(
        color: AppColors.textPrimary.withValues(alpha: 0.45),
        child: Center(
          child: AppLoadingCard(
            message: message,
            subtitle: subtitle,
          ),
        ),
      ),
    );
  }
}
