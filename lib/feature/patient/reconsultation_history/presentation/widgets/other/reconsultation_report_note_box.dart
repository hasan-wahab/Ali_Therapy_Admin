import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// RECONSULTATION REPORT NOTE BOX
// ------------------------------------------------------------
// Soft box for scenario / complaint text.
// ============================================================

class ReconsultationReportNoteBox extends StatelessWidget {
  const ReconsultationReportNoteBox({
    super.key,
    required this.text,
    this.minHeight,
  });

  final String text;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    final display = text.trim().isEmpty ? '_' : text;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: minHeight ?? 56.h),
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.softGray,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        display,
        style: AppTextStyles.bodySmall.copyWith(
          color: display == '_'
              ? AppColors.textMuted
              : AppColors.textPrimary,
          height: 1.4,
        ),
      ),
    );
  }
}
