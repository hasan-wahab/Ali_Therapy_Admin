import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_row.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// EMPLOYMENT DETAILS SECTION
// ============================================================

class EmploymentDetailsSection extends StatelessWidget {
  const EmploymentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileSectionCard(
      title: 'Employment Details',
      child: Column(
        children: [
          ProfileInfoRow(label: 'Department', value: 'Physiotherapy'),
          ProfileInfoRow(label: 'Designation', value: 'Physiotherapist'),
          ProfileInfoRow(label: 'Room', value: 'Clinic'),
          ProfileInfoRow(label: 'Joining Date', value: '2024-06-03 00:00:00'),
          ProfileInfoRow(label: 'Salary Type', value: 'commission'),
          ProfileInfoRow(label: 'Salary', value: '25,000.00'),
        ],
      ),
    );
  }
}
