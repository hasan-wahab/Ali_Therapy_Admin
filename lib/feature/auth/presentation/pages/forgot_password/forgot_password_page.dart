import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_loading_dialog.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/widgets/forgot_password_form_card.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/widgets/forgot_password_header.dart';

// ============================================================
// FORGOT PASSWORD PAGE
// ------------------------------------------------------------
// UI → events / states only.
// Success → snackbar → Change Password screen (next API step).
// ============================================================

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ForgetPasswordBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.primary,
              size: AppSizes.iconLg,
            ),
            onPressed: () => AppNavigation.back(context),
          ),
        ),
        body: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ForgetPasswordSuccess) {
              AppSnackbar.success(context, state.message);
              // Email sent → next step: set new password.
              AppNavigation.openChangePassword(context);
            }
            if (state is ForgetPasswordError) {
              AppSnackbar.error(
                context,
                state.message,
                title: state.title,
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is ForgetPasswordLoading;

            return Stack(
              children: [
                Positioned(
                  top: -70.h,
                  left: -40.w,
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
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 24.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const ForgotPasswordHeader(),
                          SizedBox(height: 28.h),
                          const ForgotPasswordFormCard(),
                          SizedBox(height: 18.h),
                          TextButton(
                            onPressed: isLoading
                                ? null
                                : () => AppNavigation.goLogin(context),
                            child: Text(
                              'Back to Login',
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
                    message: 'Sending reset link...',
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
