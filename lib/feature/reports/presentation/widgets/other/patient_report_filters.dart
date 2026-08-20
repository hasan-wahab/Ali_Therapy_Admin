import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/entities/patient_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/patient_report_bloc/patient_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_date_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// PATIENT REPORT FILTERS PANEL
// ------------------------------------------------------------
// Staff / clinic lists from GET /reports/filter-options.
// Dropdowns only update local draft.
// API runs only after pressing "Apply".
// ============================================================

class PatientReportFilters extends StatefulWidget {
  const PatientReportFilters({
    super.key,
    required this.filterOptions,
    required this.currentQuery,
    this.onApplied,
  });

  final ReportFilterOptionsEntity filterOptions;
  final PatientReportQuery currentQuery;
  final VoidCallback? onApplied;

  @override
  State<PatientReportFilters> createState() => _PatientReportFiltersState();
}

class _PatientReportFiltersState extends State<PatientReportFilters> {
  static const _allClinics = 'All Clinics';
  static const _allConsultants = 'All Consultants';
  static const _allTherapists = 'All Therapists';
  static const _allAssistantManagers = 'All Assistant Managers';
  static const _allReceptionists = 'All Receptionists';
  static const _perPageLabels = ['15', '25', '50', '100'];

  late String? _fromDateApi;
  late String? _toDateApi;
  late String _clinic;
  late String _consultant;
  late String _therapist;
  late String _assistantManager;
  late String _receptionist;
  late String _perPage;
  int _resetToken = 0;

  List<String> get _clinicItems => [
        _allClinics,
        ...widget.filterOptions.clinics
            .map((c) => c.name)
            .where((name) => name.isNotEmpty),
      ];

  List<String> get _consultantItems => [
        _allConsultants,
        ...widget.filterOptions.consultants
            .map((c) => c.name)
            .where((name) => name.isNotEmpty),
      ];

  List<String> get _therapistItems => [
        _allTherapists,
        ...widget.filterOptions.therapists
            .map((t) => t.name)
            .where((name) => name.isNotEmpty),
      ];

  List<String> get _assistantManagerItems => [
        _allAssistantManagers,
        ...widget.filterOptions.assistantManagers
            .map((a) => a.name)
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
  void didUpdateWidget(covariant PatientReportFilters oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filterOptions != widget.filterOptions ||
        oldWidget.currentQuery != widget.currentQuery) {
      setState(() {
        _syncFromQuery(widget.currentQuery);
        _resetToken++;
      });
    }
  }

  void _syncFromQuery(PatientReportQuery q) {
    _fromDateApi = q.fromDate;
    _toDateApi = q.toDate;
    _clinic = _nameForClinicId(q.clinicId);
    _consultant = _nameForConsultantId(q.consultantId);
    _therapist = _nameForTherapistId(q.therapistId);
    _assistantManager = _nameForAssistantManagerId(q.assistantManagerId);
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

  String _nameForConsultantId(int? id) {
    if (id == null) return _allConsultants;
    for (final c in widget.filterOptions.consultants) {
      if (c.id == id) return c.name;
    }
    return _allConsultants;
  }

  String _nameForTherapistId(int? id) {
    if (id == null) return _allTherapists;
    for (final t in widget.filterOptions.therapists) {
      if (t.id == id) return t.name;
    }
    return _allTherapists;
  }

  String _nameForAssistantManagerId(int? id) {
    if (id == null) return _allAssistantManagers;
    for (final a in widget.filterOptions.assistantManagers) {
      if (a.id == id) return a.name;
    }
    return _allAssistantManagers;
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

  int? _consultantIdForName(String name) {
    if (name == _allConsultants) return null;
    for (final c in widget.filterOptions.consultants) {
      if (c.name == name) return c.id;
    }
    return null;
  }

  int? _therapistIdForName(String name) {
    if (name == _allTherapists) return null;
    for (final t in widget.filterOptions.therapists) {
      if (t.name == name) return t.id;
    }
    return null;
  }

  int? _assistantManagerIdForName(String name) {
    if (name == _allAssistantManagers) return null;
    for (final a in widget.filterOptions.assistantManagers) {
      if (a.name == name) return a.id;
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
    setState(() => _fromDateApi = _toApiDate(picked));
  }

  Future<void> _pickTo() async {
    final picked = await ReportDateField.pickDate(context);
    if (picked == null) return;
    setState(() => _toDateApi = _toApiDate(picked));
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

  PatientReportQuery _draftQuery() {
    return PatientReportQuery(
      search: widget.currentQuery.search,
      fromDate: _fromDateApi,
      toDate: _toDateApi,
      clinicId: _clinicIdForName(_clinic),
      consultantId: _consultantIdForName(_consultant),
      therapistId: _therapistIdForName(_therapist),
      assistantManagerId: _assistantManagerIdForName(_assistantManager),
      receptionistId: _receptionistIdForName(_receptionist),
      perPage: int.tryParse(_perPage) ?? 15,
      page: 1,
    );
  }

  PatientReportQuery get _normalizedApplied => PatientReportQuery(
        search: widget.currentQuery.search,
        fromDate: widget.currentQuery.fromDate,
        toDate: widget.currentQuery.toDate,
        clinicId: widget.currentQuery.clinicId,
        consultantId: widget.currentQuery.consultantId,
        therapistId: widget.currentQuery.therapistId,
        assistantManagerId: widget.currentQuery.assistantManagerId,
        receptionistId: widget.currentQuery.receptionistId,
        perPage: widget.currentQuery.perPage,
        page: 1,
      );

  bool get _hasPendingChanges => _draftQuery() != _normalizedApplied;

  void _applyFilters() {
    final draft = _draftQuery();
    context.read<PatientReportBloc>().add(
          PatientReportFiltersApplied(
            fromDate: draft.fromDate,
            toDate: draft.toDate,
            clinicId: draft.clinicId,
            consultantId: draft.consultantId,
            therapistId: draft.therapistId,
            assistantManagerId: draft.assistantManagerId,
            receptionistId: draft.receptionistId,
            perPage: draft.perPage,
            clearFromDate: draft.fromDate == null,
            clearToDate: draft.toDate == null,
            clearClinicId: draft.clinicId == null,
            clearConsultantId: draft.consultantId == null,
            clearTherapistId: draft.therapistId == null,
            clearAssistantManagerId: draft.assistantManagerId == null,
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
          AppTabletFieldsGrid(
            phoneColumns: 2,
            tabletColumns: 3,
            children: [
              ReportDateField(
                key: ValueKey('pr_from_$_resetToken'),
                label: 'From Date',
                valueText: _displayDate(_fromDateApi),
                onTap: _pickFrom,
              ),
              ReportDateField(
                key: ValueKey('pr_to_$_resetToken'),
                label: 'To Date',
                valueText: _displayDate(_toDateApi),
                onTap: _pickTo,
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('pr_clinic_$_resetToken'),
                enableSearch: true,
                label: 'Clinic',
                hintText: _allClinics,
                items: _clinicItems,
                value: _clinic,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _clinic = v);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('pr_consultant_$_resetToken'),
                enableSearch: true,
                label: 'Consultant',
                hintText: _allConsultants,
                items: _consultantItems,
                value: _consultant,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _consultant = v);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('pr_therapist_$_resetToken'),
                enableSearch: true,
                label: 'Therapist',
                hintText: _allTherapists,
                items: _therapistItems,
                value: _therapist,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _therapist = v);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('pr_am_$_resetToken'),
                enableSearch: true,
                label: 'Assistant Manager',
                hintText: _allAssistantManagers,
                items: _assistantManagerItems,
                value: _assistantManager,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _assistantManager = v);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('pr_rec_$_resetToken'),
                enableSearch: true,
                label: 'Receptionist',
                hintText: _allReceptionists,
                items: _receptionistItems,
                value: _receptionist,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _receptionist = v);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('pr_per_page_$_resetToken'),
                label: 'Per Page',
                hintText: '15',
                items: _perPageLabels,
                value: _perPage,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _perPage = v);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
