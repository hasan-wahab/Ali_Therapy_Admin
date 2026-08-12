import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_info_chip.dart';

// ============================================================
// PATIENT DETAIL PERSONAL INFO CONTAINER
// ------------------------------------------------------------
// Header: name + email. Fields below. Last visit at bottom.
// ============================================================

class PatientDetailPersonalInfoContainer extends StatelessWidget {
  const PatientDetailPersonalInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Identity: avatar + name + email + ID
          Container(
            padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withValues(alpha: 0.14),
                  AppColors.primaryLight,
                ],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 26.r,
                    backgroundColor: AppColors.surface,
                    child: Icon(
                      Icons.person_rounded,
                      size: AppSizes.iconXl,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Muhammad Safeer',
                        style: AppTextStyles.heading3.copyWith(height: 1.2),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'safeerkaemail@gmail.com',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Patient Id: #001090',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Remaining fields
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 6.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: PatientDetailInfoChip(
                        label: 'Phone',
                        value: '0333-5121038',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    const Expanded(
                      child: PatientDetailInfoChip(
                        label: 'CNIC',
                        value: '61101-1822371-1',
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: PatientDetailInfoChip(
                        label: 'Birth Date',
                        value: 'Aug 01, 1967',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    const Expanded(
                      child: PatientDetailInfoChip(
                        label: 'Age',
                        value: '59 years',
                      ),
                    ),
                  ],
                ),
                const PatientDetailInfoChip(
                  label: 'Referred By',
                  value: 'Social Media: Google',
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: PatientDetailInfoChip(
                        label: 'Gender',
                        value: 'Male',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    const Expanded(
                      child: PatientDetailInfoChip(
                        label: 'Blood Group',
                        value: 'B+',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    const Expanded(
                      child: PatientDetailInfoChip(
                        label: 'Insurance',
                        value: 'N/A',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Last visit / patient date at bottom
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: AppSizes.iconSm,
                  color: AppColors.primary,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    'Last Visit: 23 minutes ago',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
