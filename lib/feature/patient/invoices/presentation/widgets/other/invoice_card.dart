import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/patient/invoices/presentation/widgets/other/invoice_meta_field.dart';
import 'package:ali_therapy_admin/feature/patient/invoices/presentation/widgets/other/invoice_payment_record.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';

// ============================================================
// INVOICE CARD
// ------------------------------------------------------------
// Compact invoice card — View Payments expands payment records.
// No chip badges.
// ============================================================

class InvoiceCard extends StatefulWidget {
  const InvoiceCard({
    super.key,
    required this.invoiceId,
    required this.type,
    required this.date,
    required this.amount,
    required this.discount,
    required this.paid,
    required this.due,
    required this.status,
    this.payments = const [],
    this.initiallyExpanded = false,
  });

  final String invoiceId;
  final String type;
  final String date;
  final String amount;
  final String discount;
  final String paid;
  final String due;
  final String status;
  final List<InvoicePaymentRecord> payments;
  final bool initiallyExpanded;

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  bool _showPayments = false;

  @override
  Widget build(BuildContext context) {
    final bool hasDue = widget.due != '0.0' && widget.due != '0';

    return AppExpandableCard(
      initiallyExpanded: widget.initiallyExpanded,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invoice #${widget.invoiceId}',
                        style: AppTextStyles.name,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        widget.date,
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.type,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTabletFieldsGrid(
                  phoneColumns: 2,
                  tabletColumns: 2,
                  gapH: 8.h,
                  children: [
                    InvoiceMetaField(
                      label: 'Amount',
                      value: widget.amount,
                    ),
                    InvoiceMetaField(
                      label: 'Discount',
                      value: widget.discount,
                    ),
                    InvoiceMetaField(
                      label: 'Paid',
                      value: widget.paid,
                      valueColor: AppColors.primary,
                    ),
                    InvoiceMetaField(
                      label: 'Due',
                      value: widget.due,
                      valueColor:
                          hasDue ? AppColors.error : AppColors.textPrimary,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.status.replaceAll('_', ' '),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: hasDue
                              ? AppColors.warning
                              : AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() => _showPayments = !_showPayments);
                      },
                      borderRadius: BorderRadius.circular(6.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 4.h,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View Payments',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              _showPayments
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              size: AppSizes.iconSm,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (_showPayments) ...[
                  SizedBox(height: 8.h),
                  if (widget.payments.isEmpty)
                    Text(
                      'No payments found',
                      style: AppTextStyles.bodySmall,
                    )
                  else
                    ...List.generate(widget.payments.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == widget.payments.length - 1
                              ? 0
                              : 8.h,
                        ),
                        child: widget.payments[index],
                      );
                    }),
                ],
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
