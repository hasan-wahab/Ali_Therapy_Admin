import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/entities/patient_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/entities/patient_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/patient_report_bloc/patient_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_report_filters.dart';

// ============================================================
// PATIENT REPORT SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → PatientReportSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on PatientReportBloc.
// ============================================================

class PatientReportSearchFilterSection extends StatelessWidget {
  const PatientReportSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(PatientReportState state) {
    if (state is PatientReportLoaded) return state.filterOptions;
    if (state is PatientReportError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  PatientReportQuery _queryOf(PatientReportState state) {
    if (state is PatientReportLoaded) return state.query;
    if (state is PatientReportError) return state.query;
    return const PatientReportQuery();
  }

  List<PatientReportEntity> _rowsOf(PatientReportState state) {
    if (state is PatientReportLoaded) return state.rows;
    if (state is PatientReportError) return state.rows;
    return const [];
  }

  bool _isBusy(PatientReportState state) {
    if (state is PatientReportLoading || state is PatientReportInitial) {
      return true;
    }
    if (state is PatientReportLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientReportBloc, PatientReportState>(
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
          searchHint: 'Search patient…',
          searchQuery: query.search,
          hasActiveFilters: query.hasActiveFilters,
          searchMatchCount: AppSearchRanker.matchCount(
            items: rows,
            query: query.search,
            fieldsOf: (row) => [row.patientName, row.email],
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<PatientReportBloc>().add(
                  PatientReportSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<PatientReportBloc>().add(
                  PatientReportSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) => PatientReportFilters(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
