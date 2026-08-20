import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_summary_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/usecases/get_insurance_panel_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/usecases/get_report_filter_options_usecase.dart';

part 'insurance_panel_report_event.dart';
part 'insurance_panel_report_state.dart';

// ============================================================
// INSURANCE PANEL REPORT BLOC
// ------------------------------------------------------------
// Same flow as ReferByReportBloc: full list, local search,
// filters as API query params. Summary comes from the API.
// ============================================================

class InsurancePanelReportBloc
    extends Bloc<InsurancePanelReportEvent, InsurancePanelReportState> {
  InsurancePanelReportBloc({
    required this.getInsurancePanelReportUseCase,
    required this.getReportFilterOptionsUseCase,
  }) : super(const InsurancePanelReportInitial()) {
    on<InsurancePanelReportStarted>(_onStarted);
    on<InsurancePanelReportRefreshed>(_onRefreshed);
    on<InsurancePanelReportSearchChanged>(_onSearchChanged);
    on<InsurancePanelReportSearchSubmitted>(_onSearchSubmitted);
    on<InsurancePanelReportFiltersApplied>(_onFiltersApplied);
    on<InsurancePanelReportTotalsToggled>(_onTotalsToggled);
  }

  final GetInsurancePanelReportUseCase getInsurancePanelReportUseCase;
  final GetReportFilterOptionsUseCase getReportFilterOptionsUseCase;

  InsurancePanelReportQuery _query = const InsurancePanelReportQuery();
  ReportFilterOptionsEntity _filterOptions =
      const ReportFilterOptionsEntity.empty();
  Timer? _searchDebounce;

  static const _debounceDuration = Duration(milliseconds: 450);

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(InsurancePanelReportRefreshed(completer: completer));
    return completer.future;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    InsurancePanelReportStarted event,
    Emitter<InsurancePanelReportState> emit,
  ) async {
    emit(const InsurancePanelReportLoading());
    _query = const InsurancePanelReportQuery();
    await _loadFilterOptions();
    await _loadRows(emit, keepOnError: _snapshot());
  }

  Future<void> _onRefreshed(
    InsurancePanelReportRefreshed event,
    Emitter<InsurancePanelReportState> emit,
  ) async {
    try {
      await _loadFilterOptions();
      await _loadRows(emit, keepOnError: _snapshot());
    } finally {
      if (!event.completer.isCompleted) event.completer.complete();
    }
  }

  void _onSearchChanged(
    InsurancePanelReportSearchChanged event,
    Emitter<InsurancePanelReportState> emit,
  ) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_debounceDuration, () {
      add(InsurancePanelReportSearchSubmitted(event.search));
    });
  }

  Future<void> _onSearchSubmitted(
    InsurancePanelReportSearchSubmitted event,
    Emitter<InsurancePanelReportState> emit,
  ) async {
    _searchDebounce?.cancel();
    _query = _query.copyWith(search: event.search);
    await _reloadList(emit);
  }

  Future<void> _onFiltersApplied(
    InsurancePanelReportFiltersApplied event,
    Emitter<InsurancePanelReportState> emit,
  ) async {
    _searchDebounce?.cancel();

    if (event.resetAll) {
      _query = _query.resetFilters();
    } else {
      _query = _query.copyWith(
        fromDate: event.fromDate,
        toDate: event.toDate,
        clinicId: event.clinicId,
        receptionistId: event.receptionistId,
        clearFromDate: event.clearFromDate,
        clearToDate: event.clearToDate,
        clearClinicId: event.clearClinicId,
        clearReceptionistId: event.clearReceptionistId,
      );
    }

    await _reloadList(emit);
  }

  void _onTotalsToggled(
    InsurancePanelReportTotalsToggled event,
    Emitter<InsurancePanelReportState> emit,
  ) {
    final current = state;
    if (current is InsurancePanelReportLoaded) {
      emit(current.copyWith(showTotals: !current.showTotals));
    }
  }

  Future<void> _reloadList(Emitter<InsurancePanelReportState> emit) async {
    final current = state;
    if (current is InsurancePanelReportLoaded) {
      emit(current.copyWith(isRefreshingList: true, query: _query));
      await _loadRows(emit, keepOnError: _snapshot());
      return;
    }
    emit(const InsurancePanelReportLoading());
    await _loadRows(emit);
  }

  Future<void> _loadFilterOptions() async {
    final result = await getReportFilterOptionsUseCase(const NoParams());
    result.when(
      success: (options) => _filterOptions = options,
      failure: (_) {},
    );
  }

  _Snapshot _snapshot() {
    final s = state;
    if (s is InsurancePanelReportLoaded) {
      return _Snapshot(
        rows: s.rows,
        summary: s.summary,
        showTotals: s.showTotals,
        filterOptions: s.filterOptions,
        query: s.query,
      );
    }
    if (s is InsurancePanelReportError) {
      return _Snapshot(
        rows: s.rows,
        summary: s.summary,
        showTotals: s.showTotals,
        filterOptions: s.filterOptions,
        query: s.query,
      );
    }
    return _Snapshot(filterOptions: _filterOptions, query: _query);
  }

  List<String> _searchFields(InsurancePanelReportEntity row) => [
        row.panelName,
        row.policyType,
      ];

  Future<void> _loadRows(
    Emitter<InsurancePanelReportState> emit, {
    _Snapshot keepOnError = const _Snapshot(),
  }) async {
    // Keep search local so the API still returns the full filtered list.
    final result = await getInsurancePanelReportUseCase(
      _query.copyWith(search: ''),
    );

    result.when(
      success: (page) {
        emit(InsurancePanelReportLoaded(
          rows: AppSearchRanker.matchesThenRelated(
            items: page.panels,
            query: _query.search,
            fieldsOf: _searchFields,
          ),
          summary: page.summary,
          showTotals: keepOnError.showTotals,
          isRefreshingList: false,
          filterOptions: _filterOptions,
          query: _query,
        ));
      },
      failure: (failure) {
        emit(InsurancePanelReportError(
          title: failure.title,
          message: failure.message,
          rows: keepOnError.rows,
          summary: keepOnError.summary,
          showTotals: keepOnError.showTotals,
          filterOptions: keepOnError.filterOptions,
          query: keepOnError.query,
        ));
        if (keepOnError.rows.isNotEmpty) {
          emit(InsurancePanelReportLoaded(
            rows: keepOnError.rows,
            summary: keepOnError.summary,
            showTotals: keepOnError.showTotals,
            isRefreshingList: false,
            filterOptions: keepOnError.filterOptions,
            query: keepOnError.query,
          ));
        }
      },
    );
  }
}

class _Snapshot {
  const _Snapshot({
    this.rows = const [],
    this.summary = const InsurancePanelReportSummaryEntity.empty(),
    this.showTotals = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const InsurancePanelReportQuery(),
  });

  final List<InsurancePanelReportEntity> rows;
  final InsurancePanelReportSummaryEntity summary;
  final bool showTotals;
  final ReportFilterOptionsEntity filterOptions;
  final InsurancePanelReportQuery query;
}
