import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_form_data_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_registration_form_controllers.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/sections/additional_details/additional_details_form_fields.dart';

// ============================================================
// ADDITIONAL DETAILS SECTION
// ------------------------------------------------------------
// Step 2 content wrapper.
// ============================================================

class AdditionalDetailsSection extends StatelessWidget {
  const AdditionalDetailsSection({
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
        Text('Additional Details', style: AppTextStyles.heading3),
        SizedBox(height: 6.h),
        Text(
          'Referral, language, and medical information.',
          style: AppTextStyles.bodySmall,
        ),
        SizedBox(height: 20.h),
        AdditionalDetailsFormFields(form: form, formData: formData),
      ],
    );
  }
}
