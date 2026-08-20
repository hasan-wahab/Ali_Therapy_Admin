import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/entities/therapist_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/therapist_report_card.dart';

// ============================================================
// THERAPIST REPORT CARD LIST
// ------------------------------------------------------------
// Builds expandable therapist cards from API rows.
// ============================================================

class TherapistReportCardList extends StatelessWidget {
  const TherapistReportCardList({
    super.key,
    required this.rows,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<TherapistReportEntity> rows;
  final bool hasMore;
  final bool isLoadingMore;

  static String _statusLabel(String status) {
    if (status.isEmpty) return status;
    return status[0].toUpperCase() + status.substring(1).toLowerCase();
  }

  static String _displayCnic(String cnic) {
    final trimmed = cnic.trim();
    if (trimmed.isEmpty || trimmed.toUpperCase() == 'N/A') return 'N/A';
    return trimmed;
  }

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No therapist records found',
            style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
          ),
        ),
      );
    }

    final extra = hasMore ? 1 : 0;

    return SliverList.separated(
      itemCount: rows.length + extra,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        if (index == rows.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: isLoadingMore
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink(),
            ),
          );
        }
        return _card(rows[index], index: index + 1, initiallyExpanded: index == 0);
      },
    );
  }

  Widget _card(
    TherapistReportEntity row, {
    required int index,
    required bool initiallyExpanded,
  }) {
    return TherapistReportCard(
      initiallyExpanded: initiallyExpanded,
      index: index,
      visitId: row.id,
      therapistName: row.therapistName,
      patientName: row.patientName,
      therapyDate: row.visitDate,
      patientCnic: _displayCnic(row.patientCnic),
      clinic: row.clinicName,
      type: _statusLabel(row.status),
    );
  }
}
