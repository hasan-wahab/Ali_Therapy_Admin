import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_fields_grid.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// AUDIT SECTION
// ============================================================

class AuditSection extends StatelessWidget {
  const AuditSection({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Audit',
      child: ProfileInfoFieldsGrid(
        fields: [
          ProfileInfoField(label: 'Created By', value: profile.createdBy),
          ProfileInfoField(label: 'Updated By', value: profile.updatedBy),
        ],
      ),
    );
  }
}
