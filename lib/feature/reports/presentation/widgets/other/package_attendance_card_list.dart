import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/entities/package_attendance_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_card.dart';

// ============================================================
// PACKAGE ATTENDANCE CARD LIST
// ------------------------------------------------------------
// Builds expandable patient cards from API rows.
// Only card fields from the list API are shown.
// ============================================================

class PackageAttendanceCardList extends StatelessWidget {
  const PackageAttendanceCardList({
    super.key,
    required this.rows,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<PackageAttendanceEntity> rows;
  final bool hasMore;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No package attendance records found',
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
        final featured = row.featuredPackage;
        return PackageAttendanceCard(
          initiallyExpanded: index == 0,
          patientId: row.id,
          patientName: row.patientName,
          mrNo: row.mrNo,
          gender: row.gender,
          phone: row.patientPhone,
          hasNfc: row.hasNfc,
          packagesTaken: row.packagesTaken,
          activePackageName: featured?.packageName ?? 'No package',
          attended: featured?.sessionsUsed ?? 0,
          totalSessions: featured?.sessionsTotal ?? 0,
        );
      },
    );
  }
}
