import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/entities/patient_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_report_card.dart';

// ============================================================
// PATIENT REPORT CARD LIST
// ------------------------------------------------------------
// Builds expandable patient cards from API rows.
// ============================================================

class PatientReportCardList extends StatelessWidget {
  const PatientReportCardList({
    super.key,
    required this.rows,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<PatientReportEntity> rows;
  final bool hasMore;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No patient records found',
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
        final row = rows[index];
        return PatientReportCard(
          initiallyExpanded: index == 0,
          index: index + 1,
          name: row.patientName,
          email: row.email,
          visitsCount: row.visitsCount,
          createdAt: row.createdAt,
          createdBy: row.createdBy,
        );
      },
    );
  }
}
