import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/free_consultation_report_domain/entities/free_consultation_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/free_consultation_report_domain/entities/free_consultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/free_consultation_report_bloc/free_consultation_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/free_consultation_report_filters_panel.dart';

// ============================================================
// FREE CONSULTATION REPORT SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → FreeConsultationReportSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on FreeConsultationReportBloc.
// ============================================================

class FreeConsultationReportSearchFilterSection extends StatelessWidget {
  const FreeConsultationReportSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(FreeConsultationReportState state) {
    if (state is FreeConsultationReportLoaded) return state.filterOptions;
    if (state is FreeConsultationReportError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  FreeConsultationReportQuery _queryOf(FreeConsultationReportState state) {
    if (state is FreeConsultationReportLoaded) return state.query;
    if (state is FreeConsultationReportError) return state.query;
    return const FreeConsultationReportQuery();
  }

  List<FreeConsultationReportEntity> _rowsOf(
    FreeConsultationReportState state,
  ) {
    if (state is FreeConsultationReportLoaded) return state.rows;
    if (state is FreeConsultationReportError) return state.rows;
    return const [];
  }

  bool _isBusy(FreeConsultationReportState state) {
    if (state is FreeConsultationReportLoading ||
        state is FreeConsultationReportInitial) {
      return true;
    }
    if (state is FreeConsultationReportLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FreeConsultationReportBloc, FreeConsultationReportState>(
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
            context.read<FreeConsultationReportBloc>().add(
                  FreeConsultationReportSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<FreeConsultationReportBloc>().add(
                  FreeConsultationReportSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) =>
              FreeConsultationReportFiltersPanel(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
