import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_form_dialog.dart';

// ============================================================
// DELETE PATIENT DIALOG
// ------------------------------------------------------------
// Confirm delete patient (UI only).
// Uses shared AppFormDialog.
// ============================================================

class DeletePatientDialog extends StatelessWidget {
  const DeletePatientDialog({
    super.key,
    this.patientName,
  });

  final String? patientName;

  @override
  Widget build(BuildContext context) {
    final name = (patientName == null || patientName!.trim().isEmpty)
        ? 'this patient'
        : patientName!.trim();

    return AppFormDialog(
      title: 'Delete Patient',
      icon: Icons.delete_outline_rounded,
      headerColor: AppColors.error,
      confirmLabel: 'Delete',
      confirmColor: AppColors.error,
      onConfirm: () {
        AppSnackbar.info(context, 'Delete coming soon');
        Navigator.of(context).pop();
      },
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.errorSoft,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.error.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: AppSizes.iconSm,
              color: AppColors.error,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Are you sure you want to delete $name? This action cannot be undone.',
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
    );
  }
}

/// Opens the delete patient confirmation dialog.
Future<void> showDeletePatientDialog(
  BuildContext context, {
  String? patientName,
}) {
  return showAppFormDialog<void>(
    context: context,
    builder: (context) => DeletePatientDialog(patientName: patientName),
  );
}
