import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_row.dart';
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
      child: Column(
        children: [
          ProfileInfoRow(label: 'Department', value: profile.department),
          ProfileInfoRow(label: 'Designation', value: profile.designation),
          ProfileInfoRow(label: 'Room', value: profile.room),
          ProfileInfoRow(label: 'Joining Date', value: profile.joiningDate),
          ProfileInfoRow(label: 'Salary Type', value: profile.salaryType),
          ProfileInfoRow(label: 'Salary', value: profile.salary),
        ],
      ),
    );
  }
}
