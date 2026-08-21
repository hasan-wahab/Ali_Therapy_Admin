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
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/discount_report_bloc/discount_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/discount_report_card_list.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/discount_report_card_skeleton.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/discount_report_search_filter_section.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// DISCOUNT REPORT PAGE
// ------------------------------------------------------------
// Same screen flow as InProgressSessionsPage:
// shimmer first load, search + filters, pull refresh, load more.
// ============================================================

class DiscountReportPage extends StatelessWidget {
  const DiscountReportPage({super.key});

  static const int _prefetchRemainingCards = 2;

  double get _approxCardHeight => 300.h;

  List<DiscountReportEntity> _rowsOf(DiscountReportState state) {
    if (state is DiscountReportLoaded) return state.rows;
    if (state is DiscountReportError) return state.rows;
    return const [];
  }

  bool _isLoading(DiscountReportState state) {
    if (state is DiscountReportLoading || state is DiscountReportInitial) {
      return true;
    }
    if (state is DiscountReportLoaded) {
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

    context.read<DiscountReportBloc>().add(const DiscountReportLoadMore());
    return false;
  }

  Widget _listContent({
    required BuildContext context,
    required DiscountReportState state,
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
                ? const DiscountReportCardSkeletonSliver(itemCount: 5)
                : DiscountReportCardList(
                    rows: _rowsOf(state),
                    hasMore: state is DiscountReportLoaded && state.hasMore,
                    isLoadingMore: state is DiscountReportLoaded &&
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
          child: const DiscountReportSearchFilterSection(),
        ),
        Expanded(
          child: AppPullRefresh(
            enabled: !isFirstLoad,
            onRefresh: () => context.read<DiscountReportBloc>().pullRefresh(),
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
          sl<DiscountReportBloc>()..add(const DiscountReportStarted()),
      child: BlocConsumer<DiscountReportBloc, DiscountReportState>(
        listener: (context, state) {
          if (state is DiscountReportError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
        },
        builder: (context, state) {
          final isFirstLoad = state is DiscountReportLoading ||
              state is DiscountReportInitial;
          final isLoading = _isLoading(state);
          final isTablet = AppDevice.isTablet(context);

          final hPad = isTablet
              ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
              : 16.w;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: FormBackAppBar(
              title: 'Discount Report',
              isLoading: isLoading,
            ),
            body: AppTabletSafeArea(
              child: _listContent(
                context: context,
                state: state,
                isFirstLoad: isFirstLoad,
                hPad: hPad,
              ),
            ),
          );
        },
      ),
    );
  }
}
