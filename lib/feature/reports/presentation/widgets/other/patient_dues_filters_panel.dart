import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/entities/patient_dues_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/patient_dues_bloc/patient_dues_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_date_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// PATIENT DUES FILTERS PANEL
// ------------------------------------------------------------
// Clinic / receptionist lists come from GET /reports/filter-options.
// Dropdowns only update local draft.
// API runs only after pressing "Apply Filter".
// ============================================================

class PatientDuesFiltersPanel extends StatefulWidget {
  const PatientDuesFiltersPanel({
    super.key,
    required this.filterOptions,
    required this.currentQuery,
    this.onApplied,
  });

  final ReportFilterOptionsEntity filterOptions;
  final PatientDuesQuery currentQuery;
  final VoidCallback? onApplied;

  @override
  State<PatientDuesFiltersPanel> createState() =>
      _PatientDuesFiltersPanelState();
}

class _PatientDuesFiltersPanelState extends State<PatientDuesFiltersPanel> {
  static const _allClinics = 'All Clinics';
  static const _allReceptionists = 'All Receptionists';
  static const _perPageLabels = ['15', '25', '50', '100'];

  late String? _dateFromApi;
  late String? _dateToApi;
  late String _clinic;
  late String _receptionist;
  late String _perPage;
  int _resetToken = 0;

  List<String> get _clinicItems => [
        _allClinics,
        ...widget.filterOptions.clinics
            .map((c) => c.name)
            .where((name) => name.isNotEmpty),
      ];

  List<String> get _receptionistItems => [
        _allReceptionists,
        ...widget.filterOptions.receptionists
            .map((r) => r.name)
            .where((name) => name.isNotEmpty),
      ];

  @override
  void initState() {
    super.initState();
    _syncFromQuery(widget.currentQuery);
  }

  @override
  void didUpdateWidget(covariant PatientDuesFiltersPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filterOptions != widget.filterOptions ||
        oldWidget.currentQuery != widget.currentQuery) {
      setState(() {
        _syncFromQuery(widget.currentQuery);
        _resetToken++;
      });
    }
  }

  void _syncFromQuery(PatientDuesQuery q) {
    _dateFromApi = q.dateFrom;
    _dateToApi = q.dateTo;
    _clinic = _nameForClinicId(q.clinicId);
    _receptionist = _nameForReceptionistId(q.receptionistId);
    _perPage = q.perPage.toString();
  }

  String _nameForClinicId(int? id) {
    if (id == null) return _allClinics;
    for (final c in widget.filterOptions.clinics) {
      if (c.id == id) return c.name;
    }
    return _allClinics;
  }

  String _nameForReceptionistId(int? id) {
    if (id == null) return _allReceptionists;
    for (final r in widget.filterOptions.receptionists) {
      if (r.id == id) return r.name;
    }
    return _allReceptionists;
  }

  int? _clinicIdForName(String name) {
    if (name == _allClinics) return null;
    for (final c in widget.filterOptions.clinics) {
      if (c.name == name) return c.id;
    }
    return null;
  }

  int? _receptionistIdForName(String name) {
    if (name == _allReceptionists) return null;
    for (final r in widget.filterOptions.receptionists) {
      if (r.name == name) return r.id;
    }
    return null;
  }

  String _displayDate(String? apiDate) {
    if (apiDate == null || apiDate.isEmpty) return '';
    final parsed = DateTime.tryParse(apiDate);
    if (parsed == null) return apiDate;
    return Helpers.formatDate(parsed, pattern: 'MM/dd/yyyy');
  }

  Future<void> _pickFrom() async {
    final picked = await ReportDateField.pickDate(context);
    if (picked == null) return;
    setState(() => _dateFromApi = _toApiDate(picked));
  }

  Future<void> _pickTo() async {
    final picked = await ReportDateField.pickDate(context);
    if (picked == null) return;
    setState(() => _dateToApi = _toApiDate(picked));
  }

  String? _toApiDate(String mmDdYyyy) {
    try {
      final parts = mmDdYyyy.split('/');
      if (parts.length != 3) return null;
      final month = parts[0].padLeft(2, '0');
      final day = parts[1].padLeft(2, '0');
      final year = parts[2];
      return '$year-$month-$day';
    } catch (_) {
      return null;
    }
  }

  PatientDuesQuery _draftQuery() {
    return PatientDuesQuery(
      search: widget.currentQuery.search,
      dateFrom: _dateFromApi,
      dateTo: _dateToApi,
      clinicId: _clinicIdForName(_clinic),
      receptionistId: _receptionistIdForName(_receptionist),
      perPage: int.tryParse(_perPage) ?? 15,
      page: 1,
    );
  }

  PatientDuesQuery get _normalizedApplied => PatientDuesQuery(
        search: widget.currentQuery.search,
        dateFrom: widget.currentQuery.dateFrom,
        dateTo: widget.currentQuery.dateTo,
        clinicId: widget.currentQuery.clinicId,
        receptionistId: widget.currentQuery.receptionistId,
        perPage: widget.currentQuery.perPage,
        page: 1,
      );

  bool get _hasPendingChanges => _draftQuery() != _normalizedApplied;

  void _applyFilters() {
    final draft = _draftQuery();
    context.read<PatientDuesBloc>().add(
          PatientDuesFiltersApplied(
            dateFrom: draft.dateFrom,
            dateTo: draft.dateTo,
            clinicId: draft.clinicId,
            receptionistId: draft.receptionistId,
            perPage: draft.perPage,
            clearDateFrom: draft.dateFrom == null,
            clearDateTo: draft.dateTo == null,
            clearClinicId: draft.clinicId == null,
            clearReceptionistId: draft.receptionistId == null,
          ),
        );
    widget.onApplied?.call();
  }

  void _onReset() {
    setState(() {
      _syncFromQuery(widget.currentQuery.resetFilters());
      _resetToken++;
    });
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
            onApply: _applyFilters,
            applyEnabled: _hasPendingChanges,
          ),
          SizedBox(height: 6.h),
          if (AppDevice.isTablet(context))
            ..._tabletRows()
          else
            ..._mobileRows(),
        ],
      ),
    );
  }

  List<Widget> _mobileRows() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _fromDateField()),
          SizedBox(width: 6.w),
          Expanded(child: _toDateField()),
        ],
      ),
      SizedBox(height: 4.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _clinicField()),
          SizedBox(width: 6.w),
          Expanded(child: _receptionistField()),
        ],
      ),
      SizedBox(height: 4.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _perPageField()),
          const Spacer(),
        ],
      ),
    ];
  }

  List<Widget> _tabletRows() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _fromDateField()),
          SizedBox(width: 6.w),
          Expanded(child: _toDateField()),
          SizedBox(width: 6.w),
          Expanded(child: _clinicField()),
        ],
      ),
      SizedBox(height: 4.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _receptionistField()),
          SizedBox(width: 6.w),
          Expanded(child: _perPageField()),
          const Spacer(),
        ],
      ),
    ];
  }

  Widget _fromDateField() {
    return ReportDateField(
      key: ValueKey('pd_from_$_resetToken'),
      label: 'From Date',
      valueText: _displayDate(_dateFromApi),
      onTap: _pickFrom,
    );
  }

  Widget _toDateField() {
    return ReportDateField(
      key: ValueKey('pd_to_$_resetToken'),
      label: 'To Date',
      valueText: _displayDate(_dateToApi),
      onTap: _pickTo,
    );
  }

  Widget _clinicField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('pd_clinic_$_resetToken'),
      label: 'Clinic',
      hintText: _allClinics,
      enableSearch: true,
      items: _clinicItems,
      value: _clinic,
      onChanged: (v) {
        if (v == null) return;
        setState(() => _clinic = v);
      },
    );
  }

  Widget _receptionistField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('pd_recep_$_resetToken'),
      label: 'Receptionist',
      hintText: _allReceptionists,
      enableSearch: true,
      items: _receptionistItems,
      value: _receptionist,
      onChanged: (v) {
        if (v == null) return;
        setState(() => _receptionist = v);
      },
    );
  }

  Widget _perPageField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('pd_per_page_$_resetToken'),
      label: 'Per Page',
      hintText: '15',
      items: _perPageLabels,
      value: _perPage,
      onChanged: (v) {
        if (v == null) return;
        setState(() => _perPage = v);
      },
    );
  }

}
