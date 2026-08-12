import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_card.dart';

// ============================================================
// PROFILE DETAIL PAGE
// ------------------------------------------------------------
// Screen shell for every profile section.
// Scaffold / AppBar / SafeArea always live in pages/.
// ============================================================

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;

  /// Section widget from widgets/<section>/ folder.
  final Widget child;

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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(title, style: AppTextStyles.appBarTitle),
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
              SizedBox(height: 16.h),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
