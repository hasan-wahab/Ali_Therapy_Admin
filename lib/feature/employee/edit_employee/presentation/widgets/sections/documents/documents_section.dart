import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/documents/documents_form_fields.dart';

// ============================================================
// DOCUMENTS SECTION
// ------------------------------------------------------------
// Fourth edit step: upload files (no card wrapper).
// ============================================================

class EditDocumentsSection extends StatelessWidget {
  const EditDocumentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const DocumentsFormFields();
  }
}
