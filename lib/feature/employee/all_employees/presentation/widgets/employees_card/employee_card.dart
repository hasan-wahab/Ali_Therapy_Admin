import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/bloc/all_employees_bloc/all_employees_bloc.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/assign_biometric_id_dialog.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/assign_device_id_dialog.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/change_password_dialog.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/delete_employee_dialog.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/employee_actions_button.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/employee_action_type.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/employee_card_avatar.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/employee_info_box.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/employee_status_badge.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/employee_tenure_badge.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/terminate_employee_dialog.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';

// ============================================================
// EMPLOYEE CARD
// ------------------------------------------------------------
// Compact card. Role + Shift each in their own soft container.
// ============================================================

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.cnic,
    required this.employeeId,
    required this.joinedDate,
    required this.tenure,
    required this.roles,
    required this.shift,
    required this.createdBy,
    this.imageUrl,
    this.isActive = true,
    this.onActionSelected,
    this.onStatusChanged,
    this.isTogglingStatus = false,
    this.initiallyExpanded = false,
  });

  /// API row id — used for Edit / terminate / password / IDs.
  final String id;
  final String name;
  final String email;
  final String phone;
  final String cnic;
  final String employeeId;
  final String joinedDate;
  final String tenure;
  final List<String> roles;
  final String shift;
  final String createdBy;
  final String? imageUrl;
  final bool isActive;
  final ValueChanged<EmployeeActionType>? onActionSelected;
  final ValueChanged<bool>? onStatusChanged;

  /// True while the toggle API call is in progress for this card.
  final bool isTogglingStatus;

  final bool initiallyExpanded;
  String get _rolesText => roles.join(', ');

  void _handleAction(BuildContext context, EmployeeActionType type) {
    if (onActionSelected != null) {
      onActionSelected!(type);
      return;
    }

    if (type == EmployeeActionType.edit) {
      AppNavigation.openEditEmployee(context);
      return;
    }

    if (type == EmployeeActionType.terminate) {
      _submitTerminate(context);
      return;
    }

    if (type == EmployeeActionType.changePassword) {
      _submitChangePassword(context);
      return;
    }

    if (type == EmployeeActionType.assignDeviceId) {
      _submitAssignDeviceId(context);
      return;
    }

    if (type == EmployeeActionType.assignBiometricId) {
      _submitAssignBiometricId(context);
      return;
    }

    if (type == EmployeeActionType.delete) {
      showDeleteEmployeeDialog(context, employeeName: name);
      return;
    }

    // UI only — wire remaining actions later.
    AppSnackbar.info(context, '${type.name} tapped');
  }

  Future<void> _submitTerminate(BuildContext context) async {
    final result = await showTerminateEmployeeDialog(
      context,
      employeeName: name,
    );
    if (result == null || !context.mounted) return;

    context.read<AllEmployeesBloc>().add(
      AllEmployeesTerminated(
        employeeId: id,
        reason: result.reason,
        date: result.date,
      ),
    );
  }

  Future<void> _submitChangePassword(BuildContext context) async {
    final result = await showChangePasswordDialog(context);
    if (result == null || !context.mounted) return;

    context.read<AllEmployeesBloc>().add(
      AllEmployeesPasswordChanged(
        employeeId: id,
        newPassword: result.newPassword,
        newPasswordConfirmation: result.confirmPassword,
      ),
    );
  }

  Future<void> _submitAssignDeviceId(BuildContext context) async {
    final result = await showAssignDeviceIdDialog(
      context,
      employeeName: name,
    );
    if (result == null || !context.mounted) return;

    context.read<AllEmployeesBloc>().add(
      AllEmployeesDeviceIdAssigned(
        employeeId: id,
        deviceId: result.deviceId,
      ),
    );
  }

  Future<void> _submitAssignBiometricId(BuildContext context) async {
    final result = await showAssignBiometricIdDialog(
      context,
      employeeName: name,
    );
    if (result == null || !context.mounted) return;

    context.read<AllEmployeesBloc>().add(
      AllEmployeesBiometricIdAssigned(
        employeeId: id,
        biometricId: result.biometricId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppExpandableCard(
      initiallyExpanded: initiallyExpanded,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EmployeeCardAvatar(imageUrl: imageUrl),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.name,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '$phone  ·  $cnic',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 6.w),
                EmployeeActionsButton(
                  onSelected: (type) => _handleAction(context, type),
                ),
              ],
            ),

            SizedBox(height: 10.h),
            Divider(color: AppColors.divider, height: 1.h),
            SizedBox(height: 8.h),

            Row(
              children: [
                Text(
                  employeeId,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 3.w,
                  height: 3.w,
                  decoration: const BoxDecoration(
                    color: AppColors.textMuted,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    'Joined $joinedDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall,
                  ),
                ),
                SizedBox(width: 8.w),
                EmployeeTenureBadge(label: tenure),
              ],
            ),

            SizedBox(height: 8.h),
            // Mobile: Role / Shift stacked. Tablet: side by side (Figma).
            if (AppDevice.isTablet(context))
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: EmployeeInfoBox(label: 'Role', value: _rolesText),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: EmployeeInfoBox(label: 'Shift', value: shift),
                  ),
                ],
              )
            else ...[
              EmployeeInfoBox(label: 'Role', value: _rolesText),
              SizedBox(height: 6.h),
              EmployeeInfoBox(label: 'Shift', value: shift),
            ],

            SizedBox(height: 8.h),
            Divider(color: AppColors.divider, height: 1.h),
            SizedBox(height: 6.h),

            Row(
              children: [
                EmployeeStatusBadge(
                  label: isActive ? 'Active' : 'Inactive',
                  isActive: isActive,
                ),
                SizedBox(width: 4.w),
                if (isTogglingStatus)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                else
                  Transform.scale(
                    scale: 0.8,
                    child: Switch.adaptive(
                      value: isActive,
                      activeTrackColor: AppColors.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: onStatusChanged ?? (_) {},
                    ),
                  ),
                const Spacer(),
                Text(
                  'By $createdBy',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
