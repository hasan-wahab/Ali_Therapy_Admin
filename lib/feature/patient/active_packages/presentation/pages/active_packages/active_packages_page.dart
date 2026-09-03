import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/active_packages/presentation/widgets/other/active_package_card.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_display.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_record_refresh_shell.dart';

// ============================================================
// ACTIVE PACKAGES PAGE
// ------------------------------------------------------------
// Packages from Patient Full View (passed via extra).
// Pull refresh reloads Full View — AppBar underline loading.
// ============================================================

class ActivePackagesPage extends StatelessWidget {
  const ActivePackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PatientDetailRecordRefreshShell(
      title: 'Packages',
      builder: (context, detail) {
        final packages = detail.packages;

        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          itemCount: packages.length + 1,
          separatorBuilder: (_, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            if (index == 0) {
              final count = packages.length;
              return Text(
                count == 1 ? '1 active package' : '$count packages',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              );
            }

            final package = packages[index - 1];
            return ActivePackageCard(
              initiallyExpanded: index == 1,
              packageName: PatientDetailDisplay.text(package.packageName),
              completedSessions: package.completedSessions,
              totalSessions: package.totalSessions,
              price: PatientDetailDisplay.moneyRs(package.price),
              status: PatientDetailDisplay.text(package.status),
            );
          },
        );
      },
    );
  }
}
