import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';

// ============================================================
// PATIENT DUES HISTORY HEADER
// ------------------------------------------------------------
// Title, patient subtitle, and close (X) action.
// ============================================================

class PatientDuesHistoryHeader extends StatelessWidget {
  const PatientDuesHistoryHeader({
    super.key,
    required this.patientName,
    required this.cnic,
    required this.phone,
  });

  final String patientName;
  final String cnic;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 8.w, 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Patient Dues History',
                  style: AppTextStyles.heading3,
                ),
                SizedBox(height: 4.h),
                Text(
                  '$patientName · $cnic · $phone',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => AppNavigation.back(context),
            icon: Icon(
              Icons.close,
              size: AppSizes.iconMd,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
