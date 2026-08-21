import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_money_line.dart';

// ============================================================
// DISCOUNT REPORT CARD
// ------------------------------------------------------------
// One discount row as a mobile card.
// ============================================================

class DiscountReportCard extends StatelessWidget {
  const DiscountReportCard({
    super.key,
    required this.patientName,
    required this.phone,
    required this.cnic,
    required this.clinic,
    required this.consultantName,
    required this.receptionistName,
    required this.grossBilled,
    required this.discountAmount,
    required this.discountPercent,
    required this.netAmount,
    required this.status,
    this.initiallyExpanded = false,
  });

  final String patientName;
  final String phone;
  final String cnic;
  final String clinic;
  final String consultantName;
  final String receptionistName;
  final double grossBilled;
  final double discountAmount;
  final int discountPercent;
  final double netAmount;
  final String status;
  final bool initiallyExpanded;

  static final NumberFormat _money = NumberFormat('#,##0.00', 'en_US');

  static String pkr(double value) => 'PKR ${_money.format(value)}';

  bool get _isHighDiscount => discountPercent >= 50;

  @override
  Widget build(BuildContext context) {
    final percentBg = _isHighDiscount
        ? AppColors.warningSoft
        : AppColors.primaryLight;
    final percentFg = _isHighDiscount ? AppColors.warning : AppColors.primary;

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
              spacing: 8.w,
              runSpacing: 4.h,
              children: [
                _meta(Icons.phone_outlined, phone),
                _meta(Icons.credit_card_outlined, cnic),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(height: 1.h, color: AppColors.divider),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.infoSoft,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    clinic,
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.info,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            AppTabletFieldsGrid(
              phoneColumns: 1,
              tabletColumns: 2,
              children: [
                _personLine(label: 'Consultant', value: consultantName),
                _personLine(label: 'Receptionist', value: receptionistName),
              ],
            ),
            SizedBox(height: 8.h),
            PatientDuesMoneyLine(
              label: 'Gross Billed',
              value: pkr(grossBilled),
              bold: true,
            ),
            PatientDuesMoneyLine(
              label: 'Discount',
              value: pkr(discountAmount),
              bold: true,
              icon: Icons.local_offer_outlined,
              iconColor: AppColors.error,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: percentBg,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '$discountPercent% OFF',
                  style: AppTextStyles.label.copyWith(
                    color: percentFg,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            PatientDuesMoneyLine(
              label: 'Net',
              value: pkr(netAmount),
              bold: true,
            ),
            SizedBox(height: 6.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _meta(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: AppSizes.iconSm, color: AppColors.textMuted),
        SizedBox(width: 4.w),
        Text(
          text,
          style: AppTextStyles.label.copyWith(color: AppColors.textSecondary),
        ),
      ],
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
