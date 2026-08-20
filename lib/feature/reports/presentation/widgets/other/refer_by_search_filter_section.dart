import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/entities/refer_by_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/entities/refer_by_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/refer_by_report_bloc/refer_by_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/refer_by_filters.dart';

// ============================================================
// REFER BY SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → ReferByReportSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on ReferByReportBloc.
// ============================================================

class ReferBySearchFilterSection extends StatelessWidget {
  const ReferBySearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(ReferByReportState state) {
    if (state is ReferByReportLoaded) return state.filterOptions;
    if (state is ReferByReportError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  ReferByReportQuery _queryOf(ReferByReportState state) {
    if (state is ReferByReportLoaded) return state.query;
    if (state is ReferByReportError) return state.query;
    return const ReferByReportQuery();
  }

  List<ReferByReportEntity> _rowsOf(ReferByReportState state) {
    if (state is ReferByReportLoaded) return state.rows;
    if (state is ReferByReportError) return state.rows;
    return const [];
  }

  bool _isBusy(ReferByReportState state) {
    if (state is ReferByReportLoading || state is ReferByReportInitial) {
      return true;
    }
    if (state is ReferByReportLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReferByReportBloc, ReferByReportState>(
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
          searchHint: 'Search referral source…',
          searchQuery: query.search,
          hasActiveFilters: query.hasActiveFilters,
          searchMatchCount: AppSearchRanker.matchCount(
            items: rows,
            query: query.search,
            fieldsOf: (row) => [row.referralSource, row.referralType],
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<ReferByReportBloc>().add(
                  ReferByReportSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<ReferByReportBloc>().add(
                  ReferByReportSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) => ReferByFilters(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
