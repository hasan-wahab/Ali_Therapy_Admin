import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/discount_report_bloc/discount_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_date_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// DISCOUNT REPORT FILTERS
// ------------------------------------------------------------
// Clinic / consultant / receptionist / dates hit the API.
// Discount % is applied on loaded rows only (not an API param).
// ============================================================

class DiscountReportFilters extends StatefulWidget {
  const DiscountReportFilters({
    super.key,
    required this.filterOptions,
    required this.currentQuery,
    this.onApplied,
  });

  final ReportFilterOptionsEntity filterOptions;
  final DiscountReportQuery currentQuery;
  final VoidCallback? onApplied;

  static const allClinics = 'All Clinics';
  static const allConsultants = 'All Consultants';
  static const allStaff = 'All Staff';
  static const allDiscounts = 'All Discounts';

  static const discountItems = [
    allDiscounts,
    '5%',
    '10%',
    '15%',
    '20%',
    '25%',
    '30%',
    '35%',
    '40%',
    '45%',
    '50%',
  ];

  @override
  State<DiscountReportFilters> createState() => _DiscountReportFiltersState();
}

class _DiscountReportFiltersState extends State<DiscountReportFilters> {
  late String _clinic;
  late String _consultant;
  late String _receptionist;
  late String _discountRange;
  late String? _fromDateApi;
  late String? _toDateApi;
  int _resetToken = 0;

  List<String> get _clinicItems => [
        DiscountReportFilters.allClinics,
        ...widget.filterOptions.clinics
            .map((c) => c.name)
            .where((name) => name.isNotEmpty),
      ];

  List<String> get _consultantItems => [
        DiscountReportFilters.allConsultants,
        ...widget.filterOptions.consultants
            .map((c) => c.name)
            .where((name) => name.isNotEmpty),
      ];

  List<String> get _receptionistItems => [
        DiscountReportFilters.allStaff,
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
  void didUpdateWidget(covariant DiscountReportFilters oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filterOptions != widget.filterOptions ||
        oldWidget.currentQuery != widget.currentQuery) {
      setState(() {
        _syncFromQuery(widget.currentQuery);
        _resetToken++;
      });
    }
  }

  void _syncFromQuery(DiscountReportQuery q) {
    _clinic = _nameForClinicId(q.clinicId);
    _consultant = _nameForConsultantId(q.consultantId);
    _receptionist = _nameForReceptionistId(q.receptionistId);
    _discountRange = q.discountPercent == null
        ? DiscountReportFilters.allDiscounts
        : '${q.discountPercent}%';
    _fromDateApi = q.fromDate;
    _toDateApi = q.toDate;
  }

  String _nameForClinicId(int? id) {
    if (id == null) return DiscountReportFilters.allClinics;
    for (final c in widget.filterOptions.clinics) {
      if (c.id == id) return c.name;
    }
    return DiscountReportFilters.allClinics;
  }

  String _nameForConsultantId(int? id) {
    if (id == null) return DiscountReportFilters.allConsultants;
    for (final c in widget.filterOptions.consultants) {
      if (c.id == id) return c.name;
    }
    return DiscountReportFilters.allConsultants;
  }

  String _nameForReceptionistId(int? id) {
    if (id == null) return DiscountReportFilters.allStaff;
    for (final r in widget.filterOptions.receptionists) {
      if (r.id == id) return r.name;
    }
    return DiscountReportFilters.allStaff;
  }

  int? _clinicIdForName(String name) {
    if (name == DiscountReportFilters.allClinics) return null;
    for (final c in widget.filterOptions.clinics) {
      if (c.name == name) return c.id;
    }
    return null;
  }

  int? _consultantIdForName(String name) {
    if (name == DiscountReportFilters.allConsultants) return null;
    for (final c in widget.filterOptions.consultants) {
      if (c.name == name) return c.id;
    }
    return null;
  }

  int? _receptionistIdForName(String name) {
    if (name == DiscountReportFilters.allStaff) return null;
    for (final r in widget.filterOptions.receptionists) {
      if (r.name == name) return r.id;
    }
    return null;
  }

  int? _percentForLabel(String label) {
    if (label == DiscountReportFilters.allDiscounts) return null;
    return int.tryParse(label.replaceAll('%', '').trim());
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

  DiscountReportQuery _draftQuery() {
    return DiscountReportQuery(
      search: widget.currentQuery.search,
      clinicId: _clinicIdForName(_clinic),
      consultantId: _consultantIdForName(_consultant),
      receptionistId: _receptionistIdForName(_receptionist),
      fromDate: _fromDateApi,
      toDate: _toDateApi,
      discountPercent: _percentForLabel(_discountRange),
      page: 1,
    );
  }

  DiscountReportQuery get _normalizedApplied => DiscountReportQuery(
        search: widget.currentQuery.search,
        clinicId: widget.currentQuery.clinicId,
        consultantId: widget.currentQuery.consultantId,
        receptionistId: widget.currentQuery.receptionistId,
        fromDate: widget.currentQuery.fromDate,
        toDate: widget.currentQuery.toDate,
        discountPercent: widget.currentQuery.discountPercent,
        page: 1,
      );

  bool get _hasPendingChanges => _draftQuery() != _normalizedApplied;

  void _applyFilters() {
    final draft = _draftQuery();
    context.read<DiscountReportBloc>().add(
          DiscountReportFiltersApplied(
            clinicId: draft.clinicId,
            consultantId: draft.consultantId,
            receptionistId: draft.receptionistId,
            fromDate: draft.fromDate,
            toDate: draft.toDate,
            discountPercent: draft.discountPercent,
            clearClinicId: draft.clinicId == null,
            clearConsultantId: draft.consultantId == null,
            clearReceptionistId: draft.receptionistId == null,
            clearFromDate: draft.fromDate == null,
            clearToDate: draft.toDate == null,
            clearDiscountPercent: draft.discountPercent == null,
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
                key: ValueKey('dr_clinic_$_resetToken'),
                enableSearch: true,
                label: 'Clinic',
                hintText: DiscountReportFilters.allClinics,
                items: _clinicItems,
                value: _clinicItems.contains(_clinic)
                    ? _clinic
                    : DiscountReportFilters.allClinics,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _clinic = v);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('dr_cons_$_resetToken'),
                enableSearch: true,
                label: 'Consultant',
                hintText: DiscountReportFilters.allConsultants,
                items: _consultantItems,
                value: _consultantItems.contains(_consultant)
                    ? _consultant
                    : DiscountReportFilters.allConsultants,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _consultant = v);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('dr_rec_$_resetToken'),
                enableSearch: true,
                label: 'Receptionist',
                hintText: DiscountReportFilters.allStaff,
                items: _receptionistItems,
                value: _receptionistItems.contains(_receptionist)
                    ? _receptionist
                    : DiscountReportFilters.allStaff,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _receptionist = v);
                },
              ),
              AppDropdownField(
                compact: true,
                key: ValueKey('dr_disc_$_resetToken'),
                enableSearch: true,
                label: 'Discount % Range',
                hintText: DiscountReportFilters.allDiscounts,
                items: DiscountReportFilters.discountItems,
                value: DiscountReportFilters.discountItems.contains(
                  _discountRange,
                )
                    ? _discountRange
                    : DiscountReportFilters.allDiscounts,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _discountRange = v);
                },
              ),
              ReportDateField(
                key: ValueKey('dr_from_$_resetToken'),
                label: 'From Date',
                valueText: _displayDate(_fromDateApi),
                onTap: _pickFrom,
              ),
              ReportDateField(
                key: ValueKey('dr_to_$_resetToken'),
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
