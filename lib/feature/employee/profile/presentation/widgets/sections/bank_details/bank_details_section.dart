import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_row.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// BANK DETAILS SECTION
// ============================================================

class BankDetailsSection extends StatelessWidget {
  const BankDetailsSection({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Bank Details',
      child: Column(
        children: [
          ProfileInfoRow(label: 'Bank', value: profile.bank),
          ProfileInfoRow(label: 'Branch', value: profile.branch),
          ProfileInfoRow(label: 'Branch Code', value: profile.branchCode),
          ProfileInfoRow(label: 'Account Holder', value: profile.accountHolder),
          ProfileInfoRow(label: 'Account Number', value: profile.accountNumber),
          ProfileInfoRow(label: 'IBAN', value: profile.iban),
        ],
      ),
    );
  }
}
