import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_filter_date_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// PATIENTS FILTERS PANEL
// ------------------------------------------------------------
// Same filter pattern as All Employees / reports.
// Clinic, Receptionist (searchable), From/To dates + Reset.
// UI only until API is wired.
// ============================================================

class PatientsFiltersPanel extends StatefulWidget {
  const PatientsFiltersPanel({
    super.key,
    this.onApplied,
  });

  final VoidCallback? onApplied;

  @override
  State<PatientsFiltersPanel> createState() => _PatientsFiltersPanelState();
}

class _PatientsFiltersPanelState extends State<PatientsFiltersPanel> {
  static const _clinics = [
    'All Clinics',
    'Clinic 1',
    'Clinic 2',
    'Clinic 3 (Neuro and Stroke)',
    'Corporate',
  ];

  static const _receptionists = [
    'All Receptionists',
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

  late String _clinic;
  late String _receptionist;
  String? _fromDate;
  String? _toDate;
  int _resetToken = 0;

  @override
  void initState() {
    super.initState();
    _resetValues();
  }

  void _resetValues() {
    _clinic = _clinics.first;
    _receptionist = _receptionists.first;
    _fromDate = null;
    _toDate = null;
  }

  void _onReset() {
    setState(() {
      _resetValues();
      _resetToken++;
    });
    AppSnackbar.info(context, 'Filters reset (UI only)');
  }

  Future<void> _pickFromDate() async {
    final text = await PatientsFilterDateField.pickDate(context);
    if (text == null || !mounted) return;
    setState(() => _fromDate = text);
  }

  Future<void> _pickToDate() async {
    final text = await PatientsFilterDateField.pickDate(context);
    if (text == null || !mounted) return;
    setState(() => _toDate = text);
  }

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
            onReset: _onReset,
            onApply: widget.onApplied,
            applyEnabled: _clinic != _clinics.first ||
                _receptionist != _receptionists.first ||
                _fromDate != null ||
                _toDate != null,
          ),
          SizedBox(height: 6.h),
          AppTabletFieldsGrid(
            phoneColumns: 2,
            tabletColumns: 4,
            children: [
              AppDropdownField(
                compact: true,
                key: ValueKey('clinic_$_resetToken'),
                label: 'Clinic',
                hintText: 'All Clinics',
                enableSearch: true,
                items: _clinics,
                value: _clinic,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _clinic = value);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('receptionist_$_resetToken'),
                label: 'Receptionist',
                hintText: 'All Receptionists',
                enableSearch: true,
                items: _receptionists,
                value: _receptionist,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _receptionist = value);
                },
              ),
              PatientsFilterDateField(
                key: ValueKey('from_$_resetToken'),
                label: 'From Date',
                valueText: _fromDate,
                onTap: _pickFromDate,
              ),
              PatientsFilterDateField(
                key: ValueKey('to_$_resetToken'),
                label: 'To Date',
                valueText: _toDate,
                onTap: _pickToDate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
