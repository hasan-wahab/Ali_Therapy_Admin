import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// APP FORM DIALOG
// ------------------------------------------------------------
// Reusable mobile form dialog for the whole app.
// Keyboard-safe: one scroll, no double padding, no overflow.
// ============================================================

class AppFormDialog extends StatelessWidget {
  const AppFormDialog({
    super.key,
    required this.title,
    required this.icon,
    required this.body,
    this.headerColor = AppColors.primary,
    this.cancelLabel = 'Cancel',
    this.confirmLabel,
    this.onConfirm,
    this.cancelColor = AppColors.info,
    this.confirmColor = AppColors.primary,
    this.footer,
  });

  final String title;
  final IconData icon;
  final Color headerColor;
  final Widget body;

  /// Custom footer. If null, Cancel + Confirm buttons are shown.
  final Widget? footer;

  final String cancelLabel;
  final String? confirmLabel;
  final VoidCallback? onConfirm;
  final Color cancelColor;
  final Color confirmColor;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final keyboard = media.viewInsets.bottom;

    // Space left above keyboard. Do NOT wrap Dialog in another
    // keyboard padding — Dialog already moves up for viewInsets.
    final maxHeight = media.size.height - keyboard - 32.h;

    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 420.w,
          maxHeight: maxHeight.clamp(120.h, media.size.height),
        ),
        // Whole dialog scrolls when keyboard is open — no overflow.
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: EdgeInsets.fromLTRB(12.w, 10.h, 4.w, 10.h),
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
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                        minWidth: 36.w,
                        minHeight: 36.h,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.close_rounded,
                        size: AppSizes.iconSm,
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // Body
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 8.h),
                child: body,
              ),

              // Footer
              Divider(height: 1.h, thickness: 1, color: AppColors.border),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
                child: footer ??
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: TextButton.styleFrom(
                              backgroundColor: cancelColor,
                              foregroundColor: AppColors.textOnPrimary,
                              minimumSize: Size(0, 44.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 10.h,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),
                        if (confirmLabel != null) ...[
                          SizedBox(width: 8.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: onConfirm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: confirmColor,
                                foregroundColor: AppColors.textOnPrimary,
                                elevation: 0,
                                minimumSize: Size(0, 44.h),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 10.h,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                confirmLabel!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.textOnPrimary,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Opens an [AppFormDialog] (or any dialog child).
Future<T?> showAppFormDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: builder,
  );
}
