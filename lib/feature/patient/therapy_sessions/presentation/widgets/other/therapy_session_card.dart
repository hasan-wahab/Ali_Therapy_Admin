import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/patient/therapy_sessions/presentation/widgets/other/therapy_session_meta_field.dart';
import 'package:ali_therapy_admin/feature/patient/therapy_sessions/presentation/widgets/other/therapy_session_modality_chip.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';

// ============================================================
// THERAPY SESSION CARD
// ------------------------------------------------------------
// One compact card: patient + session + next schedule.
// ============================================================

class TherapySessionCard extends StatelessWidget {
  const TherapySessionCard({
    super.key,
    required this.sessionNumber,
    required this.patientName,
    required this.cnic,
    required this.ageGender,
    required this.therapist,
    required this.packageName,
    required this.duration,
    required this.startedAt,
    required this.endedAt,
    required this.modalities,
    required this.nextDate,
    required this.nextTimeSlot,
    this.initiallyExpanded = false,
  });

  final int sessionNumber;
  final String patientName;
  final String cnic;
  final String ageGender;
  final String therapist;
  final String packageName;
  final String duration;
  final String startedAt;
  final String endedAt;
  final List<TherapySessionModalityChip> modalities;
  final String nextDate;
  final String nextTimeSlot;

  final bool initiallyExpanded;
  @override
  Widget build(BuildContext context) {
    return AppExpandableCard(
      initiallyExpanded: initiallyExpanded,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
            color: AppColors.primaryLight,
            child: Row(
              children: [
                Text(
                  'Session #$sessionNumber',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    packageName,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Patient
                Text(
                  'Patient',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                AppTabletFieldsGrid(
                  phoneColumns: 2,
                  tabletColumns: 2,
                  children: [
                    TherapySessionMetaField(
                      label: 'Name',
                      value: patientName,
                    ),
                    TherapySessionMetaField(
                      label: 'CNIC',
                      value: cnic,
                    ),
                    TherapySessionMetaField(
                      label: 'Age / Gender',
                      value: ageGender,
                    ),
                    TherapySessionMetaField(
                      label: 'Therapist',
                      value: therapist,
                    ),
                  ],
                ),

                Divider(height: 16.h, color: AppColors.divider),

                // Session times
                AppTabletFieldsGrid(
                  phoneColumns: 3,
                  tabletColumns: 2,
                  children: [
                    TherapySessionMetaField(
                      label: 'Duration',
                      value: duration,
                    ),
                    TherapySessionMetaField(
                      label: 'Started',
                      value: startedAt,
                    ),
                    TherapySessionMetaField(
                      label: 'Ended',
                      value: endedAt,
                    ),
                  ],
                ),

                SizedBox(height: 4.h),
                Text(
                  'Modalities',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: modalities,
                ),

                Divider(height: 16.h, color: AppColors.divider),

                // Next session
                Text(
                  'Next Session',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppTabletFieldsGrid(
                        phoneColumns: 2,
                        tabletColumns: 2,
                        children: [
                          TherapySessionMetaField(
                            label: 'Date',
                            value: nextDate,
                          ),
                          TherapySessionMetaField(
                            label: 'Time',
                            value: nextTimeSlot,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Booked',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
