import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_confirm_dialog.dart';

// ============================================================
// DELETE EMPLOYEE DIALOG
// ------------------------------------------------------------
// Confirm delete — shared Yes/No layout (showAppConfirmDialog).
// ============================================================

/// Opens delete confirmation. Returns true only when Delete is pressed.
Future<bool> showDeleteEmployeeDialog(
  BuildContext context, {
  String? employeeName,
}) {
  final name = (employeeName == null || employeeName.trim().isEmpty)
      ? 'this employee'
      : employeeName.trim();

  return showAppConfirmDialog(
    context: context,
    title: 'Delete Employee',
    message:
        'Are you sure you want to delete $name? This action cannot be undone.',
    icon: Icons.delete_outline_rounded,
    headerColor: AppColors.error,
    cancelLabel: 'Cancel',
    confirmLabel: 'Delete',
    cancelColor: AppColors.secondary,
    confirmColor: AppColors.error,
  );
}
