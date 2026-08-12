import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_date_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// PATIENT DUES FILTERS
// ------------------------------------------------------------
// Dates + clinic / receptionist in one row (UI only).
// Search lives in the app bar.
// ============================================================

class PatientDuesFilters extends StatelessWidget {
  const PatientDuesFilters({super.key});

  static const _clinics = [
    'All clinics',
    'Clinic 1',
    'Clinic 2',
    'Clinic 3 (Neuro and Stroke)',
    'Corporate',
  ];

  static const _receptionists = [
    'All receptionists',
    'AAILA REHMAN',
    'AMAN QAMAR ABBASI',
    'Amna Anum',
    'AMNA RIAZ',
    'ANEELA BIBI',
    'AQSA BIBI',
    'FARAH NAZ',
    'KAINAT RASHEED',
    'NIDA FATIMA',
    'SABA NOOR',
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
          const ReportFiltersHeader(),
          SizedBox(height: 10.h),
          // Dates
          Row(
            children: [
              const Expanded(
                child: ReportDateField(
                  label: 'From Date',
                  valueText: '08/11/2026',
                ),
              ),
              SizedBox(width: 8.w),
              const Expanded(
                child: ReportDateField(
                  label: 'To Date',
                  valueText: '08/11/2026',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Clinic + Receptionist in one row
          Row(
            children: [
              const Expanded(
                child: AppDropdownField(
                  label: 'Clinic',
                  hintText: 'All clinics',
                  items: _clinics,
                  value: 'All clinics',
                ),
              ),
              SizedBox(width: 8.w),
              const Expanded(
                child: AppDropdownField(
                  label: 'Receptionist',
                  hintText: 'All receptionists',
                  items: _receptionists,
                  value: 'All receptionists',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
