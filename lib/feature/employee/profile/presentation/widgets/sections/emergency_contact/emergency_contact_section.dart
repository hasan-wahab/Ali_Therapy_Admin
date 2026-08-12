import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_row.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// EMERGENCY CONTACT SECTION
// ============================================================

class EmergencyContactSection extends StatelessWidget {
  const EmergencyContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileSectionCard(
      title: 'Emergency Contact Information',
      child: Column(
        children: [
          ProfileInfoRow(label: 'Name', value: 'Shah nam dar'),
          ProfileInfoRow(label: 'Relationship', value: 'Father'),
          ProfileInfoRow(label: 'Phone', value: '0312-2218307'),
        ],
      ),
    );
  }
}
