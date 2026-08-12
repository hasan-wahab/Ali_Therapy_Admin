import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_metrics_grid.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_personal_info_container.dart';

// ============================================================
// PATIENT DETAIL PROFILE SECTION
// ------------------------------------------------------------
// Personal info container + overview metrics under Profile tab.
// ============================================================

class PatientDetailProfileSection extends StatelessWidget {
  const PatientDetailProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PatientDetailPersonalInfoContainer(),
        SizedBox(height: 14.h),
        Text(
          'Overview',
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        const PatientDetailMetricsGrid(),
      ],
    );
  }
}
