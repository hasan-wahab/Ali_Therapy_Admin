import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';

// ============================================================
// APP SNACKBAR (simple + reusable)
// ------------------------------------------------------------
// Error snackbars show TITLE + message so users know what failed.
// Errors are also printed to the console via AppErrorLogger.
// ============================================================

class AppSnackbar {
  AppSnackbar._();

  static void success(BuildContext context, String message) {
    _show(
      context,
      title: 'Success',
      message: message,
      backgroundColor: AppColors.success,
    );
  }

  /// Show an error with a clear title + message.
  /// Prefer [errorFromFailure] when you have a Failure object.
  static void error(
    BuildContext context,
    String message, {
    String title = 'Error',
    String? debugDetail,
  }) {
    AppErrorLogger.log(
      title: title,
      message: message,
      detail: debugDetail,
      where: 'AppSnackbar.error',
    );
    _show(
      context,
      title: title,
      message: message,
      backgroundColor: AppColors.error,
    );
  }

  /// Best way: pass the Failure from BLoC (has title + message).
  /// Also prints the error block in the console.
  static void errorFromFailure(BuildContext context, Failure failure) {
    AppErrorLogger.logFailure(failure, where: 'UI Snackbar');
    _show(
      context,
      title: failure.title,
      message: failure.message,
      backgroundColor: AppColors.error,
    );
  }

  static void info(BuildContext context, String message) {
    _show(
      context,
      title: 'Info',
      message: message,
      backgroundColor: AppColors.info,
    );
  }

  static void warning(BuildContext context, String message) {
    _show(
      context,
      title: 'Warning',
      message: message,
      backgroundColor: AppColors.warning,
    );
  }

  static void _show(
    BuildContext context, {
    required String title,
    required String message,
    required Color backgroundColor,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              message,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textOnPrimary,
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
