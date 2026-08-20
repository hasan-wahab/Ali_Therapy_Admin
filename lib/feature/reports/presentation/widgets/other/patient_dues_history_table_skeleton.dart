import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_shimmer.dart';

// ============================================================
// PATIENT DUES HISTORY TABLE SKELETON
// ------------------------------------------------------------
// Shimmer placeholder that matches PatientDuesHistoryTable.
// Wrap a parent with [AppShimmer] so bones animate together.
// ============================================================

class PatientDuesHistoryTableSkeleton extends StatelessWidget {
  const PatientDuesHistoryTableSkeleton({
    super.key,
    this.rowCount = 6,
  });

  final int rowCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
      child: Column(
        children: List.generate(rowCount, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: index == rowCount - 1 ? 0 : 10.h),
            child: AppShimmerBone(
              width: double.infinity,
              height: 16.h,
            ),
          );
        }),
      ),
    );
  }
}
