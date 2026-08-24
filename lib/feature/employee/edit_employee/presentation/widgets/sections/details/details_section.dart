import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_options_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_form_controllers.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/details/details_form_fields.dart';

// ============================================================
// DETAILS SECTION
// ------------------------------------------------------------
// Second edit step: personal info (no card wrapper).
// ============================================================

class DetailsSection extends StatelessWidget {
  const DetailsSection({
    super.key,
    required this.form,
    required this.options,
  });

  final EditEmployeeFormControllers form;
  final EditEmployeeOptionsEntity options;

  @override
  Widget build(BuildContext context) {
    return DetailsFormFields(form: form, options: options);
  }
}
