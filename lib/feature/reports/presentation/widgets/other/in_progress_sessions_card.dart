import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';

// ============================================================
// IN-PROGRESS SESSIONS CARD
// ------------------------------------------------------------
// One in-progress session row as a mobile card.
// ============================================================

class InProgressSessionsCard extends StatelessWidget {
  const InProgressSessionsCard({
    super.key,
    required this.patientName,
    required this.mrNo,
    required this.cnic,
    required this.sessionTypes,
    required this.doctorName,
    required this.therapistName,
    required this.clinic,
    this.status = 'IN_PROGRESS',
    this.initiallyExpanded = false,
  });

  final String patientName;
  final String mrNo;
  final String cnic;
  final List<String> sessionTypes;
  final String doctorName;
  final String therapistName;
  final String clinic;
  final String status;
  final bool initiallyExpanded;

  String get _statusLabel {
    final raw = status.trim();
    if (raw.isEmpty || raw == '_') return 'IN PROGRESS';
    return raw.replaceAll('_', ' ').toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return AppExpandableCard(
      initiallyExpanded: initiallyExpanded,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  size: AppSizes.iconMd,
                  color: AppColors.primary,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    patientName,
                    style: AppTextStyles.name.copyWith(color: AppColors.primary),
                  ),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  height: 32.h,
                  child: ElevatedButton.icon(
                    onPressed: () => AppNavigation.openPatientDetail(context),
                    icon: Icon(
                      Icons.visibility_outlined,
                      size: AppSizes.iconSm,
                      color: AppColors.textOnPrimary,
                    ),
                    label: Text(
                      'View',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textOnPrimary,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.sync_rounded,
                        size: AppSizes.iconSm,
                        color: AppColors.textOnPrimary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _statusLabel,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.softGray,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'MR: #$mrNo',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.infoSoft,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.badge_outlined,
                        size: AppSizes.iconSm,
                        color: AppColors.info,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'CNIC: $cnic',
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.info,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(height: 1.h, color: AppColors.divider),
            SizedBox(height: 10.h),
            Text(
              'Session In Progress',
              style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 6.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: [
                for (final type in sessionTypes)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          type == 'Therapy Session'
                              ? Icons.healing_outlined
                              : Icons.person_outline_rounded,
                          size: AppSizes.iconSm,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          type,
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10.h),
            AppTabletFieldsGrid(
              phoneColumns: 1,
              tabletColumns: 2,
              children: [
                _personLine(
                  label: 'Doctor (Consultant)',
                  value: doctorName,
                ),
                _personLine(
                  label: 'Therapist',
                  value: therapistName,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.softGray,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: AppSizes.iconSm,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      clinic,
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _personLine({
    required String label,
    required String value,
  }) {
    final trimmed = value.trim();
    final isMissing = trimmed.isEmpty ||
        trimmed == '_' ||
        trimmed.toUpperCase() == 'N/A';
    final display = (trimmed.isEmpty || trimmed == '_') ? '_' : trimmed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(
              Icons.person_outline_rounded,
              size: AppSizes.iconSm,
              color: isMissing ? AppColors.textMuted : AppColors.primary,
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                display,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isMissing ? AppColors.textMuted : AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
