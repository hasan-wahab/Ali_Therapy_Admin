import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/employee_action_type.dart';

// ============================================================
// EMPLOYEE ACTIONS BUTTON
// ------------------------------------------------------------
// Compact teal "Actions" popup — items match the All Employees card menu.
// ============================================================

class EmployeeActionsButton extends StatelessWidget {
  const EmployeeActionsButton({
    super.key,
    this.onSelected,
  });

  final ValueChanged<EmployeeActionType>? onSelected;

  static const Color _editColor = Color(0xFF42A5F5);
  static const Color _terminateColor = Color(0xFFE57373);
  static const Color _passwordColor = Color(0xFF26C6DA);
  static const Color _assignColor = Color(0xFF424242);
  static const Color _deleteColor = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<EmployeeActionType>(
      onSelected: onSelected,
      offset: Offset(0, 6.h),
      color: AppColors.surface,
      elevation: 8,
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.under,
      constraints: BoxConstraints(minWidth: 220.w, maxHeight: 420.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      itemBuilder: (context) => [
        _menuItem(
          type: EmployeeActionType.view,
          icon: Icons.visibility_outlined,
          label: 'View',
          color: AppColors.primary,
        ),
        _menuItem(
          type: EmployeeActionType.edit,
          icon: Icons.edit_square,
          label: 'Edit',
          color: _editColor,
        ),
        _menuItem(
          type: EmployeeActionType.terminate,
          icon: Icons.warning_amber_rounded,
          label: 'Terminate Employee',
          color: _terminateColor,
        ),
        _menuItem(
          type: EmployeeActionType.changePassword,
          icon: Icons.vpn_key_outlined,
          label: 'Change Password',
          color: _passwordColor,
        ),
        _menuItem(
          type: EmployeeActionType.assignDeviceId,
          icon: Icons.smartphone_outlined,
          label: 'Assign Device ID',
          color: _assignColor,
        ),
        _menuItem(
          type: EmployeeActionType.assignBiometricId,
          icon: Icons.fingerprint,
          label: 'Assign Biometric ID',
          color: _assignColor,
        ),
        _menuItem(
          type: EmployeeActionType.delete,
          icon: Icons.delete_outline_rounded,
          label: 'Delete',
          color: _deleteColor,
        ),
      ],
      child: Container(
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Actions',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: AppSizes.iconSm,
              color: AppColors.textOnPrimary,
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<EmployeeActionType> _menuItem({
    required EmployeeActionType type,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return PopupMenuItem<EmployeeActionType>(
      value: type,
      height: 40.h,
      child: Row(
        children: [
          Icon(icon, size: AppSizes.iconMd, color: color),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
