import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/insurance_panel_report_bloc/insurance_panel_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/insurance_panel_filters.dart';

// ============================================================
// INSURANCE PANEL SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → InsurancePanelReportSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on InsurancePanelReportBloc.
// ============================================================

class InsurancePanelSearchFilterSection extends StatelessWidget {
  const InsurancePanelSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(InsurancePanelReportState state) {
    if (state is InsurancePanelReportLoaded) return state.filterOptions;
    if (state is InsurancePanelReportError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  InsurancePanelReportQuery _queryOf(InsurancePanelReportState state) {
    if (state is InsurancePanelReportLoaded) return state.query;
    if (state is InsurancePanelReportError) return state.query;
    return const InsurancePanelReportQuery();
  }

  List<InsurancePanelReportEntity> _rowsOf(InsurancePanelReportState state) {
    if (state is InsurancePanelReportLoaded) return state.rows;
    if (state is InsurancePanelReportError) return state.rows;
    return const [];
  }

  bool _isBusy(InsurancePanelReportState state) {
    if (state is InsurancePanelReportLoading ||
        state is InsurancePanelReportInitial) {
      return true;
    }
    if (state is InsurancePanelReportLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsurancePanelReportBloc, InsurancePanelReportState>(
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
          searchHint: 'Search insurance panel…',
          searchQuery: query.search,
          hasActiveFilters: query.hasActiveFilters,
          searchMatchCount: AppSearchRanker.matchCount(
            items: rows,
            query: query.search,
            fieldsOf: (row) => [row.panelName, row.policyType],
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<InsurancePanelReportBloc>().add(
                  InsurancePanelReportSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<InsurancePanelReportBloc>().add(
                  InsurancePanelReportSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) => InsurancePanelFilters(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
