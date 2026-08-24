import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_permission.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';

// ============================================================
// DASHBOARD SKELETON
// ------------------------------------------------------------
// Full-screen placeholder for first dashboard load.
// Wrap with [AppShimmer] so bones animate together.
// ============================================================

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = AppDevice.isTablet(context);
    final landscape = AppDevice.isLandscape(context);
    final hPad = isTablet ? (landscape ? 40.w : 56.w) : 16.w;
    final vPad = isTablet ? (landscape ? 12.h : 16.h) : 12.h;

    final content = landscape && isTablet
        ? _tabletLandscape()
        : _portraitColumn();

    final scroll = SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(hPad, vPad, hPad, 28.h),
      child: content,
    );

    if (!isTablet) return scroll;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppDevice.contentMaxWidth(context),
        ),
        child: scroll,
      ),
    );
  }

  Widget _portraitColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ..._overviewBones(),
        ..._quickAccessBones(),
        if (AppPermission.canAddPatient) _buttonBone(),
      ],
    );
  }

  Widget _tabletLandscape() {
    final showOverview = AppPermission.canViewDashboardOverview;
    final showQuickAccess = AppPermission.canViewQuickAccess;
    final showCreate = AppPermission.canAddPatient;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showOverview)
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _overviewBones(includeTrailingGap: false),
            ),
          ),
        if (showOverview && (showQuickAccess || showCreate))
          SizedBox(width: 24.w),
        if (showQuickAccess || showCreate)
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ..._quickAccessBones(includeTrailingGap: showCreate),
                if (showCreate) _buttonBone(),
              ],
            ),
          ),
      ],
    );
  }

  List<Widget> _overviewBones({bool includeTrailingGap = true}) {
    if (!AppPermission.canViewDashboardOverview) return const [];

    final cardCount = [
      AppPermission.canViewEmployees,
      AppPermission.canViewPatients,
      AppPermission.canViewFinance || AppPermission.canViewReportsHub,
      AppPermission.canViewFinance || AppPermission.canViewReportsHub,
    ].where((visible) => visible).length;

    final showQuickAccess = AppPermission.canViewQuickAccess;
    final showCreate = AppPermission.canAddPatient;

    return [
      _titleBone(),
      SizedBox(height: 10.h),
      ..._statCardRows(cardCount),
      if (includeTrailingGap && (showQuickAccess || showCreate))
        SizedBox(height: 22.h),
    ];
  }

  List<Widget> _quickAccessBones({bool includeTrailingGap = true}) {
    if (!AppPermission.canViewQuickAccess) return const [];

    final itemCount = [
      AppPermission.canViewEmployees,
      AppPermission.canViewPatients,
      AppPermission.canViewReportsHub,
    ].where((visible) => visible).length;

    return [
      _titleBone(width: 140.w),
      SizedBox(height: 10.h),
      for (var i = 0; i < itemCount; i++) ...[
        if (i > 0) SizedBox(height: 10.h),
        _menuItemBone(),
      ],
      if (includeTrailingGap && AppPermission.canAddPatient)
        SizedBox(height: 22.h),
    ];
  }

  List<Widget> _statCardRows(int cardCount) {
    final rows = <Widget>[];
    for (var i = 0; i < cardCount; i += 2) {
      if (i > 0) rows.add(SizedBox(height: 8.h));
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _statCardBone()),
            SizedBox(width: 8.w),
            Expanded(
              child: i + 1 < cardCount
                  ? _statCardBone()
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    }
    return rows;
  }

  Widget _titleBone({double? width}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AppShimmerBone(width: width ?? 110.w, height: 18.h),
    );
  }

  Widget _statCardBone() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: AppShimmerBone(height: 12.h, borderRadius: 4.r),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 12.h),
            color: AppColors.softGray,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmerBone(width: 88.w, height: 22.h),
                SizedBox(height: 8.h),
                AppShimmerBone(width: 64.w, height: 11.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItemBone() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          AppShimmerBone(width: 44.w, height: 44.w, borderRadius: 10.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmerBone(width: 140.w, height: 14.h),
                SizedBox(height: 8.h),
                AppShimmerBone(width: 180.w, height: 11.h),
              ],
            ),
          ),
          AppShimmerBone(width: 22.w, height: 22.h, borderRadius: 4.r),
        ],
      ),
    );
  }

  Widget _buttonBone() {
    return AppShimmerBone(
      width: double.infinity,
      height: 50.h,
      borderRadius: 12.r,
    );
  }
}
