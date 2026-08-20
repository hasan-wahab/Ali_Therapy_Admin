import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_form_dialog.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// ASSIGN BIOMETRIC ID DIALOG
// ------------------------------------------------------------
// Collects biometric_id, then returns it.
// API is called from AllEmployeesBloc (not from this dialog).
// ============================================================

class AssignBiometricIdFormResult {
  const AssignBiometricIdFormResult({required this.biometricId});

  final String biometricId;
}

class AssignBiometricIdDialog extends StatefulWidget {
  const AssignBiometricIdDialog({super.key, required this.employeeName});

  final String employeeName;

  @override
  State<AssignBiometricIdDialog> createState() =>
      _AssignBiometricIdDialogState();
}

class _AssignBiometricIdDialogState extends State<AssignBiometricIdDialog> {
  final _biometricIdController = TextEditingController();

  @override
  void dispose() {
    _biometricIdController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    final biometricId = _biometricIdController.text.trim();

    if (biometricId.isEmpty) {
      AppSnackbar.warning(context, 'Please enter a biometric ID.');
      return;
    }

    Navigator.of(context).pop(
      AssignBiometricIdFormResult(biometricId: biometricId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppFormDialog(
      title: 'Assign Biometric ID',
      icon: Icons.fingerprint,
      headerColor: AppColors.primary,
      confirmLabel: 'Assign',
      confirmColor: AppColors.primary,
      onConfirm: _onConfirm,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Assign a biometric ID to ${widget.employeeName}.',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          SizedBox(height: 12.h),
          AppTextField(
            label: 'Biometric ID',
            isRequired: true,
            hintText: 'e.g. BIO-1042',
            controller: _biometricIdController,
            prefixIcon: Icon(
              Icons.fingerprint,
              size: AppSizes.iconSm,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

/// Opens the assign-biometric-id dialog and returns the ID if confirmed.
Future<AssignBiometricIdFormResult?> showAssignBiometricIdDialog(
  BuildContext context, {
  required String employeeName,
}) {
  return showAppFormDialog<AssignBiometricIdFormResult>(
    context: context,
    builder: (context) => AssignBiometricIdDialog(employeeName: employeeName),
  );
}
