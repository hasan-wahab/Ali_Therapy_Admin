import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PACKAGE ATTENDANCE SUMMARY CHIP
// ------------------------------------------------------------
// Total / Attended / Remaining summary tile.
// ============================================================

class PackageAttendanceSummaryChip extends StatelessWidget {
  const PackageAttendanceSummaryChip({
    super.key,
    required this.label,
    required this.value,
    required this.bg,
    required this.fg,
  });

  final String label;
  final String value;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppTextStyles.label.copyWith(color: fg),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: AppTextStyles.body.copyWith(
                color: fg,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
