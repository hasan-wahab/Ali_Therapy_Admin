import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_form_controllers.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/education/education_form_fields.dart';

// ============================================================
// EDUCATION SECTION
// ------------------------------------------------------------
// Fifth edit step: degrees & notes (no card wrapper).
// ============================================================

class EditEducationSection extends StatelessWidget {
  const EditEducationSection({
    super.key,
    required this.form,
  });

  final EditEmployeeFormControllers form;

  @override
  Widget build(BuildContext context) {
    return EditEducationFormFields(form: form);
  }
}
