import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/core/widgets/app_loading_dialog.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/bloc/change_password_bloc/change_password_bloc.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/widgets/change_password_form_card.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/widgets/change_password_header.dart';

// ============================================================
// CHANGE PASSWORD PAGE
// ------------------------------------------------------------
// Logged-in user updates password.
// UI → events / states only.
// ============================================================

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChangePasswordBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const AppBackAppBar(title: 'Change Password'),
        body: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              AppSnackbar.success(context, state.message);
              // Stay signed in — return to previous screen / home.
              AppNavigation.goHome(context);
            }
            if (state is ChangePasswordError) {
              AppSnackbar.error(
                context,
                state.message,
                title: state.title,
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is ChangePasswordLoading;

            return Stack(
              children: [
                Positioned(
                  top: -70.h,
                  right: -40.w,
                  child: Container(
                    width: 180.w,
                    height: 180.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: AppDevice.isTablet(context)
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: AppDevice.contentMaxWidth(context),
                              ),
                              child: SingleChildScrollView(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 24.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const ChangePasswordHeader(),
                                    SizedBox(height: 28.h),
                                    const ChangePasswordFormCard(),
                                    SizedBox(height: 18.h),
                                    TextButton(
                                      onPressed: isLoading
                                          ? null
                                          : () => AppNavigation.goHome(context),
                                      child: Text(
                                        'Back to Home',
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 24.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const ChangePasswordHeader(),
                                SizedBox(height: 28.h),
                                const ChangePasswordFormCard(),
                                SizedBox(height: 18.h),
                                TextButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => AppNavigation.goHome(context),
                                  child: Text(
                                    'Back to Home',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                if (isLoading)
                  const AppLoadingOverlay(
                    message: 'Updating password...',
                    subtitle: 'Please wait',
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
