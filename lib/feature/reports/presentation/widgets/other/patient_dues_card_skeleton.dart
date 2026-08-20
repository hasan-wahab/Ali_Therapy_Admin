import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';

// ============================================================
// PATIENT DUES CARD SKELETON
// ------------------------------------------------------------
// Shimmer placeholder that matches PatientDuesCard layout.
// Wrap a parent with [AppShimmer] so bones animate together.
// ============================================================

class PatientDuesCardSkeleton extends StatelessWidget {
  const PatientDuesCardSkeleton({super.key});

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
          // Header row: patient name + dues badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBone(width: 160.w, height: 14.h),
                    SizedBox(height: 8.h),
                    AppShimmerBone(
                        width: 130.w, height: 20.h, borderRadius: 20.r),
                    SizedBox(height: 8.h),
                    AppShimmerBone(width: 120.w, height: 11.h),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              // Dues badge
              AppShimmerBone(width: 68.w, height: 44.h, borderRadius: 6.r),
            ],
          ),

          SizedBox(height: 10.h),
          Divider(height: 1.h, color: AppColors.divider),
          SizedBox(height: 10.h),

          // Section label
          AppShimmerBone(width: 100.w, height: 11.h),
          SizedBox(height: 8.h),

          // 3 money lines
          AppShimmerBone(
              width: double.infinity, height: 22.h, borderRadius: 6.r),
          SizedBox(height: 6.h),
          AppShimmerBone(
              width: double.infinity, height: 22.h, borderRadius: 6.r),
          SizedBox(height: 6.h),
          AppShimmerBone(
              width: double.infinity, height: 22.h, borderRadius: 6.r),

          SizedBox(height: 10.h),

          // Discount label
          AppShimmerBone(width: 120.w, height: 11.h),
          SizedBox(height: 8.h),

          // Discount badge chips
          Row(
            children: [
              AppShimmerBone(width: 110.w, height: 24.h, borderRadius: 20.r),
              SizedBox(width: 6.w),
              AppShimmerBone(width: 80.w, height: 24.h, borderRadius: 20.r),
            ],
          ),

          SizedBox(height: 10.h),
          // Net billed box
          AppShimmerBone(
              width: double.infinity, height: 36.h, borderRadius: 8.r),

          SizedBox(height: 10.h),
          // 2 payment lines
          AppShimmerBone(
              width: double.infinity, height: 22.h, borderRadius: 6.r),
          SizedBox(height: 6.h),
          AppShimmerBone(
              width: double.infinity, height: 22.h, borderRadius: 6.r),
        ],
      ),
    );
  }
}

/// Sliver list of skeleton cards — wrap parent with [AppShimmer].
class PatientDuesCardSkeletonSliver extends StatelessWidget {
  const PatientDuesCardSkeletonSliver({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) => const PatientDuesCardSkeleton(),
    );
  }
}
