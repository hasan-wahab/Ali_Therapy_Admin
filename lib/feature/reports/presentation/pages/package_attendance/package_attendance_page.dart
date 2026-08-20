import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_pull_refresh.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/entities/package_attendance_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/package_attendance_bloc/package_attendance_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_card_list.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_card_skeleton.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_search_filter_section.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// PACKAGE ATTENDANCE PAGE
// ------------------------------------------------------------
// Same screen flow as PatientReportPage:
// shimmer first load, search + filters, pull refresh, load more.
// ============================================================

class PackageAttendancePage extends StatelessWidget {
  const PackageAttendancePage({super.key});

  static const int _prefetchRemainingCards = 2;

  double get _approxCardHeight => 300.h;

  List<PackageAttendanceEntity> _rowsOf(PackageAttendanceState state) {
    if (state is PackageAttendanceLoaded) return state.rows;
    if (state is PackageAttendanceError) return state.rows;
    return const [];
  }

  bool _isLoading(PackageAttendanceState state) {
    if (state is PackageAttendanceLoading ||
        state is PackageAttendanceInitial) {
      return true;
    }
    if (state is PackageAttendanceLoaded) {
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

    context.read<PackageAttendanceBloc>().add(const PackageAttendanceLoadMore());
    return false;
  }

  Widget _hintBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.successSoft,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        'Select a patient to view their purchased packages & attendance history.',
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.success),
      ),
    );
  }

  Widget _listContent({
    required BuildContext context,
    required PackageAttendanceState state,
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
            sliver: SliverToBoxAdapter(child: _hintBanner()),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(hPad, 12.h, hPad, 8.h),
            sliver: isFirstLoad
                ? const PackageAttendanceCardSkeletonSliver(itemCount: 5)
                : PackageAttendanceCardList(
                    rows: _rowsOf(state),
                    hasMore:
                        state is PackageAttendanceLoaded && state.hasMore,
                    isLoadingMore: state is PackageAttendanceLoaded &&
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
          child: const PackageAttendanceSearchFilterSection(),
        ),
        Expanded(
          child: AppPullRefresh(
            enabled: !isFirstLoad,
            onRefresh: () =>
                context.read<PackageAttendanceBloc>().pullRefresh(),
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
          sl<PackageAttendanceBloc>()..add(const PackageAttendanceStarted()),
      child: BlocConsumer<PackageAttendanceBloc, PackageAttendanceState>(
        listener: (context, state) {
          if (state is PackageAttendanceError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
        },
        builder: (context, state) {
          final isFirstLoad = state is PackageAttendanceLoading ||
              state is PackageAttendanceInitial;
          final isLoading = _isLoading(state);
          final isTablet = AppDevice.isTablet(context);

          final hPad = isTablet
              ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
              : 16.w;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: FormBackAppBar(
              title: 'Package Attendance',
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
