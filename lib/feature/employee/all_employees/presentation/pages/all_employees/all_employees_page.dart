import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_list_card_skeleton.dart';
import 'package:ali_therapy_admin/core/widgets/app_loading_dialog.dart';
import 'package:ali_therapy_admin/core/widgets/app_pull_refresh.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employee_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/bloc/all_employees_bloc/all_employees_bloc.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employee_card_list.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// ALL EMPLOYEES PAGE
// ------------------------------------------------------------
// Search fixed. Cards scroll.
// Pull refresh → page 1.
// AppBar underline: rainbow normally, teal linear during any load.
// ============================================================

class AllEmployeesPage extends StatelessWidget {
  const AllEmployeesPage({super.key});

  static const int _prefetchRemainingCards = 2;

  double get _approxCardHeight => 220.h;

  List<EmployeeEntity> _employeesOf(AllEmployeesState state) {
    if (state is AllEmployeesLoaded) return state.employees;
    if (state is AllEmployeesError) return state.employees;
    return const [];
  }

  bool _isLoading(AllEmployeesState state) {
    if (state is AllEmployeesLoading || state is AllEmployeesInitial) {
      return true;
    }
    if (state is AllEmployeesLoaded) {
      return state.isRefreshingList ||
          state.isLoadingMore ||
          state.terminatingEmployeeId != null ||
          state.changingPasswordEmployeeId != null ||
          state.assigningDeviceEmployeeId != null ||
          state.assigningBiometricEmployeeId != null;
    }
    return false;
  }

  bool _onScroll(BuildContext context, ScrollNotification notification) {
    if (notification is! ScrollUpdateNotification) return false;

    final metrics = notification.metrics;
    final remainingBelow = metrics.extentAfter;
    final prefetchDistance =
        (_prefetchRemainingCards * _approxCardHeight) + 20.h;

    if (remainingBelow > prefetchDistance) return false;

    context.read<AllEmployeesBloc>().add(const AllEmployeesLoadMore());
    return false;
  }

  Widget _listContent({
    required BuildContext context,
    required AllEmployeesState state,
    required bool isFirstLoad,
    required double hPad,
  }) {
    final listScroll = NotificationListener<ScrollNotification>(
      onNotification: (notification) => _onScroll(context, notification),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 8.h),
            sliver: isFirstLoad
                ? const AppListCardSkeletonSliver(itemCount: 6)
                : EmployeeCardList(
                    employees: _employeesOf(state),
                    togglingEmployeeId: state is AllEmployeesLoaded
                        ? state.togglingEmployeeId
                        : null,
                  ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        ],
      ),
    );

    final listBody = isFirstLoad ? AppShimmer(child: listScroll) : listScroll;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(hPad, 8.h, hPad, 12.h),
          child: const EmployeesSearchFilterSection(),
        ),
        Expanded(
          child: AppPullRefresh(
            enabled: !isFirstLoad,
            onRefresh: () => context.read<AllEmployeesBloc>().pullRefresh(),
            child: listBody,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AllEmployeesBloc>()..add(const AllEmployeesStarted()),
      child: BlocConsumer<AllEmployeesBloc, AllEmployeesState>(
        listenWhen: (previous, current) {
          if (current is AllEmployeesError) return true;
          if (current is AllEmployeesLoaded && current.successMessage != null) {
            final previousMessage = previous is AllEmployeesLoaded
                ? previous.successMessage
                : null;
            return previousMessage != current.successMessage;
          }
          return false;
        },
        listener: (context, state) {
          if (state is AllEmployeesError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
          if (state is AllEmployeesLoaded &&
              state.successMessage != null &&
              state.successMessage!.isNotEmpty) {
            AppSnackbar.success(context, state.successMessage!);
          }
        },
        builder: (context, state) {
          final isFirstLoad =
              state is AllEmployeesLoading || state is AllEmployeesInitial;
          final isLoading = _isLoading(state);
          final isTablet = AppDevice.isTablet(context);

          final hPad = isTablet
              ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
              : 16.w;

          final content = _listContent(
            context: context,
            state: state,
            isFirstLoad: isFirstLoad,
            hPad: hPad,
          );

          // AppBar underline switches between rainbow ↔ teal loading bar.
          final appBar = FormBackAppBar(
            title: 'All Employees',
            isLoading: isLoading,
          );

          final isTerminating =
              state is AllEmployeesLoaded &&
              state.terminatingEmployeeId != null;
          final isChangingPassword =
              state is AllEmployeesLoaded &&
              state.changingPasswordEmployeeId != null;
          final isAssigningDevice =
              state is AllEmployeesLoaded &&
              state.assigningDeviceEmployeeId != null;
          final isAssigningBiometric =
              state is AllEmployeesLoaded &&
              state.assigningBiometricEmployeeId != null;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: appBar,
            body: AppTabletSafeArea(
              child: Stack(
                children: [
                  content,
                  if (isTerminating)
                    const AppLoadingOverlay(
                      message: 'Terminating...',
                      subtitle: 'Please wait',
                    )
                  else if (isChangingPassword)
                    const AppLoadingOverlay(
                      message: 'Changing password...',
                      subtitle: 'Please wait',
                    )
                  else if (isAssigningDevice)
                    const AppLoadingOverlay(
                      message: 'Assigning device ID...',
                      subtitle: 'Please wait',
                    )
                  else if (isAssigningBiometric)
                    const AppLoadingOverlay(
                      message: 'Assigning biometric ID...',
                      subtitle: 'Please wait',
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
