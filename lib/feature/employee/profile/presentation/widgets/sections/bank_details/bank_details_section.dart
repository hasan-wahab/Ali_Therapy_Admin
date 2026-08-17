import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_fields_grid.dart';
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
      child: ProfileInfoFieldsGrid(
        fields: [
          ProfileInfoField(label: 'Bank', value: profile.bank),
          ProfileInfoField(label: 'Branch', value: profile.branch),
          ProfileInfoField(label: 'Branch Code', value: profile.branchCode),
          ProfileInfoField(
            label: 'Account Holder',
            value: profile.accountHolder,
          ),
          ProfileInfoField(
            label: 'Account Number',
            value: profile.accountNumber,
          ),
          ProfileInfoField(label: 'IBAN', value: profile.iban),
        ],
      ),
    );
  }
}
