import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// SURVEY STAR RATING
// ------------------------------------------------------------
// Read-only stars + score badge for survey answers.
// ============================================================

class SurveyStarRating extends StatelessWidget {
  const SurveyStarRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
  });

  final int rating;
  final int maxRating;

  @override
  Widget build(BuildContext context) {
    final clamped = rating.clamp(0, maxRating);

    return Row(
      children: [
        for (var i = 1; i <= maxRating; i++)
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: Icon(
              i <= clamped ? Icons.star_rounded : Icons.star_outline_rounded,
              size: AppSizes.iconSm,
              color: AppColors.warning,
            ),
          ),
        SizedBox(width: 6.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            '$clamped',
            style: AppTextStyles.label.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 10.sp,
            ),
          ),
        ),
      ],
    );
  }
}
