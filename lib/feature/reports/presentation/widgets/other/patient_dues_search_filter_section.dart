import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/entities/patient_dues_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/entities/patient_dues_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/patient_dues_bloc/patient_dues_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_filters_panel.dart';

// ============================================================
// PATIENT DUES SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → PatientDuesSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on PatientDuesBloc (same as All Employees).
// ============================================================

class PatientDuesSearchFilterSection extends StatelessWidget {
  const PatientDuesSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(PatientDuesState state) {
    if (state is PatientDuesLoaded) return state.filterOptions;
    if (state is PatientDuesError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  PatientDuesQuery _queryOf(PatientDuesState state) {
    if (state is PatientDuesLoaded) return state.query;
    if (state is PatientDuesError) return state.query;
    return const PatientDuesQuery();
  }

  List<PatientDuesEntity> _rowsOf(PatientDuesState state) {
    if (state is PatientDuesLoaded) return state.rows;
    if (state is PatientDuesError) return state.rows;
    return const [];
  }

  bool _isBusy(PatientDuesState state) {
    if (state is PatientDuesLoading || state is PatientDuesInitial) {
      return true;
    }
    if (state is PatientDuesLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientDuesBloc, PatientDuesState>(
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
          searchHint: 'Search patient, CNIC…',
          searchQuery: query.search,
          hasActiveFilters: query.hasActiveFilters,
          searchMatchCount: AppSearchRanker.matchCount(
            items: rows,
            query: query.search,
            fieldsOf: (row) => [
              row.patientName,
              row.patientCnic,
              row.patientPhone,
              row.receptionistName,
            ],
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<PatientDuesBloc>().add(
                  PatientDuesSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<PatientDuesBloc>().add(
                  PatientDuesSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) => PatientDuesFiltersPanel(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
