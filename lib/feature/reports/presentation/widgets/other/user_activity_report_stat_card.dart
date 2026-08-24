import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/user_activity_report_stat_line.dart';

// ============================================================
// USER ACTIVITY REPORT STAT CARD
// ------------------------------------------------------------
// One Show Stats tile (title, total, payment-method lines).
// ============================================================

class UserActivityReportStatCard extends StatelessWidget {
  const UserActivityReportStatCard({
    super.key,
    required this.title,
    required this.total,
    required this.totalColor,
    this.lines = const [],
  });

  final String title;
  final String total;
  final Color totalColor;
  final List<UserActivityReportStatLine> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: AppTextStyles.label.copyWith(
              letterSpacing: 0.4,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Text(
            total,
            style: AppTextStyles.heading3.copyWith(
              color: totalColor,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (lines.isNotEmpty) ...[SizedBox(height: 6.h), ...lines],
        ],
      ),
    );
  }
}
