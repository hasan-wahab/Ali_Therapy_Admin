import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/sections/patient_image/patient_image_form_fields.dart';

// ============================================================
// PATIENT IMAGE SECTION
// ------------------------------------------------------------
// Step 3 content wrapper.
// ============================================================

class PatientImageSection extends StatelessWidget {
  const PatientImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Patient Photo', style: AppTextStyles.heading3),
        SizedBox(height: 6.h),
        Text(
          'Capture or attach a patient image, then register.',
          style: AppTextStyles.bodySmall,
        ),
        SizedBox(height: 20.h),
        const PatientImageFormFields(),
      ],
    );
  }
}
