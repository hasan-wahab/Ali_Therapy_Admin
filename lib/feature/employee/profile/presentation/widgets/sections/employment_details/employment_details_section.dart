import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_fields_grid.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// EMPLOYMENT DETAILS SECTION
// ============================================================

class EmploymentDetailsSection extends StatelessWidget {
  const EmploymentDetailsSection({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Employment Details',
      child: ProfileInfoFieldsGrid(
        fields: [
          ProfileInfoField(label: 'Department', value: profile.department),
          ProfileInfoField(label: 'Designation', value: profile.designation),
          ProfileInfoField(label: 'Room', value: profile.room),
          ProfileInfoField(label: 'Joining Date', value: profile.joiningDate),
          ProfileInfoField(label: 'Salary Type', value: profile.salaryType),
          ProfileInfoField(label: 'Salary', value: profile.salary),
        ],
      ),
    );
  }
}
