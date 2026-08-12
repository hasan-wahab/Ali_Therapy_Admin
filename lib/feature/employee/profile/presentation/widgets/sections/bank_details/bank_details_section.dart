import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_row.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// BANK DETAILS SECTION
// ============================================================

class BankDetailsSection extends StatelessWidget {
  const BankDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileSectionCard(
      title: 'Bank Details',
      child: Column(
        children: [
          ProfileInfoRow(label: 'Bank', value: 'Meezan Bank'),
          ProfileInfoRow(label: 'Branch', value: 'F-8'),
          ProfileInfoRow(label: 'Branch Code', value: '—'),
          ProfileInfoRow(label: 'Account Holder', value: '—'),
          ProfileInfoRow(label: 'Account Number', value: '03080112235225'),
          ProfileInfoRow(label: 'IBAN', value: '—'),
        ],
      ),
    );
  }
}
