import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';

// ============================================================
// EDIT ROLE FIELD
// ------------------------------------------------------------
// Role dropdown (not free text). Selected roles show as chips.
// ============================================================

class EditRoleField extends StatefulWidget {
  const EditRoleField({
    super.key,
    this.initialRoles = const [],
  });

  final List<String> initialRoles;

  static const roleOptions = [
    'Super Admin',
    'Admin',
    'Assistant Manager',
    'Consultant',
    'History Taker',
    'Dry Needling',
    'Accountant',
    'Physiotherapist',
    'Receptionist',
    'Therapist',
  ];

  @override
  State<EditRoleField> createState() => _EditRoleFieldState();
}

class _EditRoleFieldState extends State<EditRoleField> {
  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List<String>.from(widget.initialRoles);
  }

  List<String> get _available => EditRoleField.roleOptions
      .where((role) => !_selected.contains(role))
      .toList();

  void _addRole(String? role) {
    if (role == null || _selected.contains(role)) return;
    setState(() => _selected = [..._selected, role]);
  }

  void _removeRole(String role) {
    setState(() => _selected = _selected.where((r) => r != role).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppFieldLabel(label: 'Role', isRequired: true),
        SizedBox(height: 8.h),
        if (_selected.isNotEmpty) ...[
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: [
              for (final role in _selected)
                Container(
                  padding: EdgeInsets.fromLTRB(10.w, 5.h, 6.w, 5.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        role,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      InkWell(
                        onTap: () => _removeRole(role),
                        borderRadius: BorderRadius.circular(12.r),
                        child: Icon(
                          Icons.close_rounded,
                          size: AppSizes.iconSm - 4.sp,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
        if (_available.isEmpty)
          Text(
            'All roles selected',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          )
        else
          AppDropdownField(
            key: ValueKey(_available.join('|')),
            hintText: 'Select Role',
            items: _available,
            onChanged: _addRole,
          ),
      ],
    );
  }
}
