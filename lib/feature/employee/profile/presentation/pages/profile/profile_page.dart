import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_card.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_menu_list.dart';

// ============================================================
// PROFILE HUB PAGE
// ------------------------------------------------------------
// Profile header + report-style menu grid + bottom space.
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primary,
            size: AppSizes.iconLg,
          ),
          onPressed: () => AppNavigation.back(context),
        ),
        title: Text('Profile', style: AppTextStyles.appBarTitle),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: Icon(
              Icons.settings_outlined,
              color: AppColors.primary,
              size: AppSizes.iconLg,
            ),
            onPressed: () {
              AppSnackbar.info(context, 'Settings coming soon');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProfileCard(
                name: 'DR WAJID MIAN',
                employeeId: 'DAT-9',
                role: 'Physiotherapist',
                clinic: 'Clinic 1',
              ),
              SizedBox(height: 12.h),
              const ProfileMenuList(),
            ],
          ),
        ),
      ),
    );
  }
}
