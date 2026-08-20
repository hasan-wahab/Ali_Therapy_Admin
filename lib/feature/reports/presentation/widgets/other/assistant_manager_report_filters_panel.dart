import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/assistant_manager_report_bloc/assistant_manager_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_date_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// ASSISTANT MANAGER REPORT FILTERS PANEL
// ------------------------------------------------------------
// AM / clinic lists from GET /reports/filter-options.
// Dropdowns only update local draft.
// API runs only after pressing "Apply Filter".
// ============================================================

class AssistantManagerReportFiltersPanel extends StatefulWidget {
  const AssistantManagerReportFiltersPanel({
    super.key,
    required this.filterOptions,
    required this.currentQuery,
    this.onApplied,
  });

  final ReportFilterOptionsEntity filterOptions;
  final AssistantManagerReportQuery currentQuery;
  final VoidCallback? onApplied;

  @override
  State<AssistantManagerReportFiltersPanel> createState() =>
      _AssistantManagerReportFiltersPanelState();
}

class _AssistantManagerReportFiltersPanelState
    extends State<AssistantManagerReportFiltersPanel> {
  static const _allAssistantManagers = 'All Assistant Managers';
  static const _allClinics = 'All Clinics';
  static const _perPageLabels = ['15', '25', '50', '100'];

  late String? _fromDateApi;
  late String? _toDateApi;
  late String _assistantManager;
  late String _clinic;
  late String _perPage;
  int _resetToken = 0;

  List<String> get _assistantManagerItems => [
        _allAssistantManagers,
        ...widget.filterOptions.assistantManagers
            .map((a) => a.name)
            .where((name) => name.isNotEmpty),
      ];

  List<String> get _clinicItems => [
        _allClinics,
        ...widget.filterOptions.clinics
            .map((c) => c.name)
            .where((name) => name.isNotEmpty),
      ];

  @override
  void initState() {
    super.initState();
    _syncFromQuery(widget.currentQuery);
  }

  @override
  void didUpdateWidget(covariant AssistantManagerReportFiltersPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filterOptions != widget.filterOptions ||
        oldWidget.currentQuery != widget.currentQuery) {
      setState(() {
        _syncFromQuery(widget.currentQuery);
        _resetToken++;
      });
    }
  }

  void _syncFromQuery(AssistantManagerReportQuery q) {
    _fromDateApi = q.fromDate;
    _toDateApi = q.toDate;
    _assistantManager = _nameForAssistantManagerId(q.assistantManagerId);
    _clinic = _nameForClinicId(q.clinicId);
    _perPage = q.perPage.toString();
  }

  String _nameForAssistantManagerId(int? id) {
    if (id == null) return _allAssistantManagers;
    for (final a in widget.filterOptions.assistantManagers) {
      if (a.id == id) return a.name;
    }
    return _allAssistantManagers;
  }

  String _nameForClinicId(int? id) {
    if (id == null) return _allClinics;
    for (final c in widget.filterOptions.clinics) {
      if (c.id == id) return c.name;
    }
    return _allClinics;
  }

  int? _assistantManagerIdForName(String name) {
    if (name == _allAssistantManagers) return null;
    for (final a in widget.filterOptions.assistantManagers) {
      if (a.name == name) return a.id;
    }
    return null;
  }

  int? _clinicIdForName(String name) {
    if (name == _allClinics) return null;
    for (final c in widget.filterOptions.clinics) {
      if (c.name == name) return c.id;
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

  AssistantManagerReportQuery _draftQuery() {
    return AssistantManagerReportQuery(
      search: widget.currentQuery.search,
      fromDate: _fromDateApi,
      toDate: _toDateApi,
      assistantManagerId: _assistantManagerIdForName(_assistantManager),
      clinicId: _clinicIdForName(_clinic),
      perPage: int.tryParse(_perPage) ?? 15,
      page: 1,
    );
  }

  AssistantManagerReportQuery get _normalizedApplied =>
      AssistantManagerReportQuery(
        search: widget.currentQuery.search,
        fromDate: widget.currentQuery.fromDate,
        toDate: widget.currentQuery.toDate,
        assistantManagerId: widget.currentQuery.assistantManagerId,
        clinicId: widget.currentQuery.clinicId,
        perPage: widget.currentQuery.perPage,
        page: 1,
      );

  bool get _hasPendingChanges => _draftQuery() != _normalizedApplied;

  void _applyFilters() {
    final draft = _draftQuery();
    context.read<AssistantManagerReportBloc>().add(
          AssistantManagerReportFiltersApplied(
            fromDate: draft.fromDate,
            toDate: draft.toDate,
            assistantManagerId: draft.assistantManagerId,
            clinicId: draft.clinicId,
            perPage: draft.perPage,
            clearFromDate: draft.fromDate == null,
            clearToDate: draft.toDate == null,
            clearAssistantManagerId: draft.assistantManagerId == null,
            clearClinicId: draft.clinicId == null,
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
              _assistantManagerField(),
              _clinicField(),
              _fromDateField(),
              _toDateField(),
              _perPageField(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fromDateField() {
    return ReportDateField(
      key: ValueKey('am_from_$_resetToken'),
      label: 'From Date',
      valueText: _displayDate(_fromDateApi),
      onTap: _pickFrom,
    );
  }

  Widget _toDateField() {
    return ReportDateField(
      key: ValueKey('am_to_$_resetToken'),
      label: 'To Date',
      valueText: _displayDate(_toDateApi),
      onTap: _pickTo,
    );
  }

  Widget _assistantManagerField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('am_assistant_$_resetToken'),
      label: 'Assistant Manager',
      hintText: _allAssistantManagers,
      enableSearch: true,
      items: _assistantManagerItems,
      value: _assistantManager,
      onChanged: (v) {
        if (v == null) return;
        setState(() => _assistantManager = v);
      },
    );
  }

  Widget _clinicField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('am_clinic_$_resetToken'),
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

  Widget _perPageField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('am_per_page_$_resetToken'),
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
