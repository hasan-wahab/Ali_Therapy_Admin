import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_form_controllers.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/documents/documents_form_fields.dart';

// ============================================================
// DOCUMENTS SECTION
// ------------------------------------------------------------
// Fourth edit step: documents (no card wrapper).
// ============================================================

class EditDocumentsSection extends StatelessWidget {
  const EditDocumentsSection({
    super.key,
    required this.form,
  });

  final EditEmployeeFormControllers form;

  @override
  Widget build(BuildContext context) {
    return DocumentsFormFields(form: form);
  }
}
