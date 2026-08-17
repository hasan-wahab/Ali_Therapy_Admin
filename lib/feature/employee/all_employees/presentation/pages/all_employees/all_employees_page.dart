import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_list_card_skeleton.dart';
import 'package:ali_therapy_admin/core/widgets/app_pull_refresh.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employee_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/bloc/all_employees_bloc/all_employees_bloc.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employee_card_list.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employee_list_load_more_footer.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// ALL EMPLOYEES PAGE
// ------------------------------------------------------------
// Search fixed. Cards scroll.
// Pull refresh → page 1.
// Prefetch: when ~2 cards left (e.g. 13 of 15), load next page.
// Mobile layout locked. Tablet: centered content + Role/Shift row.
// ============================================================

class AllEmployeesPage extends StatelessWidget {
  const AllEmployeesPage({super.key});

  /// How many cards still below the screen before we call next page.
  /// Example: 15 per page → when ~13 shown, ~2 left → prefetch.
  static const int _prefetchRemainingCards = 2;

  /// Approx collapsed card height (for prefetch distance).
  double get _approxCardHeight => 220.h;

  List<EmployeeEntity> _employeesOf(AllEmployeesState state) {
    if (state is AllEmployeesLoaded) return state.employees;
    if (state is AllEmployeesError) return state.employees;
    return const [];
  }

  bool _isLoadingMore(AllEmployeesState state) {
    return state is AllEmployeesLoaded && state.isLoadingMore;
  }

  bool _onScroll(BuildContext context, ScrollNotification notification) {
    if (notification is! ScrollUpdateNotification) return false;

    final metrics = notification.metrics;
    // How much list is still below the viewport.
    final remainingBelow = metrics.extentAfter;
    final prefetchDistance =
        (_prefetchRemainingCards * _approxCardHeight) + 20.h;

    // Still more than ~2 cards left → wait.
    if (remainingBelow > prefetchDistance) return false;

    context.read<AllEmployeesBloc>().add(const AllEmployeesLoadMore());
    return false;
  }

  Widget _listContent({
    required BuildContext context,
    required AllEmployeesState state,
    required bool isFirstLoad,
    required bool loadingMore,
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
                : EmployeeCardList(employees: _employeesOf(state)),
          ),
          if (loadingMore)
            const SliverToBoxAdapter(
              child: EmployeeListLoadMoreFooter(),
            ),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        ],
      ),
    );

    final listBody =
        isFirstLoad ? AppShimmer(child: listScroll) : listScroll;

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
            onRefresh: () =>
                context.read<AllEmployeesBloc>().pullRefresh(),
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
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const FormBackAppBar(title: 'All Employees'),
        body: SafeArea(
          child: BlocConsumer<AllEmployeesBloc, AllEmployeesState>(
            listener: (context, state) {
              if (state is AllEmployeesError) {
                AppSnackbar.error(context, state.message, title: state.title);
              }
            },
            builder: (context, state) {
              final isFirstLoad =
                  state is AllEmployeesLoading || state is AllEmployeesInitial;
              final loadingMore = _isLoadingMore(state);
              final isTablet = AppDevice.isTablet(context);

              // Mobile padding locked at 16.w.
              final hPad = isTablet
                  ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
                  : 16.w;

              final content = _listContent(
                context: context,
                state: state,
                isFirstLoad: isFirstLoad,
                loadingMore: loadingMore,
                hPad: hPad,
              );

              if (!isTablet) return content;

              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: AppDevice.contentMaxWidth(context),
                  ),
                  child: content,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
