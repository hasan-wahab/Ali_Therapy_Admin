import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// EXPERIENCE SECTION
// ============================================================

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Experience',
      onAddTap: () => AppNavigation.openAddExperience(context),
      child: Text(
        'No experience records',
        style: AppTextStyles.bodySmall,
      ),
    );
  }
}
