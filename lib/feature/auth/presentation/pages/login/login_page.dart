import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_constants.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_loading_dialog.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/widgets/login_form_card.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/widgets/login_header.dart';

// ============================================================
// LOGIN PAGE
// ------------------------------------------------------------
// UI → events / states only.
// Loading uses shared AppLoadingOverlay (same as logout).
// ============================================================

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>()..add(const AuthSessionCheckRequested()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              AppNavigation.goHome(context);
            }
            if (state is AuthError) {
              AppSnackbar.error(
                context,
                state.message,
                title: state.title,
              );
            }
          },
          builder: (context, state) {
            final isLoggingIn = state is AuthLoading;

            return Stack(
              children: [
                Positioned(
                  top: -80.h,
                  right: -60.w,
                  child: Container(
                    width: 200.w,
                    height: 200.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40.h,
                  left: -50.w,
                  child: Container(
                    width: 160.w,
                    height: 160.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.06),
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
                                    const LoginHeader(),
                                    SizedBox(height: 28.h),
                                    const LoginFormCard(),
                                    SizedBox(height: 24.h),
                                    Text(
                                      AppConstants.appName,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textMuted,
                                        fontWeight: FontWeight.w500,
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
                                const LoginHeader(),
                                SizedBox(height: 28.h),
                                const LoginFormCard(),
                                SizedBox(height: 24.h),
                                Text(
                                  AppConstants.appName,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textMuted,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                if (isLoggingIn)
                  const AppLoadingOverlay(
                    message: 'Signing in...',
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
