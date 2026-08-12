import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/routes/route_names.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_menu_option.dart';

// ============================================================
// PROFILE MENU LIST
// ------------------------------------------------------------
// Same 2-column tile height as ReportsGrid.
// ============================================================

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <({String title, IconData icon, VoidCallback onTap})>[
      (
        title: 'Personal Information',
        icon: Icons.person_outline,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.personalInfo,
        ),
      ),
      (
        title: 'Emergency Contact',
        icon: Icons.medical_services_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.emergencyContact,
        ),
      ),
      (
        title: 'Employment Details',
        icon: Icons.work_outline,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.employmentDetails,
        ),
      ),
      (
        title: 'Addresses',
        icon: Icons.location_on_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.addresses,
        ),
      ),
      (
        title: 'Biography',
        icon: Icons.description_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.biography,
        ),
      ),
      (
        title: 'Bank Details',
        icon: Icons.account_balance_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.bankDetails,
        ),
      ),
      (
        title: 'Documents',
        icon: Icons.folder_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.documents,
        ),
      ),
      (
        title: 'Education',
        icon: Icons.school_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.education,
        ),
      ),
      (
        title: 'Experience',
        icon: Icons.history,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.experience,
        ),
      ),
      (
        title: 'Audit',
        icon: Icons.fact_check_outlined,
        onTap: () => AppNavigation.openProfileSection(
          context,
          AppRoutes.audit,
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
