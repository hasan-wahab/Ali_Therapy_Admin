import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/discount_report_bloc/discount_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/discount_report_filters.dart';

// ============================================================
// DISCOUNT REPORT SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → DiscountReportSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on DiscountReportBloc.
// ============================================================

class DiscountReportSearchFilterSection extends StatelessWidget {
  const DiscountReportSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(DiscountReportState state) {
    if (state is DiscountReportLoaded) return state.filterOptions;
    if (state is DiscountReportError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  DiscountReportQuery _queryOf(DiscountReportState state) {
    if (state is DiscountReportLoaded) return state.query;
    if (state is DiscountReportError) return state.query;
    return const DiscountReportQuery();
  }

  List<DiscountReportEntity> _rowsOf(DiscountReportState state) {
    if (state is DiscountReportLoaded) return state.rows;
    if (state is DiscountReportError) return state.rows;
    return const [];
  }

  bool _isBusy(DiscountReportState state) {
    if (state is DiscountReportLoading || state is DiscountReportInitial) {
      return true;
    }
    if (state is DiscountReportLoaded) return state.isRefreshingList;
    return false;
  }

  List<String> _searchFields(DiscountReportEntity row) => [
        row.patientName,
        row.patientPhone,
        row.patientCnic,
        row.consultantName,
        row.receptionistName,
        row.clinicName,
      ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountReportBloc, DiscountReportState>(
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
          searchHint: 'Search by Patient Name, Phone, or CNIC...',
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
            context.read<DiscountReportBloc>().add(
                  DiscountReportSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<DiscountReportBloc>().add(
                  DiscountReportSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) => DiscountReportFilters(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
