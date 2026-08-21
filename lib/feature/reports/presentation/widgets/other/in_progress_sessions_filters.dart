import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/in_progress_sessions_bloc/in_progress_sessions_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_date_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// IN-PROGRESS SESSIONS FILTERS
// ------------------------------------------------------------
// Session type / clinic / staff / date range.
// Clinic + staff names come from GET /reports/filter-options.
// Dropdowns only update local draft. API runs after "Apply".
// ============================================================

class InProgressSessionsFilters extends StatefulWidget {
  const InProgressSessionsFilters({
    super.key,
    required this.filterOptions,
    required this.currentQuery,
    this.onApplied,
  });

  final ReportFilterOptionsEntity filterOptions;
  final InProgressSessionsQuery currentQuery;
  final VoidCallback? onApplied;

  static const allClinics = 'All Clinics';
  static const allStaff = 'All Staff';

  @override
  State<InProgressSessionsFilters> createState() =>
      _InProgressSessionsFiltersState();
}

class _InProgressSessionsFiltersState extends State<InProgressSessionsFilters> {
  static const _categories = [
    InProgressSessionsQuery.sessionTypeAllLabel,
    InProgressSessionsQuery.sessionTypeConsultantLabel,
    InProgressSessionsQuery.sessionTypeTherapistLabel,
  ];

  late String _sessionCategory;
  late String _clinic;
  late String _staff;
  late String? _fromDateApi;
  late String? _toDateApi;
  int _resetToken = 0;

  List<String> get _clinicItems => [
        InProgressSessionsFilters.allClinics,
        ...widget.filterOptions.clinics
            .map((c) => c.name)
            .where((name) => name.isNotEmpty),
      ];

  List<String> get _staffItems {
    final names = <String>{};
    for (final person in widget.filterOptions.consultants) {
      if (person.name.isNotEmpty) names.add(person.name);
    }
    for (final person in widget.filterOptions.therapists) {
      if (person.name.isNotEmpty) names.add(person.name);
    }
    final sorted = names.toList()..sort();
    return [InProgressSessionsFilters.allStaff, ...sorted];
  }

  @override
  void initState() {
    super.initState();
    _syncFromQuery(widget.currentQuery);
  }

  @override
  void didUpdateWidget(covariant InProgressSessionsFilters oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filterOptions != widget.filterOptions ||
        oldWidget.currentQuery != widget.currentQuery) {
      setState(() {
        _syncFromQuery(widget.currentQuery);
        _resetToken++;
      });
    }
  }

  void _syncFromQuery(InProgressSessionsQuery q) {
    _sessionCategory = InProgressSessionsQuery.labelForSessionType(
      q.sessionType,
    );
    _clinic = _nameForClinicId(q.clinicId);
    _staff = _nameForStaffId(q.staffId);
    _fromDateApi = q.fromDate;
    _toDateApi = q.toDate;
  }

  String _nameForClinicId(int? id) {
    if (id == null) return InProgressSessionsFilters.allClinics;
    for (final c in widget.filterOptions.clinics) {
      if (c.id == id) return c.name;
    }
    return InProgressSessionsFilters.allClinics;
  }

  String _nameForStaffId(int? id) {
    if (id == null) return InProgressSessionsFilters.allStaff;
    for (final person in widget.filterOptions.consultants) {
      if (person.id == id) return person.name;
    }
    for (final person in widget.filterOptions.therapists) {
      if (person.id == id) return person.name;
    }
    return InProgressSessionsFilters.allStaff;
  }

  int? _clinicIdForName(String name) {
    if (name == InProgressSessionsFilters.allClinics) return null;
    for (final c in widget.filterOptions.clinics) {
      if (c.name == name) return c.id;
    }
    return null;
  }

  int? _staffIdForName(String name) {
    if (name == InProgressSessionsFilters.allStaff) return null;
    for (final person in widget.filterOptions.consultants) {
      if (person.name == name) return person.id;
    }
    for (final person in widget.filterOptions.therapists) {
      if (person.name == name) return person.id;
    }
    return null;
  }

  String _displayDate(String? apiDate) {
    if (apiDate == null || apiDate.isEmpty) return '';
    final parsed = DateTime.tryParse(apiDate);
    if (parsed == null) return apiDate;
    return Helpers.formatDate(parsed, pattern: 'MM/dd/yyyy');
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

  InProgressSessionsQuery _draftQuery() {
    return InProgressSessionsQuery(
      search: widget.currentQuery.search,
      sessionType: InProgressSessionsQuery.sessionTypeForLabel(_sessionCategory),
      clinicId: _clinicIdForName(_clinic),
      staffId: _staffIdForName(_staff),
      fromDate: _fromDateApi,
      toDate: _toDateApi,
      page: 1,
    );
  }

  InProgressSessionsQuery get _normalizedApplied => InProgressSessionsQuery(
        search: widget.currentQuery.search,
        sessionType: widget.currentQuery.sessionType,
        clinicId: widget.currentQuery.clinicId,
        staffId: widget.currentQuery.staffId,
        fromDate: widget.currentQuery.fromDate,
        toDate: widget.currentQuery.toDate,
        page: 1,
      );

  bool get _hasPendingChanges => _draftQuery() != _normalizedApplied;

  void _applyFilters() {
    final draft = _draftQuery();
    context.read<InProgressSessionsBloc>().add(
          InProgressSessionsFiltersApplied(
            sessionType: draft.sessionType,
            clinicId: draft.clinicId,
            staffId: draft.staffId,
            fromDate: draft.fromDate,
            toDate: draft.toDate,
            clearClinicId: draft.clinicId == null,
            clearStaffId: draft.staffId == null,
            clearFromDate: draft.fromDate == null,
            clearToDate: draft.toDate == null,
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
              AppDropdownField(
                compact: true,
                key: ValueKey('ips_cat_$_resetToken'),
                enableSearch: true,
                label: 'Session Category',
                hintText: InProgressSessionsQuery.sessionTypeAllLabel,
                items: _categories,
                value: _sessionCategory,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _sessionCategory = v);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('ips_clinic_$_resetToken'),
                enableSearch: true,
                label: 'Clinic',
                hintText: InProgressSessionsFilters.allClinics,
                items: _clinicItems,
                value: _clinicItems.contains(_clinic)
                    ? _clinic
                    : InProgressSessionsFilters.allClinics,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _clinic = v);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('ips_staff_$_resetToken'),
                enableSearch: true,
                label: 'Doctor / Staff',
                hintText: InProgressSessionsFilters.allStaff,
                items: _staffItems,
                value: _staffItems.contains(_staff)
                    ? _staff
                    : InProgressSessionsFilters.allStaff,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _staff = v);
                },
              ),
              ReportDateField(
                key: ValueKey('ips_from_$_resetToken'),
                label: 'From Date',
                valueText: _displayDate(_fromDateApi),
                onTap: _pickFrom,
              ),
              ReportDateField(
                key: ValueKey('ips_to_$_resetToken'),
                label: 'To Date',
                valueText: _displayDate(_toDateApi),
                onTap: _pickTo,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
