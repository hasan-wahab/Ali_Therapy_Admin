import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';
import 'package:ali_therapy_admin/core/widgets/app_form_dialog.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// TERMINATE EMPLOYEE DIALOG
// ------------------------------------------------------------
// Confirm terminate form: date + reason (UI only).
// Uses shared AppFormDialog (keyboard-safe).
// ============================================================

class TerminateEmployeeDialog extends StatelessWidget {
  const TerminateEmployeeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppFormDialog(
      title: 'Terminate User',
      icon: Icons.person_off_outlined,
      headerColor: AppColors.error,
      confirmLabel: 'Terminate',
      confirmColor: AppColors.error,
      onConfirm: () {
        AppSnackbar.info(context, 'Terminate coming soon');
        Navigator.of(context).pop();
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.warningSoft,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.warning.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: AppSizes.iconSm,
                  color: AppColors.warning,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Are you sure you want to terminate this employee?',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          const AppFieldLabel(
            label: 'Termination Date',
            isRequired: true,
          ),
          SizedBox(height: 6.h),
          InputDecorator(
            decoration: AppTextField.decoration(
              hintText: 'mm/dd/yyyy',
              suffixIcon: Icon(
                Icons.calendar_today_outlined,
                size: AppSizes.iconSm,
                color: AppColors.textMuted,
              ),
            ),
            child: Text(
              'mm/dd/yyyy',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          const AppTextField(
            label: 'Termination Reason',
            isRequired: true,
            hintText: 'Enter details here...',
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

/// Opens the terminate employee dialog.
Future<void> showTerminateEmployeeDialog(BuildContext context) {
  return showAppFormDialog<void>(
    context: context,
    builder: (context) => const TerminateEmployeeDialog(),
  );
}
