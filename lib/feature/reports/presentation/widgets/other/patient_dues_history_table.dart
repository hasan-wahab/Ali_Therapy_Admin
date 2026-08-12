import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PATIENT DUES HISTORY TABLE
// ------------------------------------------------------------
// Horizontally scrollable invoice dues table (UI sample).
// ============================================================

class PatientDuesHistoryTable extends StatelessWidget {
  const PatientDuesHistoryTable({super.key});

  static const double _invoiceW = 72;
  static const double _dateW = 100;
  static const double _typeW = 80;
  static const double _amountW = 110;

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
          Container(
            color: AppColors.softGray,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                _cell('#2730', _invoiceW, cellStyle),
                _cell('11 Aug 2026', _dateW, cellStyle),
                _cell('package', _typeW, cellStyle),
                _cell('30,000.00', _amountW, cellStyle),
                _cell(
                  '9,000.00',
                  _amountW,
                  cellStyle.copyWith(color: AppColors.primary),
                ),
                _cell(
                  '0.00',
                  _amountW,
                  cellStyle.copyWith(color: AppColors.primary),
                ),
                _cell(
                  '11,000.00',
                  _amountW,
                  cellStyle.copyWith(color: AppColors.success),
                ),
                _cell(
                  '10,000.00',
                  _amountW,
                  cellStyle.copyWith(color: AppColors.error),
                ),
              ],
            ),
          ),
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
