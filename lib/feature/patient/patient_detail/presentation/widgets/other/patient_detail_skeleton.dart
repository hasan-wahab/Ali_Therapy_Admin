import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';

// ============================================================
// PATIENT DETAIL SKELETON
// ------------------------------------------------------------
// First-open (View) placeholder: tabs + profile card + metrics.
// ============================================================

class PatientDetailSkeleton extends StatelessWidget {
  const PatientDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: AppShimmerBone(height: 36.h, borderRadius: 8.r)),
            SizedBox(width: 8.w),
            Expanded(child: AppShimmerBone(height: 36.h, borderRadius: 8.r)),
            SizedBox(width: 8.w),
            Expanded(child: AppShimmerBone(height: 36.h, borderRadius: 8.r)),
            SizedBox(width: 8.w),
            Expanded(child: AppShimmerBone(height: 36.h, borderRadius: 8.r)),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
                child: Row(
                  children: [
                    AppShimmerBone(
                      width: 52.w,
                      height: 52.w,
                      shape: BoxShape.circle,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmerBone(width: 150.w, height: 16.h),
                          SizedBox(height: 8.h),
                          AppShimmerBone(width: 180.w, height: 12.h),
                          SizedBox(height: 6.h),
                          AppShimmerBone(width: 110.w, height: 12.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 14.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppShimmerBone(height: 36.h, borderRadius: 8.r),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: AppShimmerBone(height: 36.h, borderRadius: 8.r),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: AppShimmerBone(height: 36.h, borderRadius: 8.r),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: AppShimmerBone(height: 36.h, borderRadius: 8.r),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    AppShimmerBone(
                      width: double.infinity,
                      height: 36.h,
                      borderRadius: 8.r,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        AppShimmerBone(width: 90.w, height: 14.h),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(child: AppShimmerBone(height: 72.h, borderRadius: 12.r)),
            SizedBox(width: 8.w),
            Expanded(child: AppShimmerBone(height: 72.h, borderRadius: 12.r)),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(child: AppShimmerBone(height: 72.h, borderRadius: 12.r)),
            SizedBox(width: 8.w),
            Expanded(child: AppShimmerBone(height: 72.h, borderRadius: 12.r)),
          ],
        ),
      ],
    );
  }
}
