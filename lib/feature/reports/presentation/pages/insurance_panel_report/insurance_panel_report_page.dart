import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/insurance_panel_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/insurance_panel_filters.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/insurance_panel_total_button.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/insurance_panel_totals.dart';

// ============================================================
// INSURANCE PANEL REPORT PAGE
// ------------------------------------------------------------
// Filters → Total button/card → panel cards.
// ============================================================

class InsurancePanelReportPage extends StatefulWidget {
  const InsurancePanelReportPage({super.key});

  @override
  State<InsurancePanelReportPage> createState() =>
      _InsurancePanelReportPageState();
}

class _InsurancePanelReportPageState extends State<InsurancePanelReportPage> {
  bool _showTotals = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBackAppBar(title: 'Insurance Panel Report'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
              child: AppSearchFilterSection(
                searchHint: 'Search insurance panel…',
                filtersPanel: const InsurancePanelFilters(),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                children: [
                  // Top: Total button OR totals card (same place)
                  if (_showTotals)
                    InsurancePanelTotals(
                      totalInvoices: 18,
                      consultationBilled: 'PKR 24,000.00',
                      packageBilled: 'PKR 171,000.00',
                      totalBilled: 'PKR 195,000.00',
                      totalCovered: 'PKR 63,000.00',
                      totalPaidCash: 'PKR 94,672.50',
                      outstandingBalance: 'PKR 37,327.50',
                      onClose: () => setState(() => _showTotals = false),
                    )
                  else
                    InsurancePanelTotalButton(
                      onTap: () => setState(() => _showTotals = true),
                    ),
                  SizedBox(height: 12.h),
                  const InsurancePanelCard(
                    initiallyExpanded: true,
                    panelName: 'General Discount 30%',
                    policyType: 'Discount',
                    totalInvoices: 3,
                    consultationBilled: 'PKR 9,000.00',
                    packageBilled: 'PKR 90,000.00',
                    totalBilled: 'PKR 99,000.00',
                    totalCovered: 'PKR 29,700.00',
                    totalPaidCash: 'PKR 45,000.00',
                    outstandingBalance: 'PKR 24,300.00',
                  ),
                  SizedBox(height: 10.h),
                  const InsurancePanelCard(
                    panelName: 'Jubilee insurance (30%)',
                    policyType: 'Discount',
                    totalInvoices: 3,
                    consultationBilled: 'PKR 3,000.00',
                    packageBilled: 'PKR 30,000.00',
                    totalBilled: 'PKR 33,000.00',
                    totalCovered: 'PKR 9,900.00',
                    totalPaidCash: 'PKR 18,000.00',
                    outstandingBalance: 'PKR 5,100.00',
                  ),
                  SizedBox(height: 10.h),
                  const InsurancePanelCard(
                    panelName: 'East and west insurance (30%) Credit Base',
                    policyType: 'Credit',
                    totalInvoices: 3,
                    consultationBilled: 'PKR 3,000.00',
                    packageBilled: 'PKR 21,000.00',
                    totalBilled: 'PKR 24,000.00',
                    totalCovered: 'PKR 12,000.00',
                    totalPaidCash: 'PKR 8,000.00',
                    outstandingBalance: 'PKR 4,000.00',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
