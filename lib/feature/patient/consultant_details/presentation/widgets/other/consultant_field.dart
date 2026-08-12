import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// CONSULTANT FIELD
// ------------------------------------------------------------
// Label on top, value below — readable on mobile.
// ============================================================

class ConsultantField extends StatelessWidget {
  const ConsultantField({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final display = value.trim().isEmpty ? '—' : value;

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              textAlign: TextAlign.left,
              style: AppTextStyles.label.copyWith(
                color: AppColors.textMuted,
                fontSize: 11.sp,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              display,
              textAlign: TextAlign.left,
              style: AppTextStyles.bodySmall.copyWith(
                color: display == '—'
                    ? AppColors.textMuted
                    : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
