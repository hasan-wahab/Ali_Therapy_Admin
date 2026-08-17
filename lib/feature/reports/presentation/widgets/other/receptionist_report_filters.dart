import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_date_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// RECEPTIONIST REPORT FILTERS
// ------------------------------------------------------------
// Clinic, receptionist, type, dates + Reset (UI only).
// ============================================================

class ReceptionistReportFilters extends StatelessWidget {
  const ReceptionistReportFilters({super.key});

  static const _clinics = [
    'All Clinics',
    'Clinic 1',
    'Clinic 2',
    'Clinic 3 (Neuro and Stroke)',
    'Corporate',
  ];

  static const _receptionists = [
    'All Receptionists',
    'FIZZA BIBI',
    'KAINAT RASHEED',
    'SABA NOOR',
  ];

  static const _types = [
    'All Types',
    'Therapy Session',
    'Consultation',
    'Reconsultation',
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
          ReportFiltersHeader(
            onReset: () {
              AppSnackbar.info(context, 'Filters reset (UI only)');
            },
          ),
          SizedBox(height: 6.h),
          AppTabletFieldsGrid(
            phoneColumns: 2,
            tabletColumns: 3,
            children: [
              const AppDropdownField(
                compact: true,
                enableSearch: true,
                label: 'Clinic',
                hintText: 'All Clinics',
                items: _clinics,
                value: 'All Clinics',
              ),
              const AppDropdownField(
                compact: true,
                enableSearch: true,
                label: 'Receptionist',
                hintText: 'All Receptionists',
                items: _receptionists,
                value: 'All Receptionists',
              ),
              const AppDropdownField(
                compact: true,
                enableSearch: true,
                label: 'Type',
                hintText: 'All Types',
                items: _types,
                value: 'All Types',
              ),
              const ReportDateField(
                label: 'From Date',
                valueText: '08/11/2026',
              ),
              const ReportDateField(
                label: 'To Date',
                valueText: '08/11/2026',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
