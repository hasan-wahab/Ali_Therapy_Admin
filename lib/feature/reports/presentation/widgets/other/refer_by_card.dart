import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_badge.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_money_line.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';

// ============================================================
// REFER BY CARD
// ------------------------------------------------------------
// One referral-source revenue card (mobile layout).
// ============================================================

class ReferByCard extends StatelessWidget {
  const ReferByCard({
    super.key,
    required this.referralSource,
    required this.referralType,
    required this.patientCount,
    required this.grossBilled,
    required this.consultation,
    required this.packageBilled,
    required this.directDiscount,
    required this.insuranceDiscount,
    required this.packagePaid,
    required this.totalReceived,
    required this.dues,
    this.initiallyExpanded = false,
  });

  final String referralSource;
  final String referralType;
  final int patientCount;
  final String grossBilled;
  final String consultation;
  final String packageBilled;
  final String directDiscount;
  final String insuranceDiscount;
  final String packagePaid;
  final String totalReceived;
  final String dues;
  final bool initiallyExpanded;

  bool get _hasDues {
    final cleaned = dues.replaceAll(RegExp(r'[^0-9.]'), '');
    final value = double.tryParse(cleaned) ?? 0;
    return value > 0;
  }

  String get _patientLabel {
    return patientCount == 1 ? '1 Patient' : '$patientCount Patients';
  }

  @override
  Widget build(BuildContext context) {
    final duesColor = _hasDues ? AppColors.error : AppColors.info;

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          referralType,
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.textOnPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(referralSource, style: AppTextStyles.name),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Material(
                  color: AppColors.successSoft,
                  borderRadius: BorderRadius.circular(6.r),
                  child: InkWell(
                    onTap: () {
                      AppNavigation.openReferredPatients(
                        context,
                        referralSource: referralSource,
                        patientCount: patientCount,
                      );
                    },
                    borderRadius: BorderRadius.circular(6.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 6.h,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            size: AppSizes.iconSm,
                            color: AppColors.success,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            _patientLabel,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(height: 1.h, color: AppColors.divider),
            SizedBox(height: 10.h),
            Text(
              'Billed Revenue Breakdown',
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            AppTabletFieldsGrid(
              phoneColumns: 1,
              tabletColumns: 2,
              children: [
                PatientDuesMoneyLine(
                  label: 'Gross Billed',
                  value: grossBilled,
                  bold: true,
                ),
                PatientDuesMoneyLine(
                  label: 'Consultation',
                  value: consultation,
                  icon: Icons.medical_services_outlined,
                ),
                PatientDuesMoneyLine(
                  label: 'Package Billed',
                  value: packageBilled,
                  icon: Icons.inventory_2_outlined,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              'Discounts & Insurance',
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: [
                PatientDuesBadge(
                  icon: Icons.local_offer_outlined,
                  text: 'Direct $directDiscount',
                  bg: AppColors.primaryLight,
                  fg: AppColors.primary,
                ),
                PatientDuesBadge(
                  icon: Icons.health_and_safety_outlined,
                  text: 'Ins $insuranceDiscount',
                  bg: AppColors.warningSoft,
                  fg: AppColors.warning,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            AppTabletFieldsGrid(
              phoneColumns: 1,
              tabletColumns: 2,
              children: [
                PatientDuesMoneyLine(
                  label: 'Package Paid',
                  value: packagePaid,
                  icon: Icons.check_circle_outline_rounded,
                  iconColor: AppColors.success,
                ),
                PatientDuesMoneyLine(
                  label: 'Total Received',
                  value: totalReceived,
                  icon: Icons.calculate_outlined,
                  iconColor: AppColors.info,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: duesColor,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: AppSizes.iconSm,
                      color: AppColors.textOnPrimary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Dues',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      dues,
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w800,
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
}
