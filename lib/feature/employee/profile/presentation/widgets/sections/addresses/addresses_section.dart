import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_fields_grid.dart';
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
      child: ProfileInfoFieldsGrid(
        fields: [
          ProfileInfoField(label: 'District', value: profile.district),
          ProfileInfoField(
            label: 'Present Address',
            value: profile.presentAddress,
          ),
          ProfileInfoField(
            label: 'Permanent Address',
            value: profile.permanentAddress,
          ),
        ],
      ),
    );
  }
}
