import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';

// ============================================================
// CONSULTATION REPORT CARD SKELETON
// ------------------------------------------------------------
// Shimmer placeholder that matches ConsultationReportCard layout.
// Wrap a parent with [AppShimmer] so bones animate together.
// ============================================================

class ConsultationReportCardSkeleton extends StatelessWidget {
  const ConsultationReportCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
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
              AppShimmerBone(width: 26.w, height: 26.w, borderRadius: 6.r),
              SizedBox(width: 8.w),
              Expanded(child: AppShimmerBone(width: double.infinity, height: 14.h)),
              SizedBox(width: 8.w),
              AppShimmerBone(width: 44.w, height: 24.h, borderRadius: 12.r),
            ],
          ),
          SizedBox(height: 8.h),
          AppShimmerBone(width: double.infinity, height: 12.h),
          SizedBox(height: 6.h),
          AppShimmerBone(width: double.infinity, height: 12.h),
          SizedBox(height: 6.h),
          AppShimmerBone(width: double.infinity, height: 12.h),
          SizedBox(height: 8.h),
          Divider(height: 1.h, color: AppColors.divider),
          SizedBox(height: 8.h),
          AppShimmerBone(width: 100.w, height: 11.h),
          SizedBox(height: 6.h),
          AppShimmerBone(width: 140.w, height: 14.h),
          SizedBox(height: 8.h),
          AppShimmerBone(width: double.infinity, height: 12.h),
          SizedBox(height: 6.h),
          AppShimmerBone(width: double.infinity, height: 12.h),
          SizedBox(height: 8.h),
          AppShimmerBone(width: double.infinity, height: 72.h, borderRadius: 8.r),
          SizedBox(height: 8.h),
          AppShimmerBone(width: double.infinity, height: 48.h, borderRadius: 8.r),
        ],
      ),
    );
  }
}

/// Sliver list of skeleton cards — wrap parent with [AppShimmer].
class ConsultationReportCardSkeletonSliver extends StatelessWidget {
  const ConsultationReportCardSkeletonSliver({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) => const ConsultationReportCardSkeleton(),
    );
  }
}
