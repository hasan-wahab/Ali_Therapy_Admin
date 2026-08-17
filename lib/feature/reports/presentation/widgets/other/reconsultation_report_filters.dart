import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_date_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// RECONSULTATION REPORT FILTERS
// ------------------------------------------------------------
// Consultant, dates, clinic + Reset (UI only).
// ============================================================

class ReconsultationReportFilters extends StatelessWidget {
  const ReconsultationReportFilters({super.key});

  static const _consultants = [
    'All Consultants',
    'DR BILAL AHMED',
    'DR SARA KHAN',
  ];

  static const _clinics = [
    'All Clinics',
    'Clinic 1',
    'Clinic 2',
    'Clinic 3 (Neuro and Stroke)',
    'Corporate',
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
                label: 'Consultant',
                hintText: 'All Consultants',
                items: _consultants,
                value: 'All Consultants',
              ),
              const AppDropdownField(
                compact: true,
                enableSearch: true,
                label: 'Clinic',
                hintText: 'All Clinics',
                items: _clinics,
                value: 'All Clinics',
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
