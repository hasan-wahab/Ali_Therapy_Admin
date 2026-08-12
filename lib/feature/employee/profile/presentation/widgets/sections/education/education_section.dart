import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_education_item.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// EDUCATION SECTION
// ============================================================

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Education',
      onAddTap: () => AppNavigation.openAddEducation(context),
      child: ProfileEducationItem(
        title: 'Doctor Of Physical Therapy - Sarhad University Peshawar',
        onDelete: () => AppSnackbar.warning(context, 'Delete education'),
      ),
    );
  }
}
