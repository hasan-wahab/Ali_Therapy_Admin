import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_fields_grid.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// EMERGENCY CONTACT SECTION
// ============================================================

class EmergencyContactSection extends StatelessWidget {
  const EmergencyContactSection({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Emergency Contact Information',
      child: ProfileInfoFieldsGrid(
        fields: [
          ProfileInfoField(label: 'Name', value: profile.emergencyName),
          ProfileInfoField(
            label: 'Relationship',
            value: profile.emergencyRelationship,
          ),
          ProfileInfoField(label: 'Phone', value: profile.emergencyPhone),
        ],
      ),
    );
  }
}
