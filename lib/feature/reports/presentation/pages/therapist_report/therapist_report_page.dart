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
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/entities/therapist_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/therapist_report_bloc/therapist_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/therapist_report_card_list.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/therapist_report_card_skeleton.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/therapist_report_search_filter_section.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// THERAPIST REPORT PAGE
// ------------------------------------------------------------
// Same screen flow as ConsultationReportPage / PatientDuesPage:
// shimmer first load, search + filters, pull refresh, load more.
// ============================================================

class TherapistReportPage extends StatelessWidget {
  const TherapistReportPage({super.key});

  static const int _prefetchRemainingCards = 2;

  double get _approxCardHeight => 280.h;

  List<TherapistReportEntity> _rowsOf(TherapistReportState state) {
    if (state is TherapistReportLoaded) return state.rows;
    if (state is TherapistReportError) return state.rows;
    return const [];
  }

  bool _isLoading(TherapistReportState state) {
    if (state is TherapistReportLoading || state is TherapistReportInitial) {
      return true;
    }
    if (state is TherapistReportLoaded) {
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

    context.read<TherapistReportBloc>().add(const TherapistReportLoadMore());
    return false;
  }

  Widget _listContent({
    required BuildContext context,
    required TherapistReportState state,
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
                ? const TherapistReportCardSkeletonSliver(itemCount: 5)
                : TherapistReportCardList(
                    rows: _rowsOf(state),
                    hasMore: state is TherapistReportLoaded && state.hasMore,
                    isLoadingMore:
                        state is TherapistReportLoaded && state.isLoadingMore,
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
          child: const TherapistReportSearchFilterSection(),
        ),
        Expanded(
          child: AppPullRefresh(
            enabled: !isFirstLoad,
            onRefresh: () => context.read<TherapistReportBloc>().pullRefresh(),
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
          sl<TherapistReportBloc>()..add(const TherapistReportStarted()),
      child: BlocConsumer<TherapistReportBloc, TherapistReportState>(
        listener: (context, state) {
          if (state is TherapistReportError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
        },
        builder: (context, state) {
          final isFirstLoad = state is TherapistReportLoading ||
              state is TherapistReportInitial;
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
              title: 'Therapist Report',
              isLoading: isLoading,
            ),
            body: AppTabletSafeArea(child: content),
          );
        },
      ),
    );
  }
}
