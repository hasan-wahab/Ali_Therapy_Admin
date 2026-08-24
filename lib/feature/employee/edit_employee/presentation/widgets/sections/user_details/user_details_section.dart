import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_options_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_form_controllers.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/user_details/user_details_form_fields.dart';

// ============================================================
// USER DETAILS SECTION
// ------------------------------------------------------------
// First edit step: login & profile fields (no card wrapper).
// ============================================================

class UserDetailsSection extends StatelessWidget {
  const UserDetailsSection({
    super.key,
    required this.form,
    required this.options,
  });

  final EditEmployeeFormControllers form;
  final EditEmployeeOptionsEntity options;

  @override
  Widget build(BuildContext context) {
    return UserDetailsFormFields(form: form, options: options);
  }
}
