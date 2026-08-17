import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';

// ============================================================
// PATIENT REPORT STAFF FILTERS
// ------------------------------------------------------------
// Consultant / therapist / AM / receptionist filters (UI only).
// ============================================================

class PatientReportStaffFilters extends StatelessWidget {
  const PatientReportStaffFilters({super.key});

  static const _consultants = [
    'Filter by Consultant',
    'Dr. Ahmed',
    'Dr. Sara',
  ];

  static const _therapists = [
    'Filter by Therapist',
    'Therapist A',
    'Therapist B',
  ];

  static const _assistantManagers = [
    'Filter by Assistant Manager',
    'AM One',
    'AM Two',
  ];

  static const _receptionists = [
    'Filter by Receptionist',
    'FIZZA BIBI',
    'KAINAT RASHEED',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 6.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.groups_outlined,
                size: AppSizes.iconSm,
                color: AppColors.primary,
              ),
              SizedBox(width: 6.w),
              Text(
                'All Patients Report',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              const Expanded(
                child: AppDropdownField(
                  compact: true,
                  enableSearch: true,
                  label: 'Consultant',
                  hintText: 'All Consultants',
                  items: _consultants,
                  value: 'Filter by Consultant',
                ),
              ),
              SizedBox(width: 6.w),
              const Expanded(
                child: AppDropdownField(
                  compact: true,
                  enableSearch: true,
                  label: 'Therapist',
                  hintText: 'All Therapists',
                  items: _therapists,
                  value: 'Filter by Therapist',
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              const Expanded(
                child: AppDropdownField(
                  compact: true,
                  enableSearch: true,
                  label: 'Assistant Manager',
                  hintText: 'All Assistant Managers',
                  items: _assistantManagers,
                  value: 'Filter by Assistant Manager',
                ),
              ),
              SizedBox(width: 6.w),
              const Expanded(
                child: AppDropdownField(
                  compact: true,
                  enableSearch: true,
                  label: 'Receptionist',
                  hintText: 'All Receptionists',
                  items: _receptionists,
                  value: 'Filter by Receptionist',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
