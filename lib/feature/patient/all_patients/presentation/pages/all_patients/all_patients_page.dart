import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patient_card_list.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_search_filter_section.dart';

// ============================================================
// ALL PATIENTS PAGE
// ------------------------------------------------------------
// Search + filter row fixed on top; patient cards scroll below.
// Same pattern as All Employees.
// ============================================================

class AllPatientsPage extends StatelessWidget {
  const AllPatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'All Patients'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
              child: const PatientsSearchFilterSection(),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 16.h),
                    sliver: const PatientCardList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
