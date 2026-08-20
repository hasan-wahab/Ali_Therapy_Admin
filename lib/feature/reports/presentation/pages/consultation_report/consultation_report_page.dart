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
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/entities/consultation_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/consultation_report_bloc/consultation_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_card_list.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_card_skeleton.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_search_filter_section.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// CONSULTATION REPORT PAGE
// ------------------------------------------------------------
// Same screen flow as PatientDuesPage / AllEmployeesPage:
// shimmer first load, search + filters, pull refresh, load more.
// ============================================================

class ConsultationReportPage extends StatelessWidget {
  const ConsultationReportPage({super.key});

  static const int _prefetchRemainingCards = 2;

  double get _approxCardHeight => 340.h;

  List<ConsultationReportEntity> _rowsOf(ConsultationReportState state) {
    if (state is ConsultationReportLoaded) return state.rows;
    if (state is ConsultationReportError) return state.rows;
    return const [];
  }

  bool _isLoading(ConsultationReportState state) {
    if (state is ConsultationReportLoading || state is ConsultationReportInitial) {
      return true;
    }
    if (state is ConsultationReportLoaded) {
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

    context.read<ConsultationReportBloc>().add(const ConsultationReportLoadMore());
    return false;
  }

  Widget _listContent({
    required BuildContext context,
    required ConsultationReportState state,
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
                ? const ConsultationReportCardSkeletonSliver(itemCount: 5)
                : ConsultationReportCardList(
                    rows: _rowsOf(state),
                    hasMore: state is ConsultationReportLoaded && state.hasMore,
                    isLoadingMore: state is ConsultationReportLoaded &&
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
          child: const ConsultationReportSearchFilterSection(),
        ),
        Expanded(
          child: AppPullRefresh(
            enabled: !isFirstLoad,
            onRefresh: () => context.read<ConsultationReportBloc>().pullRefresh(),
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
          sl<ConsultationReportBloc>()..add(const ConsultationReportStarted()),
      child: BlocConsumer<ConsultationReportBloc, ConsultationReportState>(
        listener: (context, state) {
          if (state is ConsultationReportError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
        },
        builder: (context, state) {
          final isFirstLoad = state is ConsultationReportLoading ||
              state is ConsultationReportInitial;
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
              title: 'Consultation Report',
              isLoading: isLoading,
            ),
            body: AppTabletSafeArea(child: content),
          );
        },
      ),
    );
  }
}
