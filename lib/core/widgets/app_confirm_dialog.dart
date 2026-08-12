import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// APP CONFIRM DIALOG (shared — whole app)
// ------------------------------------------------------------
// Reusable Yes / No / Confirm / Continue / Delete dialog.
//
// Every screen can pass its own:
//   - title, message
//   - cancelLabel / confirmLabel  (No, Cancel, Yes, Confirm, Continue…)
//   - colors + icon
//
// Returns:
//   true  → user pressed confirm
//   false → user pressed cancel
//   null  → dismissed (barrier / back) when allowed
//
// Example (logout):
//   final ok = await showAppConfirmDialog(
//     context: context,
//     title: 'Logout',
//     message: 'Are you sure you want to logout?',
//     confirmLabel: 'Yes',
//     cancelLabel: 'No',
//   );
// ============================================================

class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.help_outline_rounded,
    this.headerColor = AppColors.primary,
    this.cancelLabel = 'No',
    this.confirmLabel = 'Yes',
    this.cancelColor = AppColors.secondary,
    this.confirmColor = AppColors.primary,
    this.barrierDismissible = true,
  });

  final String title;
  final String message;
  final IconData icon;
  final Color headerColor;

  /// Left button text — e.g. No, Cancel.
  final String cancelLabel;

  /// Right button text — e.g. Yes, Confirm, Continue, Delete.
  final String confirmLabel;

  final Color cancelColor;
  final Color confirmColor;
  final bool barrierDismissible;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header (same language as AppFormDialog).
            Container(
              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
              color: headerColor,
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: AppSizes.iconSm,
                    color: AppColors.textOnPrimary,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Message body
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 8.h),
              child: Text(
                message,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
            ),

            Divider(height: 1.h, thickness: 1, color: AppColors.border),

            // Actions
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: TextButton.styleFrom(
                        backgroundColor: cancelColor,
                        foregroundColor: AppColors.textOnPrimary,
                        minimumSize: Size(0, 44.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        cancelLabel,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: confirmColor,
                        foregroundColor: AppColors.textOnPrimary,
                        elevation: 0,
                        minimumSize: Size(0, 44.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        confirmLabel,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Opens [AppConfirmDialog]. Returns `true` only when confirm is pressed.
Future<bool> showAppConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  IconData icon = Icons.help_outline_rounded,
  Color headerColor = AppColors.primary,
  String cancelLabel = 'No',
  String confirmLabel = 'Yes',
  Color cancelColor = AppColors.secondary,
  Color confirmColor = AppColors.primary,
  bool barrierDismissible = true,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AppConfirmDialog(
      title: title,
      message: message,
      icon: icon,
      headerColor: headerColor,
      cancelLabel: cancelLabel,
      confirmLabel: confirmLabel,
      cancelColor: cancelColor,
      confirmColor: confirmColor,
      barrierDismissible: barrierDismissible,
    ),
  );

  return result == true;
}
