import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_date_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// REFER BY FILTERS
// ------------------------------------------------------------
// Dates + clinic / receptionist / referral type (UI only).
// ============================================================

class ReferByFilters extends StatelessWidget {
  const ReferByFilters({super.key});

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
    'KAINAT RASHEED',
  ];

  static const _referralTypes = [
    'All Referral Types',
    'Other Referral',
    'Doctor Referral',
    'Self',
    'Online',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 6.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ReportFiltersHeader(),
          SizedBox(height: 6.h),
          AppTabletFieldsGrid(
            phoneColumns: 2,
            tabletColumns: 3,
            children: [
              const ReportDateField(
                label: 'From Date',
                valueText: '08/11/2026',
              ),
              const ReportDateField(
                label: 'To Date',
                valueText: '08/11/2026',
              ),
              const AppDropdownField(
                compact: true,
                enableSearch: true,
                label: 'Clinic',
                hintText: 'All clinics',
                items: _clinics,
                value: 'All clinics',
              ),
              const AppDropdownField(
                compact: true,
                enableSearch: true,
                label: 'Receptionist',
                hintText: 'All receptionists',
                items: _receptionists,
                value: 'All receptionists',
              ),
              const AppDropdownField(
                compact: true,
                enableSearch: true,
                label: 'Referral Type',
                hintText: 'All Referral Types',
                items: _referralTypes,
                value: 'All Referral Types',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
