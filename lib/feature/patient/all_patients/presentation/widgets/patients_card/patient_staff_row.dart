import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PATIENT STAFF ROW
// ------------------------------------------------------------
// One staff role line (Created By, Therapist…).
// ============================================================

class PatientStaffRow extends StatelessWidget {
  const PatientStaffRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final isEmpty = value.trim().isEmpty || value == '—';

    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Text.rich(
        TextSpan(
          text: '$label: ',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
          children: [
            TextSpan(
              text: isEmpty ? '—' : value,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
