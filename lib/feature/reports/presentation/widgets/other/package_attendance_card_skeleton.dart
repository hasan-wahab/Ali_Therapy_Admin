import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';

// ============================================================
// PACKAGE ATTENDANCE CARD SKELETON
// ------------------------------------------------------------
// Shimmer placeholder that matches PackageAttendanceCard.
// Wrap a parent with [AppShimmer] so bones animate together.
// ============================================================

class PackageAttendanceCardSkeleton extends StatelessWidget {
  const PackageAttendanceCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppShimmerBone(width: 40.w, height: 40.w, borderRadius: 10.r),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBone(width: 150.w, height: 14.h),
                    SizedBox(height: 6.h),
                    AppShimmerBone(width: 140.w, height: 11.h),
                    SizedBox(height: 6.h),
                    AppShimmerBone(width: 110.w, height: 11.h),
                  ],
                ),
              ),
              AppShimmerBone(width: 64.w, height: 22.h, borderRadius: 6.r),
            ],
          ),
          SizedBox(height: 10.h),
          AppShimmerBone(width: 110.w, height: 24.h, borderRadius: 20.r),
          SizedBox(height: 10.h),
          AppShimmerBone(
            width: double.infinity,
            height: 58.h,
            borderRadius: 8.r,
          ),
          SizedBox(height: 10.h),
          AppShimmerBone(
            width: double.infinity,
            height: 40.h,
            borderRadius: 8.r,
          ),
        ],
      ),
    );
  }
}

/// Sliver list of skeleton cards — wrap parent with [AppShimmer].
class PackageAttendanceCardSkeletonSliver extends StatelessWidget {
  const PackageAttendanceCardSkeletonSliver({
    super.key,
    this.itemCount = 5,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) => const PackageAttendanceCardSkeleton(),
    );
  }
}
