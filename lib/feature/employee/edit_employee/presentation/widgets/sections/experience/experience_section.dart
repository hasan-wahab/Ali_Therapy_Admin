import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_form_controllers.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/experience/experience_form_fields.dart';

// ============================================================
// EXPERIENCE SECTION
// ------------------------------------------------------------
// Last edit step: previous roles (no card wrapper).
// ============================================================

class EditExperienceSection extends StatelessWidget {
  const EditExperienceSection({
    super.key,
    required this.form,
  });

  final EditEmployeeFormControllers form;

  @override
  Widget build(BuildContext context) {
    return EditExperienceFormFields(form: form);
  }
}
