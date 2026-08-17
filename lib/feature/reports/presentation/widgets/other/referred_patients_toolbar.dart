import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';

// ============================================================
// REFERRED PATIENTS TOOLBAR
// ------------------------------------------------------------
// Total patients badge + search field.
// ============================================================

class ReferredPatientsToolbar extends StatelessWidget {
  const ReferredPatientsToolbar({
    super.key,
    required this.totalPatients,
  });

  final int totalPatients;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text('Total Patients:', style: AppTextStyles.bodySmall),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '$totalPatients',
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          const AppSearchFilterSection(
            searchHint: 'Search by name, CNIC, or phone...',
          ),
        ],
      ),
    );
  }
}
