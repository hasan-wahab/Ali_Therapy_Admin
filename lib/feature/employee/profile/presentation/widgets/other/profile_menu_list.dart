import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/routes/route_names.dart';
import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_menu_option.dart';

// ============================================================
// PROFILE MENU LIST
// ------------------------------------------------------------
// Same 2-column tile height as ReportsGrid.
// Passes already-loaded profile to sections (no new API call).
// ============================================================

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final items = <({String title, IconData icon, VoidCallback onTap})>[
      (
        title: 'Personal Information',
        icon: Icons.person_outline,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.personalInfo,
          profile: profile,
        ),
      ),
      (
        title: 'Emergency Contact',
        icon: Icons.medical_services_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.emergencyContact,
          profile: profile,
        ),
      ),
      (
        title: 'Employment Details',
        icon: Icons.work_outline,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.employmentDetails,
          profile: profile,
        ),
      ),
      (
        title: 'Addresses',
        icon: Icons.location_on_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.addresses,
          profile: profile,
        ),
      ),
      (
        title: 'Biography',
        icon: Icons.description_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.biography,
          profile: profile,
        ),
      ),
      (
        title: 'Bank Details',
        icon: Icons.account_balance_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.bankDetails,
          profile: profile,
        ),
      ),
      (
        title: 'Documents',
        icon: Icons.folder_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.documents,
          profile: profile,
        ),
      ),
      (
        title: 'Education',
        icon: Icons.school_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.education,
          profile: profile,
        ),
      ),
      (
        title: 'Experience',
        icon: Icons.history,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.experience,
          profile: profile,
        ),
      ),
      (
        title: 'Audit',
        icon: Icons.fact_check_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.audit,
          profile: profile,
        ),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 6.h,
        crossAxisSpacing: 6.w,
        // Same height as ReportsGrid tiles
        childAspectRatio: 2.15,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return ProfileMenuOption(
          title: item.title,
          icon: item.icon,
          onTap: item.onTap,
        );
      },
    );
  }
}
