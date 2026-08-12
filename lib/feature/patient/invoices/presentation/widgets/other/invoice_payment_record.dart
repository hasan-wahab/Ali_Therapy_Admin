import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/patient/invoices/presentation/widgets/other/invoice_meta_field.dart';

// ============================================================
// INVOICE PAYMENT RECORD
// ------------------------------------------------------------
// One payment row shown under View Payments.
// ============================================================

class InvoicePaymentRecord extends StatelessWidget {
  const InvoicePaymentRecord({
    super.key,
    required this.paymentId,
    required this.date,
    required this.amount,
    required this.method,
    required this.type,
  });

  final String paymentId;
  final String date;
  final String amount;
  final String method;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 6.h),
      decoration: BoxDecoration(
        color: AppColors.softGray,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InvoiceMetaField(
                  label: 'Payment ID',
                  value: paymentId,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: InvoiceMetaField(label: 'Date', value: date),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Expanded(
                child: InvoiceMetaField(
                  label: 'Amount',
                  value: amount,
                  valueColor: AppColors.primary,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: InvoiceMetaField(label: 'Method', value: method),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Align(
            alignment: Alignment.centerLeft,
            child: InvoiceMetaField(label: 'Type', value: type),
          ),
        ],
      ),
    );
  }
}
