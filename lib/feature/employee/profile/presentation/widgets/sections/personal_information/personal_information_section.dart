import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_fields_grid.dart';
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
      child: ProfileInfoFieldsGrid(
        fields: [
          ProfileInfoField(label: 'Gender', value: profile.gender),
          ProfileInfoField(label: 'Date of Birth', value: profile.dateOfBirth),
          ProfileInfoField(label: 'Religion', value: profile.religion),
          ProfileInfoField(label: 'Blood Group', value: profile.bloodGroup),
          ProfileInfoField(label: 'Email', value: profile.email),
          ProfileInfoField(label: 'Phone', value: profile.phone),
          ProfileInfoField(label: 'CNIC', value: profile.cnic),
        ],
      ),
    );
  }
}
