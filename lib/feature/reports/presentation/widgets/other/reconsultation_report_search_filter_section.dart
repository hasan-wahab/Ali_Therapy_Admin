import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/entities/reconsultation_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/entities/reconsultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/reconsultation_report_bloc/reconsultation_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/reconsultation_report_filters_panel.dart';

// ============================================================
// RECONSULTATION REPORT SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → ReconsultationReportSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on ReconsultationReportBloc.
// ============================================================

class ReconsultationReportSearchFilterSection extends StatelessWidget {
  const ReconsultationReportSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(ReconsultationReportState state) {
    if (state is ReconsultationReportLoaded) return state.filterOptions;
    if (state is ReconsultationReportError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  ReconsultationReportQuery _queryOf(ReconsultationReportState state) {
    if (state is ReconsultationReportLoaded) return state.query;
    if (state is ReconsultationReportError) return state.query;
    return const ReconsultationReportQuery();
  }

  List<ReconsultationReportEntity> _rowsOf(ReconsultationReportState state) {
    if (state is ReconsultationReportLoaded) return state.rows;
    if (state is ReconsultationReportError) return state.rows;
    return const [];
  }

  bool _isBusy(ReconsultationReportState state) {
    if (state is ReconsultationReportLoading ||
        state is ReconsultationReportInitial) {
      return true;
    }
    if (state is ReconsultationReportLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReconsultationReportBloc, ReconsultationReportState>(
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
          searchHint: 'Search patient, consultant…',
          searchQuery: query.search,
          hasActiveFilters: query.hasActiveFilters,
          searchMatchCount: AppSearchRanker.matchCount(
            items: rows,
            query: query.search,
            fieldsOf: (row) => [
              row.patientName,
              row.patientPhone,
              row.patientCnic,
              row.consultantName,
              row.clinicName,
            ],
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<ReconsultationReportBloc>().add(
                  ReconsultationReportSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<ReconsultationReportBloc>().add(
                  ReconsultationReportSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) =>
              ReconsultationReportFiltersPanel(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
