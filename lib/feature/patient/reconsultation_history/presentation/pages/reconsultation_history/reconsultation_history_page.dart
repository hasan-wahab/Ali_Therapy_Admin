import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_record_refresh_shell.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_history_card.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_history_item.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_history_tablet_body.dart';

// ============================================================
// RECONSULTATION HISTORY PAGE
// ------------------------------------------------------------
// Records tab → Reconsultations.
// UI-first sample list. View Report opens the report page.
// ============================================================

class ReconsultationHistoryPage extends StatelessWidget {
  const ReconsultationHistoryPage({super.key});

  void _onViewReport(BuildContext context) {
    AppNavigation.openReconsultationHistoryReport(context);
  }

  @override
  Widget build(BuildContext context) {
    return PatientDetailRecordRefreshShell(
      title: 'Reconsultation History',
      builder: (context, detail) {
        final items = reconsultationHistorySample;
        final isTablet = AppDevice.isTablet(context);
        final hPad = isTablet
            ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
            : 16.w;

        if (isTablet) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: ReconsultationHistoryTabletBody(
              items: items,
              onViewReport: (_) => _onViewReport(context),
            ),
          );
        }

        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          padding: EdgeInsets.fromLTRB(hPad, 8.h, hPad, 24.h),
          itemCount: items.isEmpty ? 2 : items.length + 1,
          separatorBuilder: (_, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            if (index == 0) {
              final count = items.length;
              return Text(
                count == 1
                    ? '1 reconsultation'
                    : '$count reconsultations',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              );
            }

            if (items.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Center(
                  child: Text(
                    'No reconsultations found',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              );
            }

            final item = items[index - 1];
            return ReconsultationHistoryCard(
              item: item,
              onViewReport: () => _onViewReport(context),
            );
          },
        );
      },
    );
  }
}
