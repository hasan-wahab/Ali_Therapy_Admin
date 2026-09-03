import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/entities/patient_detail_profile_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_display.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_info_chip.dart';

// ============================================================
// PATIENT DETAIL PERSONAL INFO CONTAINER
// ------------------------------------------------------------
// Header: name + email. Fields below. Last visit at bottom.
// Avatar is a placeholder (API has no photo).
// ============================================================

class PatientDetailPersonalInfoContainer extends StatelessWidget {
  const PatientDetailPersonalInfoContainer({
    super.key,
    required this.profile,
  });

  final PatientDetailProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final name = PatientDetailDisplay.text(profile.name);
    final email = PatientDetailDisplay.text(profile.email);
    final id = PatientDetailDisplay.hashedId(profile.id);
    final lastVisit = PatientDetailDisplay.dateTime(profile.lastVisitAt);

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
                        name,
                        style: AppTextStyles.heading3.copyWith(height: 1.2),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        email,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Patient Id: $id',
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
                    Expanded(
                      child: PatientDetailInfoChip(
                        label: 'Phone',
                        value: PatientDetailDisplay.text(profile.phone),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: PatientDetailInfoChip(
                        label: 'CNIC',
                        value: PatientDetailDisplay.text(profile.cnic),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PatientDetailInfoChip(
                        label: 'Birth Date',
                        value: PatientDetailDisplay.date(profile.dateOfBirth),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: PatientDetailInfoChip(
                        label: 'Age',
                        value: PatientDetailDisplay.ageYears(profile.age),
                      ),
                    ),
                  ],
                ),
                PatientDetailInfoChip(
                  label: 'Referred By',
                  value: PatientDetailDisplay.text(profile.referredBy),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PatientDetailInfoChip(
                        label: 'Gender',
                        value: PatientDetailDisplay.text(profile.gender),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: PatientDetailInfoChip(
                        label: 'Blood Group',
                        value: PatientDetailDisplay.text(profile.bloodGroup),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: PatientDetailInfoChip(
                        label: 'Insurance',
                        value: PatientDetailDisplay.text(profile.insurance),
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
                    'Last Visit: $lastVisit',
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
