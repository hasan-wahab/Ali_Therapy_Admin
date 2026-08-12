import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_confirm_dialog.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/bloc/login_bloc/auth_bloc.dart';

// ============================================================
// DASHBOARD APP BAR
// ------------------------------------------------------------
// UI only:
//   1) Confirm dialog (shared AppConfirmDialog)
//   2) If Yes → AuthLogoutRequested
//   3) Page shows AppLoadingOverlay from AuthLoading state
// ============================================================

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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

    // UI → event only. Bloc runs LogoutUseCase.
    context.read<AuthBloc>().add(const AuthLogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoggingOut = state is AuthLoading;

        return AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: false,
          title: Text('Dashboard', style: AppTextStyles.appBarTitle),
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
        );
      },
    );
  }
}
