import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_labeled_amount.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_section_title.dart';

// ============================================================
// PATIENT BALANCE BLOCK
// ------------------------------------------------------------
// Labeled balance breakdown (clear for users).
// ============================================================

class PatientBalanceBlock extends StatelessWidget {
  const PatientBalanceBlock({
    super.key,
    required this.totalBilled,
    required this.paid,
    required this.discount,
    required this.insurance,
    required this.remaining,
  });

  final String totalBilled;
  final String paid;
  final String discount;
  final String insurance;
  final String remaining;

  bool get _hasRemaining {
    final digits = remaining.replaceAll(RegExp(r'[^0-9]'), '');
    return digits.isNotEmpty && digits != '0';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 6.h),
      decoration: BoxDecoration(
        color: AppColors.softGray,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PatientSectionTitle(title: 'Remaining Balance'),
          SizedBox(height: 6.h),
          AppTabletFieldsGrid(
            phoneColumns: 1,
            tabletColumns: 2,
            children: [
              PatientLabeledAmount(label: 'Total Billed', amount: totalBilled),
              PatientLabeledAmount(
                label: 'Paid',
                amount: paid,
                amountColor: AppColors.success,
              ),
              PatientLabeledAmount(
                label: 'Discount',
                amount: discount,
                amountColor: AppColors.primary,
              ),
              PatientLabeledAmount(
                label: 'Insurance',
                amount: insurance,
                amountColor: AppColors.primary,
              ),
              PatientLabeledAmount(
                label: 'Remaining',
                amount: remaining,
                amountColor: _hasRemaining ? AppColors.error : AppColors.success,
                isBold: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
