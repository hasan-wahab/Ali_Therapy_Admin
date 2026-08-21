import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';

// ============================================================
// DISCOUNT REPORT CARD SKELETON
// ------------------------------------------------------------
// Shimmer placeholder that matches DiscountReportCard.
// Wrap a parent with [AppShimmer] so bones animate together.
// ============================================================

class DiscountReportCardSkeleton extends StatelessWidget {
  const DiscountReportCardSkeleton({super.key});

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBone(
                      width: 170.w,
                      height: 16.h,
                      borderRadius: 6.r,
                    ),
                    SizedBox(height: 8.h),
                    AppShimmerBone(width: 140.w, height: 12.h),
                  ],
                ),
              ),
              AppShimmerBone(width: 72.w, height: 32.h, borderRadius: 8.r),
            ],
          ),
          SizedBox(height: 10.h),
          Divider(height: 1.h, color: AppColors.divider),
          SizedBox(height: 10.h),
          AppShimmerBone(width: 90.w, height: 18.h, borderRadius: 20.r),
          SizedBox(height: 10.h),
          AppShimmerBone(
            width: double.infinity,
            height: 16.h,
            borderRadius: 6.r,
          ),
          SizedBox(height: 6.h),
          AppShimmerBone(
            width: double.infinity,
            height: 16.h,
            borderRadius: 6.r,
          ),
        ],
      ),
    );
  }
}

/// Sliver list of skeleton cards — wrap parent with [AppShimmer].
class DiscountReportCardSkeletonSliver extends StatelessWidget {
  const DiscountReportCardSkeletonSliver({
    super.key,
    this.itemCount = 5,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) => const DiscountReportCardSkeleton(),
    );
  }
}
