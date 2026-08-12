import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';

// ============================================================
// APP LIST CARD SKELETON
// ------------------------------------------------------------
// Grey placeholder card that matches list-card layout
// (avatar + lines + info boxes) — employees / patients / etc.
// ============================================================

class AppListCardSkeleton extends StatelessWidget {
  const AppListCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 10.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar + name / email / phone
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppShimmerBone(
                width: 44.r,
                height: 44.r,
                shape: BoxShape.circle,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBone(width: 140.w, height: 14.h),
                    SizedBox(height: 8.h),
                    AppShimmerBone(width: 180.w, height: 11.h),
                    SizedBox(height: 8.h),
                    AppShimmerBone(width: 160.w, height: 11.h),
                  ],
                ),
              ),
              AppShimmerBone(width: 22.w, height: 22.h, borderRadius: 4.r),
            ],
          ),

          SizedBox(height: 10.h),
          Divider(color: AppColors.divider, height: 1.h),
          SizedBox(height: 8.h),

          // Id · joined · tenure
          Row(
            children: [
              AppShimmerBone(width: 70.w, height: 12.h),
              SizedBox(width: 10.w),
              AppShimmerBone(width: 100.w, height: 12.h),
              const Spacer(),
              AppShimmerBone(width: 44.w, height: 18.h, borderRadius: 10.r),
            ],
          ),

          SizedBox(height: 10.h),
          // Role / Shift style boxes
          AppShimmerBone(
            width: double.infinity,
            height: 36.h,
            borderRadius: 8.r,
          ),
          SizedBox(height: 6.h),
          AppShimmerBone(
            width: double.infinity,
            height: 36.h,
            borderRadius: 8.r,
          ),

          SizedBox(height: 10.h),
          Divider(color: AppColors.divider, height: 1.h),
          SizedBox(height: 8.h),

          Row(
            children: [
              AppShimmerBone(width: 64.w, height: 22.h, borderRadius: 12.r),
              SizedBox(width: 8.w),
              AppShimmerBone(width: 36.w, height: 20.h, borderRadius: 12.r),
              const Spacer(),
              AppShimmerBone(width: 72.w, height: 12.h),
            ],
          ),
        ],
      ),
    );
  }
}

/// Sliver list of skeleton cards (for CustomScrollView).
/// Wrap a parent with [AppShimmer] so bones animate together.
class AppListCardSkeletonSliver extends StatelessWidget {
  const AppListCardSkeletonSliver({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) => const AppListCardSkeleton(),
    );
  }
}
