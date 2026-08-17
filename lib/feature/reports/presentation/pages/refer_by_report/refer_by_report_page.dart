import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/refer_by_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/refer_by_filters.dart';

// ============================================================
// REFER BY REPORT PAGE
// ------------------------------------------------------------
// Mobile report: filters + referral source cards.
// ============================================================

class ReferByReportPage extends StatelessWidget {
  const ReferByReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBackAppBar(title: 'Refer By Report'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
              child: AppSearchFilterSection(
                searchHint: 'Search referral source…',
                filtersPanel: const ReferByFilters(),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                children: [
                  const ReferByCard(
                    initiallyExpanded: true,
                    referralSource: 'Dr Iqbal CDA hospital',
                    referralType: 'Other Referral',
                    patientCount: 1,
                    grossBilled: 'PKR 3,000.00',
                    consultation: 'PKR 3,000.00',
                    packageBilled: 'PKR 0.00',
                    directDiscount: 'PKR 0.00',
                    insuranceDiscount: 'PKR 0.00',
                    packagePaid: 'PKR 0.00',
                    totalReceived: 'PKR 3,000.00',
                    dues: 'PKR 0.00',
                  ),
                  SizedBox(height: 10.h),
                  const ReferByCard(
                    referralSource: 'Dr. M. Shafique',
                    referralType: 'Other Referral',
                    patientCount: 1,
                    grossBilled: 'PKR 18,000.00',
                    consultation: 'PKR 3,000.00',
                    packageBilled: 'PKR 15,000.00',
                    directDiscount: 'PKR 0.00',
                    insuranceDiscount: 'PKR 0.00',
                    packagePaid: 'PKR 0.00',
                    totalReceived: 'PKR 0.00',
                    dues: 'PKR 18,000.00',
                  ),
                  SizedBox(height: 10.h),
                  const ReferByCard(
                    referralSource: 'Dr. Ayesha Khan',
                    referralType: 'Other Referral',
                    patientCount: 2,
                    grossBilled: 'PKR 12,000.00',
                    consultation: 'PKR 6,000.00',
                    packageBilled: 'PKR 6,000.00',
                    directDiscount: 'PKR 500.00',
                    insuranceDiscount: 'PKR 0.00',
                    packagePaid: 'PKR 4,000.00',
                    totalReceived: 'PKR 4,000.00',
                    dues: 'PKR 7,500.00',
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
