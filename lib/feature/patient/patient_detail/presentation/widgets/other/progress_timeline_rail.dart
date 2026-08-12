import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';

// ============================================================
// PROGRESS TIMELINE RAIL
// ------------------------------------------------------------
// Left rail: accent dot + connector line for timeline steps.
// ============================================================

class ProgressTimelineRail extends StatelessWidget {
  const ProgressTimelineRail({
    super.key,
    required this.accent,
    required this.isLast,
  });

  final Color accent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final railWidth = 18.w;

    return SizedBox(
      width: railWidth,
      child: Column(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: accent, width: 2.2),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.22),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 4.w,
                height: 4.w,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          if (!isLast)
            Expanded(
              child: Container(
                width: 2.w,
                margin: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.28),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
