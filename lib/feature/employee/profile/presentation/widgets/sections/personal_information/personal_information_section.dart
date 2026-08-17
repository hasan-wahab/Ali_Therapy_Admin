import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_row.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// PERSONAL INFORMATION SECTION
// ============================================================

class PersonalInformationSection extends StatelessWidget {
  const PersonalInformationSection({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Personal Information',
      child: Column(
        children: [
          ProfileInfoRow(label: 'Gender', value: profile.gender),
          ProfileInfoRow(label: 'Date of Birth', value: profile.dateOfBirth),
          ProfileInfoRow(label: 'Religion', value: profile.religion),
          ProfileInfoRow(label: 'Blood Group', value: profile.bloodGroup),
          ProfileInfoRow(label: 'Email', value: profile.email),
          ProfileInfoRow(label: 'Phone', value: profile.phone),
          ProfileInfoRow(label: 'CNIC', value: profile.cnic),
        ],
      ),
    );
  }
}
