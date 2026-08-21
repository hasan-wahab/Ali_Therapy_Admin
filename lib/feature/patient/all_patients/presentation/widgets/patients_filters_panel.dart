import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_filter_date_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// PATIENTS FILTERS PANEL
// ------------------------------------------------------------
// Same filter pattern as Patient Dues:
// dropdowns only update local draft; list updates after Apply.
// UI only until the patients API is wired.
// ============================================================

class PatientsFiltersPanel extends StatefulWidget {
  const PatientsFiltersPanel({
    super.key,
    required this.clinic,
    required this.receptionist,
    this.fromDate,
    this.toDate,
    required this.onApply,
    this.onApplied,
  });

  final String clinic;
  final String receptionist;
  final String? fromDate;
  final String? toDate;
  final void Function({
    required String clinic,
    required String receptionist,
    String? fromDate,
    String? toDate,
  }) onApply;
  final VoidCallback? onApplied;

  static const allClinics = 'All Clinics';
  static const allReceptionists = 'All Receptionists';

  @override
  State<PatientsFiltersPanel> createState() => _PatientsFiltersPanelState();
}

class _PatientsFiltersPanelState extends State<PatientsFiltersPanel> {
  static const _clinics = [
    PatientsFiltersPanel.allClinics,
    'Clinic 1',
    'Clinic 2',
    'Clinic 3 (Neuro and Stroke)',
    'Corporate',
  ];

  static const _receptionists = [
    PatientsFiltersPanel.allReceptionists,
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
    'SANA MAJEED',
  ];

  late String _clinic;
  late String _receptionist;
  String? _fromDate;
  String? _toDate;
  int _resetToken = 0;

  @override
  void initState() {
    super.initState();
    _syncFromApplied();
  }

  @override
  void didUpdateWidget(covariant PatientsFiltersPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.clinic != widget.clinic ||
        oldWidget.receptionist != widget.receptionist ||
        oldWidget.fromDate != widget.fromDate ||
        oldWidget.toDate != widget.toDate) {
      setState(() {
        _syncFromApplied();
        _resetToken++;
      });
    }
  }

  void _syncFromApplied() {
    _clinic = widget.clinic;
    _receptionist = widget.receptionist;
    _fromDate = widget.fromDate;
    _toDate = widget.toDate;
  }

  bool get _hasPendingChanges =>
      _clinic != widget.clinic ||
      _receptionist != widget.receptionist ||
      _fromDate != widget.fromDate ||
      _toDate != widget.toDate;

  void _onReset() {
    setState(() {
      _clinic = PatientsFiltersPanel.allClinics;
      _receptionist = PatientsFiltersPanel.allReceptionists;
      _fromDate = null;
      _toDate = null;
      _resetToken++;
    });
  }

  void _onApply() {
    widget.onApply(
      clinic: _clinic,
      receptionist: _receptionist,
      fromDate: _fromDate,
      toDate: _toDate,
    );
    widget.onApplied?.call();
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
            onApply: _onApply,
            applyEnabled: _hasPendingChanges,
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
                hintText: PatientsFiltersPanel.allClinics,
                enableSearch: true,
                items: _clinics,
                value: _clinics.contains(_clinic)
                    ? _clinic
                    : PatientsFiltersPanel.allClinics,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _clinic = value);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('receptionist_$_resetToken'),
                label: 'Receptionist',
                hintText: PatientsFiltersPanel.allReceptionists,
                enableSearch: true,
                items: _receptionists,
                value: _receptionists.contains(_receptionist)
                    ? _receptionist
                    : PatientsFiltersPanel.allReceptionists,
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
