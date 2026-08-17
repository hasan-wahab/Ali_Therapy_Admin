import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_card.dart';

// ============================================================
// PROFILE DETAIL PAGE
// ------------------------------------------------------------
// Section screen — uses ProfileEntity from View (no API call).
// ============================================================

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({
    super.key,
    required this.title,
    required this.profile,
    required this.child,
  });

  final String title;
  final ProfileEntity profile;

  /// Section widget from widgets/<section>/ folder.
  final Widget child;

  String? _imageOrNull(String imageUrl) {
    if (imageUrl.isEmpty || imageUrl == '_') return null;
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBackAppBar(title: title),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileCard(
                name: profile.name,
                employeeId: profile.employeeId,
                role: profile.role,
                clinic: profile.clinic,
                imageUrl: _imageOrNull(profile.imageUrl),
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
