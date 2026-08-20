import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_history_domain/entities/patient_dues_history_entity.dart';

// ============================================================
// PATIENT DUES HISTORY TABLE
// ------------------------------------------------------------
// Horizontally scrollable invoice dues table from API rows.
// ============================================================

class PatientDuesHistoryTable extends StatelessWidget {
  const PatientDuesHistoryTable({
    super.key,
    required this.rows,
  });

  final List<PatientDuesHistoryEntity> rows;

  static const double _invoiceW = 72;
  static const double _dateW = 100;
  static const double _typeW = 90;
  static const double _amountW = 110;

  static final NumberFormat _money = NumberFormat('#,##0.00', 'en_US');

  static String money(double value) => _money.format(value);

  @override
  Widget build(BuildContext context) {
    final headerStyle = AppTextStyles.bodySmall.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
    );
    final cellStyle = AppTextStyles.bodySmall.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w500,
    );

    if (rows.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Center(
          child: Text(
            'No invoice history found',
            style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                _cell('Invoice #', _invoiceW, headerStyle),
                _cell('Date', _dateW, headerStyle),
                _cell('Type', _typeW, headerStyle),
                _cell('Billed Amount', _amountW, headerStyle),
                _cell('Discount', _amountW, headerStyle),
                _cell('Insurance', _amountW, headerStyle),
                _cell('Paid', _amountW, headerStyle),
                _cell('Due', _amountW, headerStyle),
              ],
            ),
          ),
          Divider(height: 1.h, thickness: 1, color: AppColors.divider),
          ...List.generate(rows.length, (index) {
            final row = rows[index];
            return Container(
              color: index.isEven ? AppColors.softGray : AppColors.surface,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                children: [
                  _cell('#${row.invoiceNumber}', _invoiceW, cellStyle),
                  _cell(row.date, _dateW, cellStyle),
                  _cell(row.type, _typeW, cellStyle),
                  _cell(money(row.billedAmount), _amountW, cellStyle),
                  _cell(
                    money(row.discount),
                    _amountW,
                    cellStyle.copyWith(color: AppColors.primary),
                  ),
                  _cell(
                    money(row.insurance),
                    _amountW,
                    cellStyle.copyWith(color: AppColors.primary),
                  ),
                  _cell(
                    money(row.paid),
                    _amountW,
                    cellStyle.copyWith(color: AppColors.success),
                  ),
                  _cell(
                    money(row.due),
                    _amountW,
                    cellStyle.copyWith(color: AppColors.error),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _cell(String text, double width, TextStyle style) {
    return SizedBox(
      width: width.w,
      child: Text(text, style: style),
    );
  }
}
