import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';

// ============================================================
// PACKAGE ATTENDANCE DETAIL SKELETON
// ------------------------------------------------------------
// Placeholder for header + package card + session cards.
// ============================================================

class PackageAttendanceDetailSkeleton extends StatelessWidget {
  const PackageAttendanceDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              AppShimmerBone(width: 48.w, height: 48.w, borderRadius: 24.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBone(width: 160.w, height: 16.h),
                    SizedBox(height: 8.h),
                    AppShimmerBone(width: 120.w, height: 12.h),
                    SizedBox(height: 6.h),
                    AppShimmerBone(width: 110.w, height: 12.h),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 18.h),
        AppShimmerBone(width: 160.w, height: 16.h),
        SizedBox(height: 12.h),
        AppShimmerBone(
          width: double.infinity,
          height: 92.h,
          borderRadius: 12.r,
        ),
        SizedBox(height: 20.h),
        AppShimmerBone(width: 180.w, height: 16.h),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: AppShimmerBone(height: 52.h, borderRadius: 10.r),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: AppShimmerBone(height: 52.h, borderRadius: 10.r),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: AppShimmerBone(height: 52.h, borderRadius: 10.r),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        AppShimmerBone(
          width: double.infinity,
          height: 120.h,
          borderRadius: 12.r,
        ),
        SizedBox(height: 10.h),
        AppShimmerBone(
          width: double.infinity,
          height: 120.h,
          borderRadius: 12.r,
        ),
      ],
    );
  }
}
