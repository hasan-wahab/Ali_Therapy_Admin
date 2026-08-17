import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/core/widgets/app_loading_dialog.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_card.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_menu_list.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// PROFILE HUB PAGE
// ------------------------------------------------------------
// Opened from All Employees → View with employee id in extra.
// One API load here. Grid sections reuse that ProfileEntity.
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  String? _employeeIdFromRoute(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    if (extra is String && extra.trim().isNotEmpty && extra != '_') {
      return extra.trim();
    }
    return null;
  }

  String? _imageOrNull(String imageUrl) {
    if (imageUrl.isEmpty || imageUrl == '_') return null;
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final employeeId = _employeeIdFromRoute(context);

    return BlocProvider(
      create: (_) {
        final bloc = sl<ProfileBloc>();
        if (employeeId != null) {
          bloc.add(ProfileStarted(employeeId: employeeId));
        }
        return bloc;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBackAppBar(
          title: 'Profile',
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
          child: employeeId == null
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      'Open an employee from All Employees → View.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                  ),
                )
              : BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileError) {
                      AppSnackbar.error(
                        context,
                        state.message,
                        title: state.title,
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading =
                        state is ProfileLoading || state is ProfileInitial;

                    return Stack(
                      children: [
                        SingleChildScrollView(
                          padding:
                              EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (state is ProfileLoaded)
                                ProfileCard(
                                  name: state.profile.name,
                                  employeeId: state.profile.employeeId,
                                  role: state.profile.role,
                                  clinic: state.profile.clinic,
                                  imageUrl:
                                      _imageOrNull(state.profile.imageUrl),
                                ),
                              if (state is ProfileLoaded)
                                SizedBox(height: 12.h),
                              if (state is ProfileLoaded)
                                ProfileMenuList(profile: state.profile),
                            ],
                          ),
                        ),
                        if (isLoading)
                          const AppLoadingOverlay(
                            message: 'Loading profile...',
                          ),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
