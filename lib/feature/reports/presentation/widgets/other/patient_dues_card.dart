import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_badge.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_money_line.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';

// ============================================================
// PATIENT DUES CARD
// ------------------------------------------------------------
// One patient billing / dues card (mobile layout).
// ============================================================

class PatientDuesCard extends StatelessWidget {
  const PatientDuesCard({
    super.key,
    required this.patientName,
    required this.cnic,
    required this.phone,
    required this.registeredBy,
    required this.grossBilled,
    required this.consultation,
    required this.packageBilled,
    required this.directDiscount,
    required this.directDiscountPercent,
    required this.insuranceDiscount,
    required this.netBilled,
    required this.packagePaid,
    required this.totalReceived,
    required this.dues,
    this.initiallyExpanded = false,
  });

  final String patientName;
  final String cnic;
  final String phone;
  final String registeredBy;
  final String grossBilled;
  final String consultation;
  final String packageBilled;
  final String directDiscount;
  final String directDiscountPercent;
  final String insuranceDiscount;
  final String netBilled;
  final String packagePaid;
  final String totalReceived;
  final String dues;

  final bool initiallyExpanded;
  @override
  Widget build(BuildContext context) {
    return AppExpandableCard(
      initiallyExpanded: initiallyExpanded,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: patient info left, small Dues button top-right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(patientName, style: AppTextStyles.name),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.infoSoft,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        cnic,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.info,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          size: AppSizes.iconSm,
                          color: AppColors.textMuted,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            'By: $registeredBy',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Material(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(6.r),
                child: InkWell(
                  onTap: () {
                    AppNavigation.openPatientDuesHistory(
                      context,
                      patientName: patientName,
                      cnic: cnic,
                      phone: phone,
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
                          Icons.replay_rounded,
                          size: AppSizes.iconSm,
                          color: AppColors.textOnPrimary,
                        ),
                        SizedBox(width: 4.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dues',
                              style: AppTextStyles.label.copyWith(
                                color: AppColors.textOnPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              dues,
                              style: AppTextStyles.label.copyWith(
                                color: AppColors.textOnPrimary,
                                fontWeight: FontWeight.w800,
                                height: 1.15,
                              ),
                            ),
                          ],
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
            'Billed Breakdown',
            style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6.h),
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
          SizedBox(height: 10.h),
          Text(
            'Discounts & Insurance',
            style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: [
              PatientDuesBadge(
                icon: Icons.local_offer_outlined,
                text: 'Direct $directDiscount ($directDiscountPercent)',
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.softGray,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calculate_outlined,
                  size: AppSizes.iconSm,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 6.w),
                Text('Net Billed', style: AppTextStyles.bodySmall),
                const Spacer(),
                Text(
                  netBilled,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          PatientDuesMoneyLine(
            label: 'Package Paid',
            value: packagePaid,
            icon: Icons.check_circle_outline_rounded,
            iconColor: AppColors.success,
          ),
          PatientDuesMoneyLine(
            label: 'Total Received',
            value: totalReceived,
            icon: Icons.payments_outlined,
            iconColor: AppColors.success,
          ),
        ],
      ),
      ),
    );
  }
}
