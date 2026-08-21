import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/in_progress_sessions_bloc/in_progress_sessions_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/in_progress_sessions_filters.dart';

// ============================================================
// IN-PROGRESS SESSIONS SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → InProgressSessionsSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on InProgressSessionsBloc.
// ============================================================

class InProgressSessionsSearchFilterSection extends StatelessWidget {
  const InProgressSessionsSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(InProgressSessionsState state) {
    if (state is InProgressSessionsLoaded) return state.filterOptions;
    if (state is InProgressSessionsError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  InProgressSessionsQuery _queryOf(InProgressSessionsState state) {
    if (state is InProgressSessionsLoaded) return state.query;
    if (state is InProgressSessionsError) return state.query;
    return const InProgressSessionsQuery();
  }

  List<InProgressSessionsEntity> _rowsOf(InProgressSessionsState state) {
    if (state is InProgressSessionsLoaded) return state.rows;
    if (state is InProgressSessionsError) return state.rows;
    return const [];
  }

  bool _isBusy(InProgressSessionsState state) {
    if (state is InProgressSessionsLoading ||
        state is InProgressSessionsInitial) {
      return true;
    }
    if (state is InProgressSessionsLoaded) return state.isRefreshingList;
    return false;
  }

  List<String> _searchFields(InProgressSessionsEntity row) => [
        row.patientName,
        row.mrNo,
        row.patientCnic,
        row.consultantName,
        row.therapistName,
        row.clinicName,
        ...row.sessionTypes,
      ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InProgressSessionsBloc, InProgressSessionsState>(
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
          searchHint: 'Search in-progress sessions…',
          searchQuery: query.search,
          hasActiveFilters: query.hasActiveFilters,
          searchMatchCount: AppSearchRanker.matchCount(
            items: rows,
            query: query.search,
            fieldsOf: _searchFields,
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<InProgressSessionsBloc>().add(
                  InProgressSessionsSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<InProgressSessionsBloc>().add(
                  InProgressSessionsSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) => InProgressSessionsFilters(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
