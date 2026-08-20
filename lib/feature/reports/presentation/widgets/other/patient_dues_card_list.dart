import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/entities/patient_dues_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_card.dart';

// ============================================================
// PATIENT DUES CARD LIST
// ------------------------------------------------------------
// Builds expandable dues cards from API rows.
// ============================================================

class PatientDuesCardList extends StatelessWidget {
  const PatientDuesCardList({
    super.key,
    required this.rows,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<PatientDuesEntity> rows;
  final bool hasMore;
  final bool isLoadingMore;

  static final NumberFormat _money = NumberFormat('#,##0', 'en_US');

  static String pkr(double value) => 'PKR ${_money.format(value)}';

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No dues found',
            style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
          ),
        ),
      );
    }

    final extra = hasMore ? 1 : 0;

    return SliverList.separated(
      itemCount: rows.length + extra,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        if (index == rows.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: isLoadingMore
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink(),
            ),
          );
        }
        return _card(rows[index], initiallyExpanded: index == 0);
      },
    );
  }

  Widget _card(PatientDuesEntity row, {required bool initiallyExpanded}) {
    var discPct = '';
    if (row.grossBilled > 0 && row.directDiscount > 0) {
      discPct =
          '${(row.directDiscount / row.grossBilled * 100).toStringAsFixed(0)}%';
    }

    return PatientDuesCard(
      initiallyExpanded: initiallyExpanded,
      patientId: row.id,
      patientName: row.patientName,
      cnic: row.patientCnic,
      phone: row.patientPhone,
      registeredBy: row.receptionistName,
      grossBilled: pkr(row.grossBilled),
      consultation: pkr(row.consultationBilled),
      packageBilled: pkr(row.packageBilled),
      directDiscount: pkr(row.directDiscount),
      directDiscountPercent: discPct,
      insuranceDiscount: pkr(row.insuranceDiscount),
      netBilled: pkr(row.grossBilled - row.totalDiscount),
      packagePaid: pkr(row.totalPaid),
      totalReceived: pkr(row.totalPaid),
      dues: pkr(row.totalDue),
    );
  }
}
