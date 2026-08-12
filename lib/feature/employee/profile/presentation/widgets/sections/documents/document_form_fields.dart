import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_date_field.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_fields_row.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_file_field.dart';

// ============================================================
// DOCUMENT FORM FIELDS
// ------------------------------------------------------------
// One document entry layout (UI only).
// ============================================================

class DocumentFormFields extends StatelessWidget {
  const DocumentFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const FormFieldsRow(
          children: [
            AppTextField(label: 'Title'),
            FormFileField(),
            FormDateField(label: 'Expiry'),
          ],
        ),
        SizedBox(height: 14.h),
        const AppTextField(label: 'Description', maxLines: 4),
      ],
    );
  }
}
