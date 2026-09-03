import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_display.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_record_refresh_shell.dart';
import 'package:ali_therapy_admin/feature/patient/total_visits/presentation/widgets/other/total_visit_card.dart';

// ============================================================
// TOTAL VISITS PAGE
// ------------------------------------------------------------
// Visits from Patient Full View (passed via extra).
// Pull refresh reloads Full View — AppBar underline loading.
// ============================================================

class TotalVisitsPage extends StatelessWidget {
  const TotalVisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PatientDetailRecordRefreshShell(
      title: 'Total Visits',
      builder: (context, detail) {
        final visits = detail.visits;

        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          itemCount: visits.length + 1,
          separatorBuilder: (_, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            if (index == 0) {
              final count = visits.length;
              return Text(
                count == 1 ? '1 visit' : '$count visits',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              );
            }

            final visit = visits[index - 1];
            return TotalVisitCard(
              date: PatientDetailDisplay.date(visit.date),
              type: PatientDetailDisplay.text(visit.type),
              doctor: PatientDetailDisplay.text(visit.doctor),
              stage: PatientDetailDisplay.text(visit.stage),
              amount: PatientDetailDisplay.moneyRs(visit.amount),
            );
          },
        );
      },
    );
  }
}
