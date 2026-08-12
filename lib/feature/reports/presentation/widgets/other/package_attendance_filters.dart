import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// PACKAGE ATTENDANCE FILTERS
// ------------------------------------------------------------
// Clinic, gender, therapist + Reset.
// Search lives in the app bar.
// ============================================================

class PackageAttendanceFilters extends StatelessWidget {
  const PackageAttendanceFilters({super.key});

  static const _clinics = [
    'All Clinics',
    'Clinic 1',
    'Clinic 2',
    'Clinic 3 (Neuro and Stroke)',
    'Corporate',
  ];

  static const _genders = [
    'All Genders',
    'Male',
    'Female',
  ];

  static const _therapists = [
    'All Therapists',
    'DR SUHAIL MEHMOOD',
    'AMNA RIAZ',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReportFiltersHeader(
            onReset: () {
              AppSnackbar.info(context, 'Filters reset (UI only)');
            },
          ),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: AppDropdownField(
                  label: 'Clinic',
                  hintText: 'All Clinics',
                  items: _clinics,
                  value: 'All Clinics',
                ),
              ),
              SizedBox(width: 8.w),
              const Expanded(
                child: AppDropdownField(
                  label: 'Gender',
                  hintText: 'All Genders',
                  items: _genders,
                  value: 'All Genders',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          const AppDropdownField(
            label: 'Therapist',
            hintText: 'All Therapists',
            items: _therapists,
            value: 'All Therapists',
          ),
        ],
      ),
    );
  }
}
