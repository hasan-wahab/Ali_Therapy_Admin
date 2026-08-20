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
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/assistant_manager_report_bloc/assistant_manager_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/assistant_manager_report_card_list.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/assistant_manager_report_card_skeleton.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/assistant_manager_report_search_filter_section.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// ASSISTANT MANAGER REPORT PAGE
// ------------------------------------------------------------
// Same screen flow as TherapistReportPage:
// shimmer first load, search + filters, pull refresh, load more.
// ============================================================

class AssistantManagerReportPage extends StatelessWidget {
  const AssistantManagerReportPage({super.key});

  static const int _prefetchRemainingCards = 2;

  double get _approxCardHeight => 280.h;

  List<AssistantManagerReportEntity> _rowsOf(
    AssistantManagerReportState state,
  ) {
    if (state is AssistantManagerReportLoaded) return state.rows;
    if (state is AssistantManagerReportError) return state.rows;
    return const [];
  }

  bool _isLoading(AssistantManagerReportState state) {
    if (state is AssistantManagerReportLoading ||
        state is AssistantManagerReportInitial) {
      return true;
    }
    if (state is AssistantManagerReportLoaded) {
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

    context.read<AssistantManagerReportBloc>().add(
      const AssistantManagerReportLoadMore(),
    );
    return false;
  }

  Widget _listContent({
    required BuildContext context,
    required AssistantManagerReportState state,
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
                ? const AssistantManagerReportCardSkeletonSliver(itemCount: 5)
                : AssistantManagerReportCardList(
                    rows: _rowsOf(state),
                    hasMore:
                        state is AssistantManagerReportLoaded && state.hasMore,
                    isLoadingMore:
                        state is AssistantManagerReportLoaded &&
                        state.isLoadingMore,
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
          child: const AssistantManagerReportSearchFilterSection(),
        ),
        Expanded(
          child: AppPullRefresh(
            enabled: !isFirstLoad,
            onRefresh: () =>
                context.read<AssistantManagerReportBloc>().pullRefresh(),
            child: listBody,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<AssistantManagerReportBloc>()
            ..add(const AssistantManagerReportStarted()),
      child:
          BlocConsumer<AssistantManagerReportBloc, AssistantManagerReportState>(
            listener: (context, state) {
              if (state is AssistantManagerReportError) {
                AppSnackbar.error(context, state.message, title: state.title);
              }
            },
            builder: (context, state) {
              final isFirstLoad =
                  state is AssistantManagerReportLoading ||
                  state is AssistantManagerReportInitial;
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
                appBar: FormBackAppBar(
                  title: 'Assistant Manager Report',
                  isLoading: isLoading,
                ),
                body: AppTabletSafeArea(child: content),
              );
            },
          ),
    );
  }
}
