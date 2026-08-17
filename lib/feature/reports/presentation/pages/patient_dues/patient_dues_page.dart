import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_filters.dart';

// ============================================================
// PATIENT DUES PAGE
// ------------------------------------------------------------
// Mobile report: filters + sample dues cards.
// ============================================================

class PatientDuesPage extends StatelessWidget {
  const PatientDuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBackAppBar(title: 'Patient Dues'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
              child: AppSearchFilterSection(
                searchHint: 'Search patient, CNIC…',
                filtersPanel: const PatientDuesFilters(),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                children: [
                  const PatientDuesCard(
                    initiallyExpanded: true,
                    patientName: 'Asia Noreen',
                    cnic: '37105-0248077-0',
                    phone: '0331-0303882',
                    registeredBy: 'KAINAT RASHEED',
                    grossBilled: 'PKR 30,000.00',
                    consultation: 'PKR 0.00',
                    packageBilled: 'PKR 30,000.00',
                    directDiscount: 'PKR 9,000.00',
                    directDiscountPercent: '30%',
                    insuranceDiscount: 'PKR 0.00',
                    netBilled: 'PKR 21,000.00',
                    packagePaid: 'PKR 11,000.00',
                    totalReceived: 'PKR 11,000.00',
                    dues: 'PKR 10,000.00',
                  ),
                  SizedBox(height: 10.h),
                  const PatientDuesCard(
                    patientName: 'Saima Raees',
                    cnic: '82401-9475130-9',
                    phone: '0300-1122334',
                    registeredBy: 'KAINAT RASHEED',
                    grossBilled: 'PKR 33,000.00',
                    consultation: 'PKR 3,000.00',
                    packageBilled: 'PKR 30,000.00',
                    directDiscount: 'PKR 0.00',
                    directDiscountPercent: '0%',
                    insuranceDiscount: 'PKR 0.00',
                    netBilled: 'PKR 33,000.00',
                    packagePaid: 'PKR 3,000.00',
                    totalReceived: 'PKR 3,000.00',
                    dues: 'PKR 30,000.00',
                  ),
                  SizedBox(height: 10.h),
                  const PatientDuesCard(
                    patientName: 'Iqra Javed',
                    cnic: '35202-1234567-8',
                    phone: '0321-4455667',
                    registeredBy: 'KAINAT RASHEED',
                    grossBilled: 'PKR 15,000.00',
                    consultation: 'PKR 3,000.00',
                    packageBilled: 'PKR 12,000.00',
                    directDiscount: 'PKR 1,500.00',
                    directDiscountPercent: '10%',
                    insuranceDiscount: 'PKR 0.00',
                    netBilled: 'PKR 13,500.00',
                    packagePaid: 'PKR 5,000.00',
                    totalReceived: 'PKR 5,000.00',
                    dues: 'PKR 8,500.00',
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
