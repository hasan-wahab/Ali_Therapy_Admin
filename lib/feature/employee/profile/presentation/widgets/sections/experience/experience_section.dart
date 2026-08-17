import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_fields_grid.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// EXPERIENCE SECTION
// ============================================================

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final experiences = profile.experiences;

    return ProfileSectionCard(
      title: 'Experience',
      onAddTap: () => AppNavigation.openAddExperience(context),
      child: experiences.isEmpty
          ? Text('No experience records', style: AppTextStyles.bodySmall)
          : Column(
              children: [
                for (var i = 0; i < experiences.length; i++) ...[
                  if (i > 0) SizedBox(height: 12.h),
                  ProfileInfoFieldsGrid(
                    fields: [
                      ProfileInfoField(
                        label: 'Company',
                        value: experiences[i].companyName,
                      ),
                      ProfileInfoField(
                        label: 'Period',
                        value: experiences[i].workingPeriod,
                      ),
                      ProfileInfoField(
                        label: 'Duties',
                        value: experiences[i].duties,
                      ),
                      ProfileInfoField(
                        label: 'Supervisor',
                        value: experiences[i].supervisor,
                      ),
                    ],
                  ),
                ],
              ],
            ),
    );
  }
}
