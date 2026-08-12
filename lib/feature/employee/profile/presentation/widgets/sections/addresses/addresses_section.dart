import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_row.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// ADDRESSES SECTION
// ============================================================

class AddressesSection extends StatelessWidget {
  const AddressesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileSectionCard(
      title: 'Addresses',
      child: Column(
        children: [
          ProfileInfoRow(label: 'District', value: '—'),
          ProfileInfoRow(label: 'Present Address', value: 'Hostel, F-8, Isb'),
          ProfileInfoRow(label: 'Permanent Address', value: 'Swat'),
        ],
      ),
    );
  }
}
