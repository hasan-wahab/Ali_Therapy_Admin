import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/assistant_manager_report_bloc/assistant_manager_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/assistant_manager_report_filters_panel.dart';

// ============================================================
// ASSISTANT MANAGER REPORT SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → AssistantManagerReportSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on AssistantManagerReportBloc.
// ============================================================

class AssistantManagerReportSearchFilterSection extends StatelessWidget {
  const AssistantManagerReportSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(AssistantManagerReportState state) {
    if (state is AssistantManagerReportLoaded) return state.filterOptions;
    if (state is AssistantManagerReportError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  AssistantManagerReportQuery _queryOf(AssistantManagerReportState state) {
    if (state is AssistantManagerReportLoaded) return state.query;
    if (state is AssistantManagerReportError) return state.query;
    return const AssistantManagerReportQuery();
  }

  List<AssistantManagerReportEntity> _rowsOf(
    AssistantManagerReportState state,
  ) {
    if (state is AssistantManagerReportLoaded) return state.rows;
    if (state is AssistantManagerReportError) return state.rows;
    return const [];
  }

  bool _isBusy(AssistantManagerReportState state) {
    if (state is AssistantManagerReportLoading ||
        state is AssistantManagerReportInitial) {
      return true;
    }
    if (state is AssistantManagerReportLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssistantManagerReportBloc, AssistantManagerReportState>(
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
          searchHint: 'Search patient, AM…',
          searchQuery: query.search,
          hasActiveFilters: query.hasActiveFilters,
          searchMatchCount: AppSearchRanker.matchCount(
            items: rows,
            query: query.search,
            fieldsOf: (row) => [
              row.patientName,
              row.patientPhone,
              row.patientCnic,
              row.assistantManagerName,
              row.consultantName,
              row.clinicName,
              row.stage,
            ],
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<AssistantManagerReportBloc>().add(
                  AssistantManagerReportSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<AssistantManagerReportBloc>().add(
                  AssistantManagerReportSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) =>
              AssistantManagerReportFiltersPanel(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
