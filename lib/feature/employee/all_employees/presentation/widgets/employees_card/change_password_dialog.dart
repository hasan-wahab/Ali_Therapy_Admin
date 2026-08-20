import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/utils/validators.dart';
import 'package:ali_therapy_admin/core/widgets/app_form_dialog.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// CHANGE PASSWORD DIALOG
// ------------------------------------------------------------
// Collects new + confirm password, then returns values.
// API is called from AllEmployeesBloc (not from this dialog).
// ============================================================

class ChangePasswordFormResult {
  const ChangePasswordFormResult({
    required this.newPassword,
    required this.confirmPassword,
  });

  final String newPassword;
  final String confirmPassword;
}

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    final passwordError = Validators.password(password, minLength: 8);
    if (passwordError != null) {
      AppSnackbar.warning(context, passwordError);
      return;
    }

    final confirmError = Validators.confirmPassword(confirm, password);
    if (confirmError != null) {
      AppSnackbar.warning(context, confirmError);
      return;
    }

    Navigator.of(context).pop(
      ChangePasswordFormResult(
        newPassword: password,
        confirmPassword: confirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppFormDialog(
      title: 'Change Password',
      icon: Icons.lock_outline_rounded,
      headerColor: AppColors.primary,
      confirmLabel: 'Change Password',
      confirmColor: AppColors.primary,
      onConfirm: _onConfirm,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: 'New Password',
            isRequired: true,
            obscureText: true,
            controller: _passwordController,
          ),
          SizedBox(height: 4.h),
          Text(
            'Minimum 8 characters',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          SizedBox(height: 12.h),
          AppTextField(
            label: 'Confirm Password',
            isRequired: true,
            obscureText: true,
            controller: _confirmController,
          ),
        ],
      ),
    );
  }
}

/// Opens the change-password dialog and returns values if confirmed.
Future<ChangePasswordFormResult?> showChangePasswordDialog(
  BuildContext context,
) {
  return showAppFormDialog<ChangePasswordFormResult>(
    context: context,
    builder: (context) => const ChangePasswordDialog(),
  );
}
