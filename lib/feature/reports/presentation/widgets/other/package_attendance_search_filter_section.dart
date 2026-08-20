import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/entities/package_attendance_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/entities/package_attendance_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/package_attendance_bloc/package_attendance_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/package_attendance_filters.dart';

// ============================================================
// PACKAGE ATTENDANCE SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → PackageAttendanceSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on PackageAttendanceBloc.
// ============================================================

class PackageAttendanceSearchFilterSection extends StatelessWidget {
  const PackageAttendanceSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(PackageAttendanceState state) {
    if (state is PackageAttendanceLoaded) return state.filterOptions;
    if (state is PackageAttendanceError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  PackageAttendanceQuery _queryOf(PackageAttendanceState state) {
    if (state is PackageAttendanceLoaded) return state.query;
    if (state is PackageAttendanceError) return state.query;
    return const PackageAttendanceQuery();
  }

  List<PackageAttendanceEntity> _rowsOf(PackageAttendanceState state) {
    if (state is PackageAttendanceLoaded) return state.rows;
    if (state is PackageAttendanceError) return state.rows;
    return const [];
  }

  bool _isBusy(PackageAttendanceState state) {
    if (state is PackageAttendanceLoading || state is PackageAttendanceInitial) {
      return true;
    }
    if (state is PackageAttendanceLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageAttendanceBloc, PackageAttendanceState>(
      buildWhen: (previous, current) {
        return _filtersOf(previous) != _filtersOf(current) ||
            _queryOf(previous) != _queryOf(current) ||
            _rowsOf(previous) != _rowsOf(current) ||
            _isBusy(previous) != _isBusy(current);
      },
      builder: (context, state) {
        final query = _queryOf(state);
        final rows = _rowsOf(state);
        return AppSearchFilterSection(
          searchHint: 'Name, Phone, MR No…',
          searchQuery: query.search,
          hasActiveFilters: query.hasActiveFilters,
          searchMatchCount: AppSearchRanker.matchCount(
            items: rows,
            query: query.search,
            fieldsOf: (row) => [
              row.patientName,
              row.mrNo,
              row.patientPhone,
              row.patientCnic,
              row.gender,
              ...row.packages.map((p) => p.packageName),
            ],
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<PackageAttendanceBloc>().add(
                  PackageAttendanceSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<PackageAttendanceBloc>().add(
                  PackageAttendanceSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) => PackageAttendanceFilters(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
