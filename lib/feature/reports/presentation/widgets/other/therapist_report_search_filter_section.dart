import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/entities/therapist_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/entities/therapist_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/therapist_report_bloc/therapist_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/therapist_report_filters_panel.dart';

// ============================================================
// THERAPIST REPORT SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → TherapistReportSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on TherapistReportBloc.
// ============================================================

class TherapistReportSearchFilterSection extends StatelessWidget {
  const TherapistReportSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(TherapistReportState state) {
    if (state is TherapistReportLoaded) return state.filterOptions;
    if (state is TherapistReportError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  TherapistReportQuery _queryOf(TherapistReportState state) {
    if (state is TherapistReportLoaded) return state.query;
    if (state is TherapistReportError) return state.query;
    return const TherapistReportQuery();
  }

  List<TherapistReportEntity> _rowsOf(TherapistReportState state) {
    if (state is TherapistReportLoaded) return state.rows;
    if (state is TherapistReportError) return state.rows;
    return const [];
  }

  bool _isBusy(TherapistReportState state) {
    if (state is TherapistReportLoading || state is TherapistReportInitial) {
      return true;
    }
    if (state is TherapistReportLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TherapistReportBloc, TherapistReportState>(
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
          searchHint: 'Search patient, therapist…',
          searchQuery: query.search,
          hasActiveFilters: query.hasActiveFilters,
          searchMatchCount: AppSearchRanker.matchCount(
            items: rows,
            query: query.search,
            fieldsOf: (row) => [
              row.patientName,
              row.patientPhone,
              row.patientCnic,
              row.therapistName,
              row.consultantName,
              row.clinicName,
              row.status,
            ],
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<TherapistReportBloc>().add(
                  TherapistReportSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<TherapistReportBloc>().add(
                  TherapistReportSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) => TherapistReportFiltersPanel(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
