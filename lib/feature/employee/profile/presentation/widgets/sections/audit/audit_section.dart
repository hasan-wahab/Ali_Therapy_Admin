import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_row.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// AUDIT SECTION
// ============================================================

class AuditSection extends StatelessWidget {
  const AuditSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileSectionCard(
      title: 'Audit',
      child: Column(
        children: [
          ProfileInfoRow(label: 'Created By', value: 'Super Admin'),
          ProfileInfoRow(label: 'Updated By', value: 'Super Admin'),
        ],
      ),
    );
  }
}
