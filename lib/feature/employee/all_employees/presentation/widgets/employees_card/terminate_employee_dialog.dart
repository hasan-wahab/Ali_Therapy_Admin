import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/core/widgets/app_form_dialog.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// TERMINATE EMPLOYEE DIALOG
// ------------------------------------------------------------
// Collects termination date + reason, then returns values.
// API is called from AllEmployeesBloc (not from this dialog).
// ============================================================

class TerminateEmployeeFormResult {
  const TerminateEmployeeFormResult({
    required this.reason,
    required this.date,
  });

  final String reason;

  /// API value: yyyy-MM-dd, or empty string.
  final String date;
}

class TerminateEmployeeDialog extends StatefulWidget {
  const TerminateEmployeeDialog({
    super.key,
    required this.employeeName,
  });

  final String employeeName;

  @override
  State<TerminateEmployeeDialog> createState() =>
      _TerminateEmployeeDialogState();
}

class _TerminateEmployeeDialogState extends State<TerminateEmployeeDialog> {
  final _reasonController = TextEditingController();
  final _dateController = TextEditingController();

  static final _displayDateFormat = DateFormat('MM/dd/yyyy');

  @override
  void dispose() {
    _reasonController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 5),
    );
    if (picked == null) return;
    _dateController.text = Helpers.formatDate(picked, pattern: 'MM/dd/yyyy');
  }

  String _toApiDate(String display) {
    final trimmed = display.trim();
    if (trimmed.isEmpty) return '';
    try {
      final parsed = _displayDateFormat.parseStrict(trimmed);
      return Helpers.formatDate(parsed, pattern: 'yyyy-MM-dd');
    } catch (_) {
      return '';
    }
  }

  void _onConfirm() {
    final reason = _reasonController.text.trim();
    final dateDisplay = _dateController.text.trim();

    if (dateDisplay.isEmpty) {
      AppSnackbar.warning(context, 'Please select a termination date.');
      return;
    }
    if (reason.isEmpty) {
      AppSnackbar.warning(context, 'Please enter a termination reason.');
      return;
    }

    Navigator.of(context).pop(
      TerminateEmployeeFormResult(
        reason: reason,
        date: _toApiDate(dateDisplay),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppFormDialog(
      title: 'Terminate User',
      icon: Icons.person_off_outlined,
      headerColor: AppColors.error,
      confirmLabel: 'Terminate',
      confirmColor: AppColors.error,
      onConfirm: _onConfirm,
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
                    'Are you sure you want to terminate ${widget.employeeName}?',
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
          AppTextField(
            label: 'Termination Date',
            isRequired: true,
            hintText: 'mm/dd/yyyy',
            controller: _dateController,
            readOnly: true,
            onTap: _pickDate,
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              size: AppSizes.iconSm,
              color: AppColors.textMuted,
            ),
          ),
          SizedBox(height: 12.h),
          AppTextField(
            label: 'Termination Reason',
            isRequired: true,
            hintText: 'Enter details here...',
            controller: _reasonController,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

/// Opens the terminate employee dialog and returns form values if confirmed.
Future<TerminateEmployeeFormResult?> showTerminateEmployeeDialog(
  BuildContext context, {
  required String employeeName,
}) {
  return showAppFormDialog<TerminateEmployeeFormResult>(
    context: context,
    builder: (context) => TerminateEmployeeDialog(employeeName: employeeName),
  );
}
