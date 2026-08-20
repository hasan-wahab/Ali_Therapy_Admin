import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/entities/consultation_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/entities/consultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/bloc/consultation_report_bloc/consultation_report_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/consultation_report_filters_panel.dart';

// ============================================================
// CONSULTATION REPORT SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → ConsultationReportSearchChanged (debounced in Bloc).
// Filter dropdowns come from GET /reports/filter-options
// stored on ConsultationReportBloc.
// ============================================================

class ConsultationReportSearchFilterSection extends StatelessWidget {
  const ConsultationReportSearchFilterSection({super.key});

  ReportFilterOptionsEntity _filtersOf(ConsultationReportState state) {
    if (state is ConsultationReportLoaded) return state.filterOptions;
    if (state is ConsultationReportError) return state.filterOptions;
    return const ReportFilterOptionsEntity.empty();
  }

  ConsultationReportQuery _queryOf(ConsultationReportState state) {
    if (state is ConsultationReportLoaded) return state.query;
    if (state is ConsultationReportError) return state.query;
    return const ConsultationReportQuery();
  }

  List<ConsultationReportEntity> _rowsOf(ConsultationReportState state) {
    if (state is ConsultationReportLoaded) return state.rows;
    if (state is ConsultationReportError) return state.rows;
    return const [];
  }

  bool _isBusy(ConsultationReportState state) {
    if (state is ConsultationReportLoading ||
        state is ConsultationReportInitial) {
      return true;
    }
    if (state is ConsultationReportLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationReportBloc, ConsultationReportState>(
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
          searchHint: 'Search consultant, patient…',
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
              row.therapistName,
              row.receptionistName,
              row.assistantManagerName,
              row.clinicName,
              row.referBy,
            ],
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<ConsultationReportBloc>().add(
                  ConsultationReportSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<ConsultationReportBloc>().add(
                  ConsultationReportSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) => ConsultationReportFiltersPanel(
            filterOptions: _filtersOf(state),
            currentQuery: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
