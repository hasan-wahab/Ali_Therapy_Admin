import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_pull_refresh.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/entities/patient_dues_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/patient_dues_bloc/patient_dues_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_card_list.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_card_skeleton.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_search_filter_section.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// PATIENT DUES PAGE
// ------------------------------------------------------------
// Same screen flow as AllEmployeesPage:
// shimmer first load, search + filters, pull refresh, load more.
// Filter dropdowns come from GET /reports/filter-options.
// ============================================================

class PatientDuesPage extends StatelessWidget {
  const PatientDuesPage({super.key});

  static const int _prefetchRemainingCards = 2;

  double get _approxCardHeight => 340.h;

  List<PatientDuesEntity> _rowsOf(PatientDuesState state) {
    if (state is PatientDuesLoaded) return state.rows;
    if (state is PatientDuesError) return state.rows;
    return const [];
  }

  bool _isLoading(PatientDuesState state) {
    if (state is PatientDuesLoading || state is PatientDuesInitial) {
      return true;
    }
    if (state is PatientDuesLoaded) {
      return state.isRefreshingList || state.isLoadingMore;
    }
    return false;
  }

  bool _onScroll(BuildContext context, ScrollNotification notification) {
    if (notification is! ScrollUpdateNotification) return false;

    final remainingBelow = notification.metrics.extentAfter;
    final prefetchDistance =
        (_prefetchRemainingCards * _approxCardHeight) + 20.h;
    if (remainingBelow > prefetchDistance) return false;

    context.read<PatientDuesBloc>().add(const PatientDuesLoadMore());
    return false;
  }

  Widget _listContent({
    required BuildContext context,
    required PatientDuesState state,
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
                ? const PatientDuesCardSkeletonSliver(itemCount: 5)
                : PatientDuesCardList(
                    rows: _rowsOf(state),
                    hasMore: state is PatientDuesLoaded && state.hasMore,
                    isLoadingMore:
                        state is PatientDuesLoaded && state.isLoadingMore,
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
          child: const PatientDuesSearchFilterSection(),
        ),
        Expanded(
          child: AppPullRefresh(
            enabled: !isFirstLoad,
            onRefresh: () => context.read<PatientDuesBloc>().pullRefresh(),
            child: listBody,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PatientDuesBloc>()..add(const PatientDuesStarted()),
      child: BlocConsumer<PatientDuesBloc, PatientDuesState>(
        listener: (context, state) {
          if (state is PatientDuesError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
        },
        builder: (context, state) {
          final isFirstLoad =
              state is PatientDuesLoading || state is PatientDuesInitial;
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

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: FormBackAppBar(title: 'Patient Dues', isLoading: isLoading),
            body: AppTabletSafeArea(child: content),
          );
        },
      ),
    );
  }
}
