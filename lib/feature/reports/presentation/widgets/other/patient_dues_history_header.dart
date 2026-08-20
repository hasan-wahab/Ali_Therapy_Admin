import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// PATIENT DUES HISTORY HEADER
// ------------------------------------------------------------
// Patient summary under the shared AppBar (name, CNIC, phone).
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
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(patientName, style: AppTextStyles.name),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(
                Icons.badge_outlined,
                size: AppSizes.iconSm,
                color: AppColors.primary,
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  cnic,
                  style: AppTextStyles.bodySmall,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: AppSizes.iconSm,
                color: AppColors.primary,
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  phone,
                  style: AppTextStyles.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
