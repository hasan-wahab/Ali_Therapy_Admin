import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// RECONSULTATION REPORT FOOTER
// ------------------------------------------------------------
// Back + Print Report — same footer row as registration / forms.
// ============================================================

class ReconsultationReportFooter extends StatelessWidget {
  const ReconsultationReportFooter({
    super.key,
    required this.onBack,
    required this.onPrint,
  });

  final VoidCallback onBack;
  final VoidCallback onPrint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: TextButton(
              onPressed: onBack,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.softGray,
                foregroundColor: AppColors.textPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Back',
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: ElevatedButton(
              onPressed: onPrint,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text('Print Report', style: AppTextStyles.button),
            ),
          ),
        ),
      ],
    );
  }
}
