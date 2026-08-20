import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';

// ============================================================
// RECONSULTATION REPORT CARD SKELETON
// ------------------------------------------------------------
// Shimmer placeholder that matches ReconsultationReportCard layout.
// Wrap a parent with [AppShimmer] so bones animate together.
// ============================================================

class ReconsultationReportCardSkeleton extends StatelessWidget {
  const ReconsultationReportCardSkeleton({super.key});

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
              AppShimmerBone(width: 32.w, height: 32.w, borderRadius: 8.r),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBone(width: 150.w, height: 14.h),
                    SizedBox(height: 6.h),
                    AppShimmerBone(width: 120.w, height: 11.h),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(height: 1.h, color: AppColors.divider),
          SizedBox(height: 10.h),
          AppShimmerBone(width: double.infinity, height: 12.h),
          SizedBox(height: 8.h),
          AppShimmerBone(width: double.infinity, height: 12.h),
          SizedBox(height: 8.h),
          AppShimmerBone(width: double.infinity, height: 12.h),
        ],
      ),
    );
  }
}

/// Sliver list of skeleton cards — wrap parent with [AppShimmer].
class ReconsultationReportCardSkeletonSliver extends StatelessWidget {
  const ReconsultationReportCardSkeletonSliver({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) => const ReconsultationReportCardSkeleton(),
    );
  }
}
