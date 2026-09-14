import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// RECONSULTATION REPORT FIELD
// ------------------------------------------------------------
// Label above value — used in the patient info grid.
// ============================================================

class ReconsultationReportField extends StatelessWidget {
  const ReconsultationReportField({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final display = value.trim().isEmpty ? '_' : value;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTextStyles.label.copyWith(
              color: AppColors.textMuted,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            display,
            style: AppTextStyles.bodySmall.copyWith(
              color: display == '_'
                  ? AppColors.textMuted
                  : AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
