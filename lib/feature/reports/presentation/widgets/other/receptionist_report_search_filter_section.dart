import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/entities/receptionist_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/entities/receptionist_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/receptionist_report_bloc/receptionist_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/receptionist_report_filters_panel.dart';

// ============================================================
// RECEPTIONIST REPORT SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → ReceptionistReportSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on ReceptionistReportBloc.
// ============================================================

class ReceptionistReportSearchFilterSection extends StatelessWidget {
  const ReceptionistReportSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(ReceptionistReportState state) {
    if (state is ReceptionistReportLoaded) return state.filterOptions;
    if (state is ReceptionistReportError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  ReceptionistReportQuery _queryOf(ReceptionistReportState state) {
    if (state is ReceptionistReportLoaded) return state.query;
    if (state is ReceptionistReportError) return state.query;
    return const ReceptionistReportQuery();
  }

  List<ReceptionistReportEntity> _rowsOf(ReceptionistReportState state) {
    if (state is ReceptionistReportLoaded) return state.rows;
    if (state is ReceptionistReportError) return state.rows;
    return const [];
  }

  bool _isBusy(ReceptionistReportState state) {
    if (state is ReceptionistReportLoading ||
        state is ReceptionistReportInitial) {
      return true;
    }
    if (state is ReceptionistReportLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceptionistReportBloc, ReceptionistReportState>(
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
          searchHint: 'Search patient, receptionist…',
          searchQuery: query.search,
          hasActiveFilters: query.hasActiveFilters,
          searchMatchCount: AppSearchRanker.matchCount(
            items: rows,
            query: query.search,
            fieldsOf: (row) => [
              row.patientName,
              row.patientPhone,
              row.patientCnic,
              row.receptionistName,
              row.clinicName,
            ],
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<ReceptionistReportBloc>().add(
                  ReceptionistReportSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<ReceptionistReportBloc>().add(
                  ReceptionistReportSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) => ReceptionistReportFiltersPanel(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
