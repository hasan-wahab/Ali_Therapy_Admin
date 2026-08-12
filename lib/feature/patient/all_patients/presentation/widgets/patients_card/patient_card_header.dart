import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PATIENT CARD HEADER
// ------------------------------------------------------------
// Teal top bar with patient ID (matches web table header vibe).
// ============================================================

class PatientCardHeader extends StatelessWidget {
  const PatientCardHeader({
    super.key,
    required this.patientId,
  });

  final String patientId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: AppSizes.iconMd,
            color: AppColors.textOnPrimary,
          ),
          SizedBox(width: 4.w),
          Text(
            'PATIENT ID  $patientId',
            style: AppTextStyles.body.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
