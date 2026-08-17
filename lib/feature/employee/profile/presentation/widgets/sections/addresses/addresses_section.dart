import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_row.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// ADDRESSES SECTION
// ============================================================

class AddressesSection extends StatelessWidget {
  const AddressesSection({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Addresses',
      child: Column(
        children: [
          ProfileInfoRow(label: 'District', value: profile.district),
          ProfileInfoRow(
            label: 'Present Address',
            value: profile.presentAddress,
          ),
          ProfileInfoRow(
            label: 'Permanent Address',
            value: profile.permanentAddress,
          ),
        ],
      ),
    );
  }
}
