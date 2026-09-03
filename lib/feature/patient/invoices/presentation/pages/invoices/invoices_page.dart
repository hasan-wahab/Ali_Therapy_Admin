import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/invoices/presentation/widgets/other/invoice_card.dart';
import 'package:ali_therapy_admin/feature/patient/invoices/presentation/widgets/other/invoice_payment_record.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_display.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_record_refresh_shell.dart';

// ============================================================
// INVOICES PAGE
// ------------------------------------------------------------
// Invoices from Patient Full View (passed via extra).
// Pull refresh reloads Full View — AppBar underline loading.
// ============================================================

class InvoicesPage extends StatelessWidget {
  const InvoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PatientDetailRecordRefreshShell(
      title: 'Invoices',
      builder: (context, detail) {
        final invoices = detail.invoices;

        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          itemCount: invoices.length + 1,
          separatorBuilder: (_, index) =>
              index == 0 ? SizedBox(height: 12.h) : SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            if (index == 0) {
              final count = invoices.length;
              return Text(
                count == 1 ? '1 invoice' : '$count invoices',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              );
            }

            final invoice = invoices[index - 1];
            return InvoiceCard(
              initiallyExpanded: index == 1,
              invoiceId: PatientDetailDisplay.text(invoice.id),
              type: PatientDetailDisplay.text(invoice.type),
              date: PatientDetailDisplay.date(invoice.date),
              amount: PatientDetailDisplay.moneyPlain(invoice.amount),
              discount: PatientDetailDisplay.moneyPlain(invoice.discount),
              paid: PatientDetailDisplay.moneyPlain(invoice.paid),
              due: PatientDetailDisplay.moneyPlain(invoice.due),
              status: PatientDetailDisplay.text(invoice.status),
              payments: invoice.payments
                  .map(
                    (item) => InvoicePaymentRecord(
                      paymentId: PatientDetailDisplay.text(item.id),
                      date: PatientDetailDisplay.date(item.date),
                      amount: PatientDetailDisplay.moneyPlain(item.amount),
                      method: PatientDetailDisplay.text(item.method),
                      type: PatientDetailDisplay.text(item.type),
                    ),
                  )
                  .toList(),
            );
          },
        );
      },
    );
  }
}
