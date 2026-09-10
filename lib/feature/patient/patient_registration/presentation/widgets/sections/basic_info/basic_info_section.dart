import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_form_data_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_registration_form_controllers.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/sections/basic_info/basic_info_form_fields.dart';

// ============================================================
// BASIC INFO SECTION
// ------------------------------------------------------------
// Step 1 content wrapper (compact for mobile).
// ============================================================

class BasicInfoSection extends StatelessWidget {
  const BasicInfoSection({
    super.key,
    required this.form,
    required this.formData,
  });

  final PatientRegistrationFormControllers form;
  final PatientFormDataEntity formData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Basic Information', style: AppTextStyles.heading3),
        SizedBox(height: 12.h),
        BasicInfoFormFields(form: form, formData: formData),
      ],
    );
  }
}
