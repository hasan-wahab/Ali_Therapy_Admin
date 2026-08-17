import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_card.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/addresses/addresses_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/audit/audit_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/bank_details/bank_details_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/biography/biography_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/documents/documents_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/education/education_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/emergency_contact/emergency_contact_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/employment_details/employment_details_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/experience/experience_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/personal_information/personal_information_section.dart';

// ============================================================
// PROFILE TABLET OVERVIEW
// ------------------------------------------------------------
// Tablet only — All Employees → View opens this directly.
// Vertical list of section cards (not a 2-col grid) so more
// data fits. Reuses mobile section widgets + ProfileCard.
// ============================================================

class ProfileTabletOverview extends StatelessWidget {
  const ProfileTabletOverview({
    super.key,
    required this.profile,
    this.imageUrl,
  });

  final ProfileEntity profile;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final gap = 12.h;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileCard(
          name: profile.name,
          employeeId: profile.employeeId,
          role: profile.role,
          clinic: profile.clinic,
          imageUrl: imageUrl,
        ),
        SizedBox(height: gap),
        PersonalInformationSection(profile: profile),
        SizedBox(height: gap),
        EmergencyContactSection(profile: profile),
        SizedBox(height: gap),
        EmploymentDetailsSection(profile: profile),
        SizedBox(height: gap),
        AddressesSection(profile: profile),
        SizedBox(height: gap),
        BankDetailsSection(profile: profile),
        SizedBox(height: gap),
        BiographySection(profile: profile),
        SizedBox(height: gap),
        DocumentsSection(profile: profile),
        SizedBox(height: gap),
        EducationSection(profile: profile),
        SizedBox(height: gap),
        ExperienceSection(profile: profile),
        SizedBox(height: gap),
        AuditSection(profile: profile),
      ],
    );
  }
}
