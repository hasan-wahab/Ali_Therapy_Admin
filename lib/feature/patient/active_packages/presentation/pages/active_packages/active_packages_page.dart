import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/active_packages/presentation/widgets/other/active_package_card.dart';

// ============================================================
// ACTIVE PACKAGES PAGE
// ------------------------------------------------------------
// List of package cards on the Active Packages screen.
// ============================================================

class ActivePackagesPage extends StatelessWidget {
  const ActivePackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Packages'),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          children: [
            Text(
              '1 active package',
              style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            const ActivePackageCard(
              initiallyExpanded: true,
              packageName: '10 days package 30000',
              completedSessions: 1,
              totalSessions: 10,
              price: 'Rs. 30,000.00',
              status: 'Active',
            ),
          ],
        ),
      ),
    );
  }
}
