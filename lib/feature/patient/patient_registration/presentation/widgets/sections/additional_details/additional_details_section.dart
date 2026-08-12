import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/sections/additional_details/additional_details_form_fields.dart';

// ============================================================
// ADDITIONAL DETAILS SECTION
// ------------------------------------------------------------
// Step 2 content wrapper.
// ============================================================

class AdditionalDetailsSection extends StatelessWidget {
  const AdditionalDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Additional Details', style: AppTextStyles.heading3),
        SizedBox(height: 6.h),
        Text(
          'Referral, language, and patient status information.',
          style: AppTextStyles.bodySmall,
        ),
        SizedBox(height: 20.h),
        const AdditionalDetailsFormFields(),
      ],
    );
  }
}
