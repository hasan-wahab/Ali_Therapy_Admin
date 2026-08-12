import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_row.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// PERSONAL INFORMATION SECTION
// ============================================================

class PersonalInformationSection extends StatelessWidget {
  const PersonalInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileSectionCard(
      title: 'Personal Information',
      child: Column(
        children: [
          ProfileInfoRow(label: 'Gender', value: 'Male'),
          ProfileInfoRow(
            label: 'Date of Birth',
            value: '1999-01-21 (27 years old)',
          ),
          ProfileInfoRow(label: 'Religion', value: 'Islam'),
          ProfileInfoRow(label: 'Blood Group', value: 'O+'),
          ProfileInfoRow(label: 'Email', value: 'wk10r5@gmail.com'),
          ProfileInfoRow(label: 'Phone', value: '0346-1930388'),
          ProfileInfoRow(label: 'CNIC', value: '15602-2597785-7'),
        ],
      ),
    );
  }
}
