import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_permission.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_loading_dialog.dart';
import 'package:ali_therapy_admin/core/widgets/app_pull_refresh.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/bloc/login_bloc/auth_bloc.dart';
import 'package:ali_therapy_admin/feature/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_app_bar.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_create_patient_button.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_menu_list.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_section_title.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_skeleton.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_stats_grid.dart';
import 'package:ali_therapy_admin/feature/home/presentation/widgets/dashboard_tablet_body.dart';

// ============================================================
// HOME PAGE (DASHBOARD)
// ------------------------------------------------------------
// First open  → full-screen shimmer (All Employees flow)
// Pull refresh → content stays, AppBar teal loading only
// UI → Event → Bloc → State → UI
// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  bool _isAppBarLoading(HomeState state) {
    if (!AppPermission.canViewDashboardOverview) return false;
    if (state is HomeLoading || state is HomeInitial) return true;
    if (state is HomeLoaded) return state.isRefreshingList;
    if (state is HomeError) return state.isRefreshingList;
    return false;
  }

  /// Locked mobile layout — do not edit for tablet work.
  Widget _mobileBody() {
    final showOverview = AppPermission.canViewDashboardOverview;
    final showQuickAccess = AppPermission.canViewQuickAccess;
    final showCreate = AppPermission.canAddPatient;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showOverview) ...[
            const DashboardSectionTitle(title: 'Overview'),
            SizedBox(height: 10.h),
            const DashboardStatsGrid(),
            if (showQuickAccess || showCreate) SizedBox(height: 22.h),
          ],
          if (showQuickAccess) ...[
            const DashboardSectionTitle(title: 'Quick Access'),
            SizedBox(height: 10.h),
            const DashboardMenuList(),
            if (showCreate) SizedBox(height: 22.h),
          ],
          if (showCreate) const DashboardCreatePatientButton(),
        ],
      ),
    );
  }

  Widget _dashboardContent({
    required bool isTablet,
    required bool isFirstLoad,
  }) {
    if (isFirstLoad) {
      return const AppShimmer(child: DashboardSkeleton());
    }
    return isTablet ? const DashboardTabletBody() : _mobileBody();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(
          create: (_) {
            final bloc = sl<HomeBloc>();
            if (AppPermission.canViewDashboardOverview) {
              bloc.add(const HomeDashboardRequested());
            }
            return bloc;
          },
        ),
      ],
      child: BlocListener<HomeBloc, HomeState>(
        listenWhen: (previous, current) =>
            current is HomeError && !current.isRefreshingList,
        listener: (context, state) {
          if (state is HomeError) {
            AppSnackbar.error(
              context,
              state.message,
              title: state.title,
            );
          }
        },
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
            final isTablet = AppDevice.isTablet(context);

            return BlocBuilder<HomeBloc, HomeState>(
              builder: (context, homeState) {
                final canOverview = AppPermission.canViewDashboardOverview;
                final isFirstLoad = canOverview &&
                    (homeState is HomeLoading || homeState is HomeInitial);
                final isLoading = _isAppBarLoading(homeState);

                return Stack(
                  children: [
                    Scaffold(
                      backgroundColor: AppColors.background,
                      appBar: DashboardAppBar(isLoading: isLoading),
                      body: SafeArea(
                        child: AppPullRefresh(
                          enabled: canOverview && !isFirstLoad,
                          showTopLoader: false,
                          onRefresh: () =>
                              context.read<HomeBloc>().pullRefresh(),
                          child: _dashboardContent(
                            isTablet: isTablet,
                            isFirstLoad: isFirstLoad,
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
            );
          },
        ),
      ),
    );
  }
}
