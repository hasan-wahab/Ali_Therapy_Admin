import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_education_item.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// EDUCATION SECTION
// ============================================================

class EducationSection extends StatelessWidget {
  const EducationSection({super.key, required this.profile});

  final ProfileEntity profile;

  String _titleFor(String degree, String university) {
    if (degree == '_' && university == '_') return '_';
    if (university == '_') return degree;
    if (degree == '_') return university;
    return '$degree - $university';
  }

  @override
  Widget build(BuildContext context) {
    final educations = profile.educations;

    return ProfileSectionCard(
      title: 'Education',
      onAddTap: () => AppNavigation.openAddEducation(context),
      child: educations.isEmpty
          ? Text('No education records', style: AppTextStyles.bodySmall)
          : Column(
              children: [
                for (var i = 0; i < educations.length; i++) ...[
                  if (i > 0) SizedBox(height: 10.h),
                  ProfileEducationItem(
                    title: _titleFor(
                      educations[i].degree,
                      educations[i].university,
                    ),
                    onDelete: () => AppSnackbar.warning(
                      context,
                      'Delete education',
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}
