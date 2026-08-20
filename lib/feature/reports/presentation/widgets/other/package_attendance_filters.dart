import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/entities/package_attendance_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/package_attendance_bloc/package_attendance_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// PACKAGE ATTENDANCE FILTERS PANEL
// ------------------------------------------------------------
// Clinic / therapist lists from GET /reports/filter-options.
// Dropdowns only update local draft.
// API runs only after pressing "Apply".
// ============================================================

class PackageAttendanceFilters extends StatefulWidget {
  const PackageAttendanceFilters({
    super.key,
    required this.filterOptions,
    required this.currentQuery,
    this.onApplied,
  });

  final ReportFilterOptionsEntity filterOptions;
  final PackageAttendanceQuery currentQuery;
  final VoidCallback? onApplied;

  @override
  State<PackageAttendanceFilters> createState() =>
      _PackageAttendanceFiltersState();
}

class _PackageAttendanceFiltersState extends State<PackageAttendanceFilters> {
  static const _allClinics = 'All Clinics';
  static const _allGenders = 'All Genders';
  static const _allTherapists = 'All Therapists';
  static const _genders = [_allGenders, 'Male', 'Female'];
  static const _perPageLabels = ['15', '25', '50', '100'];

  late String _clinic;
  late String _gender;
  late String _therapist;
  late String _perPage;
  int _resetToken = 0;

  List<String> get _clinicItems => [
        _allClinics,
        ...widget.filterOptions.clinics
            .map((c) => c.name)
            .where((name) => name.isNotEmpty),
      ];

  List<String> get _therapistItems => [
        _allTherapists,
        ...widget.filterOptions.therapists
            .map((t) => t.name)
            .where((name) => name.isNotEmpty),
      ];

  @override
  void initState() {
    super.initState();
    _syncFromQuery(widget.currentQuery);
  }

  @override
  void didUpdateWidget(covariant PackageAttendanceFilters oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filterOptions != widget.filterOptions ||
        oldWidget.currentQuery != widget.currentQuery) {
      setState(() {
        _syncFromQuery(widget.currentQuery);
        _resetToken++;
      });
    }
  }

  void _syncFromQuery(PackageAttendanceQuery q) {
    _clinic = _nameForClinicId(q.clinicId);
    _gender = q.gender ?? _allGenders;
    _therapist = _nameForTherapistId(q.therapistId);
    _perPage = q.perPage.toString();
  }

  String _nameForClinicId(int? id) {
    if (id == null) return _allClinics;
    for (final c in widget.filterOptions.clinics) {
      if (c.id == id) return c.name;
    }
    return _allClinics;
  }

  String _nameForTherapistId(int? id) {
    if (id == null) return _allTherapists;
    for (final t in widget.filterOptions.therapists) {
      if (t.id == id) return t.name;
    }
    return _allTherapists;
  }

  int? _clinicIdForName(String name) {
    if (name == _allClinics) return null;
    for (final c in widget.filterOptions.clinics) {
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

  String? _genderValue(String name) {
    if (name == _allGenders) return null;
    return name;
  }

  PackageAttendanceQuery _draftQuery() {
    return PackageAttendanceQuery(
      search: widget.currentQuery.search,
      clinicId: _clinicIdForName(_clinic),
      gender: _genderValue(_gender),
      therapistId: _therapistIdForName(_therapist),
      perPage: int.tryParse(_perPage) ?? 15,
      page: 1,
    );
  }

  PackageAttendanceQuery get _normalizedApplied => PackageAttendanceQuery(
        search: widget.currentQuery.search,
        clinicId: widget.currentQuery.clinicId,
        gender: widget.currentQuery.gender,
        therapistId: widget.currentQuery.therapistId,
        perPage: widget.currentQuery.perPage,
        page: 1,
      );

  bool get _hasPendingChanges => _draftQuery() != _normalizedApplied;

  void _applyFilters() {
    final draft = _draftQuery();
    context.read<PackageAttendanceBloc>().add(
          PackageAttendanceFiltersApplied(
            clinicId: draft.clinicId,
            gender: draft.gender,
            therapistId: draft.therapistId,
            perPage: draft.perPage,
            clearClinicId: draft.clinicId == null,
            clearGender: draft.gender == null,
            clearTherapistId: draft.therapistId == null,
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
                key: ValueKey('pa_clinic_$_resetToken'),
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
                key: ValueKey('pa_gender_$_resetToken'),
                label: 'Gender',
                hintText: _allGenders,
                items: _genders,
                value: _gender,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _gender = v);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('pa_therapist_$_resetToken'),
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
                key: ValueKey('pa_per_page_$_resetToken'),
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
