import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_app_bar_underline.dart';
import 'package:ali_therapy_admin/core/widgets/app_confirm_dialog.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/bloc/login_bloc/auth_bloc.dart';

// ============================================================
// DASHBOARD APP BAR
// ------------------------------------------------------------
// No back icon → title on leading (left) + thick underline.
// ============================================================

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + AppAppBarUnderline.preferredExtra);

  Future<void> _onLogoutPressed(BuildContext context) async {
    final confirmed = await showAppConfirmDialog(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout from this account?',
      icon: Icons.logout_rounded,
      headerColor: AppColors.primary,
      cancelLabel: 'No',
      confirmLabel: 'Yes',
      cancelColor: AppColors.secondary,
      confirmColor: AppColors.primary,
    );

    if (!confirmed || !context.mounted) return;

    context.read<AuthBloc>().add(const AuthLogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoggingOut = state is AuthLoading;

        return AppBar(
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          // No leading icon → title sits on the left (leading side).
          leadingWidth: 200.w,
          leading: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Dashboard',
                style: AppTextStyles.appBarTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'Profile',
              onPressed: isLoggingOut
                  ? null
                  : () => AppNavigation.goProfile(context),
              icon: Icon(
                Icons.person_outline_rounded,
                color: AppColors.primary,
                size: AppSizes.iconLg,
              ),
            ),
            IconButton(
              tooltip: 'Logout',
              onPressed: isLoggingOut ? null : () => _onLogoutPressed(context),
              icon: Icon(
                Icons.logout_rounded,
                color: AppColors.primary,
                size: AppSizes.iconLg,
              ),
            ),
          ],
          bottom: AppAppBarUnderline.bar,
        );
      },
    );
  }
}
