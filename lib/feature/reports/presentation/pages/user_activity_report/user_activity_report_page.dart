import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/user_activity_report_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/user_activity_report_filters.dart';

// ============================================================
// USER ACTIVITY REPORT PAGE
// ------------------------------------------------------------
// Mobile user activity report (packages + payments).
// ============================================================

class UserActivityReportPage extends StatelessWidget {
  const UserActivityReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBackAppBar(title: 'User Activity Report'),
      body: AppTabletSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
              child: AppSearchFilterSection(
                searchHint: 'Search patient, CNIC…',
                filtersPanel: const UserActivityReportFilters(),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                children: [
                  const UserActivityReportCard(
                    initiallyExpanded: true,
                    index: 1,
                    patientName: 'Muhammad Ali',
                    cnic: '35202-1234567-8',
                    packageName: '7 day Package',
                    sessionsUsed: 5,
                    sessionsTotal: 7,
                    remaining: 2,
                    invoiceType: 'Package',
                    paymentDate: 'Aug 11, 2026',
                    paymentMethod: 'Card',
                    amount: 'PKR 2,500.00',
                  ),
                  SizedBox(height: 10.h),
                  const UserActivityReportCard(
                    index: 2,
                    patientName: 'Amina Bibi',
                    cnic: '37105-0248077-0',
                    packageName: '15 day Package',
                    sessionsUsed: 8,
                    sessionsTotal: 15,
                    remaining: 7,
                    invoiceType: 'Package',
                    paymentDate: 'Aug 10, 2026',
                    paymentMethod: 'Cash',
                    amount: 'PKR 5,000.00',
                  ),
                  SizedBox(height: 10.h),
                  const UserActivityReportCard(
                    index: 3,
                    patientName: 'Farid Ullah',
                    cnic: '82401-9475130-9',
                    packageName: '10 day Package',
                    sessionsUsed: 10,
                    sessionsTotal: 10,
                    remaining: 0,
                    invoiceType: 'Package',
                    paymentDate: 'Aug 09, 2026',
                    paymentMethod: 'Card',
                    amount: 'PKR 3,000.00',
                  ),
                  SizedBox(height: 10.h),
                  const UserActivityReportCard(
                    index: 4,
                    patientName: 'Noor Fatima',
                    cnic: '35201-1111222-3',
                    packageName: '7 day Package',
                    sessionsUsed: 2,
                    sessionsTotal: 7,
                    remaining: 5,
                    invoiceType: 'Package',
                    paymentDate: 'Aug 08, 2026',
                    paymentMethod: 'Cash',
                    amount: 'PKR 2,500.00',
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
