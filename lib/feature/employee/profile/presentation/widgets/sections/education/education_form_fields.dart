import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_fields_row.dart';

// ============================================================
// EDUCATION FORM FIELDS
// ------------------------------------------------------------
// One education entry layout (UI only).
// ============================================================

class EducationFormFields extends StatelessWidget {
  const EducationFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const FormFieldsRow(
          children: [
            AppTextField(label: 'Degree'),
            AppTextField(label: 'University'),
            AppTextField(
              label: 'CGPA',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        const AppTextField(label: 'Comments', maxLines: 4),
      ],
    );
  }
}
