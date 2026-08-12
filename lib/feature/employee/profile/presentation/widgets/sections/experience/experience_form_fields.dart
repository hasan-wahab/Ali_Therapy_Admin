import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_fields_row.dart';

// ============================================================
// EXPERIENCE FORM FIELDS
// ------------------------------------------------------------
// One experience entry layout (UI only).
// ============================================================

class ExperienceFormFields extends StatelessWidget {
  const ExperienceFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const FormFieldsRow(
          children: [
            AppTextField(label: 'Company'),
            AppTextField(
              label: 'Working Period',
              hintText: 'e.g. 2019-2022',
              isRequired: true,
            ),
            AppTextField(label: 'Supervisor'),
          ],
        ),
        SizedBox(height: 14.h),
        const AppTextField(label: 'Duties', maxLines: 4),
      ],
    );
  }
}
