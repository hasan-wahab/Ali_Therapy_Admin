import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// DASHBOARD CREATE PATIENT BUTTON
// ------------------------------------------------------------
// Primary action to open patient registration.
// ============================================================

class DashboardCreatePatientButton extends StatelessWidget {
  const DashboardCreatePatientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton.icon(
        onPressed: () => AppNavigation.openPatientRegistration(context),
        icon: Icon(
          Icons.person_add_alt_1_rounded,
          size: AppSizes.iconMd,
          color: AppColors.textOnPrimary,
        ),
        label: Text(
          'Create New Patient',
          style: AppTextStyles.button,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
