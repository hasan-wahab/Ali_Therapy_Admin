import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_allow_login_group.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_fields_row.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_profile_picture_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_role_field.dart';

// ============================================================
// USER DETAILS FORM FIELDS
// ------------------------------------------------------------
// Login & profile fields for employee edit (mobile).
// ============================================================

class UserDetailsFormFields extends StatefulWidget {
  const UserDetailsFormFields({super.key});

  @override
  State<UserDetailsFormFields> createState() => _UserDetailsFormFieldsState();
}

class _UserDetailsFormFieldsState extends State<UserDetailsFormFields> {
  static const _clinics = [
    'Clinic 1',
    'Clinic 2',
    'Clinic 3 (Neuro and Stroke)',
    'Clinic 4',
  ];

  static const _rooms = [
    'Room 1',
    'Room 2',
    'Room 3',
    'Clinic',
  ];

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _employeeIdController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'dr zeesahn akhunzada');
    _emailController =
        TextEditingController(text: 'drzeeshankhan3333@gmail.com');
    _employeeIdController = TextEditingController(text: 'DAT-2');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _employeeIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EditFieldsRow(
          children: [
            AppTextField(
              label: 'Full Name',
              isRequired: true,
              hintText: 'Full name..',
              controller: _nameController,
            ),
            AppTextField(
              label: 'User name (Employee ID)',
              hintText: 'Employee ID..',
              controller: _employeeIdController,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        AppTextField(
          label: 'Email',
          isRequired: true,
          hintText: 'Email..',
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
        ),
        SizedBox(height: 12.h),
        AppTextField(
          label: 'Change Password (Optional)',
          hintText: 'Password',
          obscureText: true,
          controller: _passwordController,
        ),
        SizedBox(height: 12.h),
        const EditFieldsRow(
          children: [
            AppDropdownField(
              label: 'Clinic',
              isRequired: true,
              hintText: 'Select Clinic',
              items: _clinics,
              value: 'Clinic 3 (Neuro and Stroke)',
            ),
            AppDropdownField(
              label: 'Room',
              isRequired: true,
              hintText: 'Select Room',
              items: _rooms,
              value: 'Room 1',
            ),
          ],
        ),
        SizedBox(height: 12.h),
        const EditRoleField(
          initialRoles: [
            'Super Admin',
            'Admin',
            'Assistant Manager',
            'Consultant',
            'History Taker',
            'Dry Needling',
            'Accountant',
          ],
        ),
        SizedBox(height: 12.h),
        const EditProfilePictureField(),
        SizedBox(height: 12.h),
        const EditAllowLoginGroup(initialValue: 'Yes'),
      ],
    );
  }
}
