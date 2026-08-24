import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// USER ACTIVITY REPORT STAT LINE
// ------------------------------------------------------------
// Label left + amount right inside a Show Stats card.
// ============================================================

class UserActivityReportStatLine extends StatelessWidget {
  const UserActivityReportStatLine({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 6.w),
          Text(value, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}
