import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_form_dialog.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// ASSIGN DEVICE ID DIALOG
// ------------------------------------------------------------
// Collects a numeric device_id, then returns it.
// API is called from AllEmployeesBloc (not from this dialog).
// ============================================================

class AssignDeviceIdFormResult {
  const AssignDeviceIdFormResult({required this.deviceId});

  final int deviceId;
}

class AssignDeviceIdDialog extends StatefulWidget {
  const AssignDeviceIdDialog({super.key, required this.employeeName});

  final String employeeName;

  @override
  State<AssignDeviceIdDialog> createState() => _AssignDeviceIdDialogState();
}

class _AssignDeviceIdDialogState extends State<AssignDeviceIdDialog> {
  final _deviceIdController = TextEditingController();

  @override
  void dispose() {
    _deviceIdController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    final raw = _deviceIdController.text.trim();
    final deviceId = int.tryParse(raw);

    if (deviceId == null || deviceId <= 0) {
      AppSnackbar.warning(context, 'Please enter a valid device ID.');
      return;
    }

    Navigator.of(context).pop(AssignDeviceIdFormResult(deviceId: deviceId));
  }

  @override
  Widget build(BuildContext context) {
    return AppFormDialog(
      title: 'Assign Device ID',
      icon: Icons.smartphone_outlined,
      headerColor: AppColors.primary,
      confirmLabel: 'Assign',
      confirmColor: AppColors.primary,
      onConfirm: _onConfirm,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Assign a device ID to ${widget.employeeName}.',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          SizedBox(height: 12.h),
          AppTextField(
            label: 'Device ID',
            isRequired: true,
            hintText: 'e.g. 2',
            controller: _deviceIdController,
            keyboardType: TextInputType.number,
            prefixIcon: Icon(
              Icons.smartphone_outlined,
              size: AppSizes.iconSm,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

/// Opens the assign-device-id dialog and returns the ID if confirmed.
Future<AssignDeviceIdFormResult?> showAssignDeviceIdDialog(
  BuildContext context, {
  required String employeeName,
}) {
  return showAppFormDialog<AssignDeviceIdFormResult>(
    context: context,
    builder: (context) => AssignDeviceIdDialog(employeeName: employeeName),
  );
}
