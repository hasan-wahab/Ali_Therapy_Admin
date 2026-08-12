import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_record_grid_item.dart';

// ============================================================
// PATIENT DETAIL RECORDS GRID
// ------------------------------------------------------------
// Records tab: all record shortcuts in a 2-column grid.
// ============================================================

class PatientDetailRecordsGrid extends StatelessWidget {
  const PatientDetailRecordsGrid({super.key});

  void _comingSoon(BuildContext context, String title) {
    AppSnackbar.info(context, '$title coming soon');
  }

  @override
  Widget build(BuildContext context) {
    final items = <PatientDetailRecordGridItem>[
      PatientDetailRecordGridItem(
        title: 'Visits',
        icon: Icons.calendar_month_outlined,
        onTap: () => AppNavigation.openTotalVisits(context),
      ),
      PatientDetailRecordGridItem(
        title: 'Sessions',
        icon: Icons.monitor_heart_outlined,
        onTap: () => AppNavigation.openTherapySessions(context),
      ),
      PatientDetailRecordGridItem(
        title: 'Invoices',
        icon: Icons.receipt_long_outlined,
        onTap: () => AppNavigation.openInvoices(context),
      ),
      PatientDetailRecordGridItem(
        title: 'Packages',
        icon: Icons.inventory_2_outlined,
        onTap: () => AppNavigation.openActivePackages(context),
      ),
      PatientDetailRecordGridItem(
        title: 'Clinical History',
        icon: Icons.history_rounded,
        onTap: () => AppNavigation.openClinicalHistory(context),
      ),
      PatientDetailRecordGridItem(
        title: 'Consultant Details',
        icon: Icons.badge_outlined,
        onTap: () => AppNavigation.openConsultantDetails(context),
      ),
      PatientDetailRecordGridItem(
        title: 'Reconsultations',
        icon: Icons.note_add_outlined,
        onTap: () => _comingSoon(context, 'Reconsultations'),
      ),
      PatientDetailRecordGridItem(
        title: 'Full Report',
        icon: Icons.article_outlined,
        onTap: () => _comingSoon(context, 'Full Report'),
      ),
      PatientDetailRecordGridItem(
        title: 'NFC Card',
        icon: Icons.credit_card_outlined,
        onTap: () => _comingSoon(context, 'NFC Card'),
      ),
      PatientDetailRecordGridItem(
        title: 'Patient Files',
        icon: Icons.folder_outlined,
        onTap: () => _comingSoon(context, 'Patient Files'),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 6.h,
        crossAxisSpacing: 6.w,
        // Same height as ReportsGrid tiles
        childAspectRatio: 2.15,
      ),
      itemBuilder: (context, index) => items[index],
    );
  }
}
