import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/entities/user_activity_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/entities/user_activity_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/user_activity_report_bloc/user_activity_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/user_activity_report_filters.dart';

// ============================================================
// USER ACTIVITY REPORT SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → UserActivityReportSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on UserActivityReportBloc.
// ============================================================

class UserActivityReportSearchFilterSection extends StatelessWidget {
  const UserActivityReportSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(UserActivityReportState state) {
    if (state is UserActivityReportLoaded) return state.filterOptions;
    if (state is UserActivityReportError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  UserActivityReportQuery _queryOf(UserActivityReportState state) {
    if (state is UserActivityReportLoaded) return state.query;
    if (state is UserActivityReportError) return state.query;
    return const UserActivityReportQuery();
  }

  List<UserActivityReportEntity> _rowsOf(UserActivityReportState state) {
    if (state is UserActivityReportLoaded) return state.rows;
    if (state is UserActivityReportError) return state.rows;
    return const [];
  }

  bool _isBusy(UserActivityReportState state) {
    if (state is UserActivityReportLoading ||
        state is UserActivityReportInitial) {
      return true;
    }
    if (state is UserActivityReportLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserActivityReportBloc, UserActivityReportState>(
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
              row.packageName,
              row.invoiceType,
              row.paymentMethod,
            ],
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<UserActivityReportBloc>().add(
                  UserActivityReportSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<UserActivityReportBloc>().add(
                  UserActivityReportSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) => UserActivityReportFilters(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
