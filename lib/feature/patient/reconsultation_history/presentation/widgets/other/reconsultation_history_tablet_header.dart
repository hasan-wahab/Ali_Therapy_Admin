import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// RECONSULTATION HISTORY TABLET HEADER
// ------------------------------------------------------------
// Column titles for the tablet table layout.
// ============================================================

class ReconsultationHistoryTabletHeader extends StatelessWidget {
  const ReconsultationHistoryTabletHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          _cell('Date', flex: 3),
          _cell('Consultant', flex: 3),
          _cell('Recovery Score', flex: 2),
          _cell('Patient Complaint', flex: 3),
          _cell('Actions', flex: 2, alignEnd: true),
        ],
      ),
    );
  }

  Widget _cell(String label, {required int flex, bool alignEnd = false}) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        textAlign: alignEnd ? TextAlign.end : TextAlign.start,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
