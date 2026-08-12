import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/invoices/presentation/widgets/other/invoice_card.dart';
import 'package:ali_therapy_admin/feature/patient/invoices/presentation/widgets/other/invoice_payment_record.dart';

// ============================================================
// INVOICES PAGE
// ------------------------------------------------------------
// List of invoice cards (sample data from Invoice screen).
// ============================================================

class InvoicesPage extends StatelessWidget {
  const InvoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Invoices'),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          children: [
            Text(
              '2 invoices',
              style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            const InvoiceCard(
              initiallyExpanded: true,
              invoiceId: '123',
              type: 'PACKAGE',
              date: '05/05/2026',
              amount: '15000.0',
              discount: '0.0',
              paid: '3000.0',
              due: '12000.0',
              status: 'partially_paid',
              payments: [
                InvoicePaymentRecord(
                  paymentId: '104',
                  date: '05/05/2026',
                  amount: '3000.0',
                  method: 'cash',
                  type: 'invoice_payment',
                ),
              ],
            ),
            SizedBox(height: 10.h),
            const InvoiceCard(
              invoiceId: '112',
              type: 'PACKAGE',
              date: '05/05/2026',
              amount: '3000.0',
              discount: '0.0',
              paid: '3000.0',
              due: '0.0',
              status: 'paid',
              payments: [
                InvoicePaymentRecord(
                  paymentId: '98',
                  date: '05/05/2026',
                  amount: '3000.0',
                  method: 'cash',
                  type: 'invoice_payment',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
