import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_loading_dialog.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_app_bar.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_create_patient_button.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_menu_list.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_section_title.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_stats_grid.dart';

// ============================================================
// HOME PAGE (DASHBOARD)
// ------------------------------------------------------------
// UI rules (locked):
//   - Dispatch events to AuthBloc
//   - React to states only (loading / unauthenticated / error)
//   - Never call UseCase / Repository from this page
// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            AppNavigation.goLogin(context);
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
          final isLoggingOut = state is AuthLoading;

          return Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.background,
                appBar: const DashboardAppBar(),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const DashboardSectionTitle(title: 'Overview'),
                        SizedBox(height: 10.h),
                        const DashboardStatsGrid(),
                        SizedBox(height: 22.h),
                        const DashboardSectionTitle(title: 'Quick Access'),
                        SizedBox(height: 10.h),
                        const DashboardMenuList(),
                        SizedBox(height: 22.h),
                        const DashboardCreatePatientButton(),
                      ],
                    ),
                  ),
                ),
              ),
              if (isLoggingOut)
                const AppLoadingOverlay(
                  message: 'Logging out...',
                  subtitle: 'Ending your session',
                ),
            ],
          );
        },
      ),
    );
  }
}
