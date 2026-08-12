import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_form_dialog.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// CHANGE PASSWORD DIALOG
// ------------------------------------------------------------
// Admin sets a new password for an employee (UI only).
// Uses shared AppFormDialog (keyboard-safe).
// ============================================================

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppFormDialog(
      title: 'Change Password',
      icon: Icons.lock_outline_rounded,
      headerColor: AppColors.primary,
      confirmLabel: 'Change Password',
      confirmColor: AppColors.primary,
      onConfirm: () {
        AppSnackbar.info(context, 'Change password coming soon');
        Navigator.of(context).pop();
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppTextField(
            label: 'New Password',
            isRequired: true,
            obscureText: true,
          ),
          SizedBox(height: 4.h),
          Text(
            'Minimum 8 characters',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          SizedBox(height: 12.h),
          const AppTextField(
            label: 'Confirm Password',
            isRequired: true,
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

/// Opens the change-password dialog for an employee.
Future<void> showChangePasswordDialog(BuildContext context) {
  return showAppFormDialog<void>(
    context: context,
    builder: (context) => const ChangePasswordDialog(),
  );
}
