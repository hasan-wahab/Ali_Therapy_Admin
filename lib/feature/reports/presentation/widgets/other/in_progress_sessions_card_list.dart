import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/in_progress_sessions_card.dart';

// ============================================================
// IN-PROGRESS SESSIONS CARD LIST
// ------------------------------------------------------------
// Builds expandable session cards from API rows.
// ============================================================

class InProgressSessionsCardList extends StatelessWidget {
  const InProgressSessionsCardList({
    super.key,
    required this.rows,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<InProgressSessionsEntity> rows;
  final bool hasMore;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No in-progress sessions found',
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
        return InProgressSessionsCard(
          initiallyExpanded: index == 0,
          patientName: row.patientName,
          mrNo: row.mrNo,
          cnic: row.patientCnic,
          sessionTypes: row.sessionTypes,
          doctorName: row.consultantName,
          therapistName: row.therapistName,
          clinic: row.clinicName,
          status: row.status,
        );
      },
    );
  }
}
