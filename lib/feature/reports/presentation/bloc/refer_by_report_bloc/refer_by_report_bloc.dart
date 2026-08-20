import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/entities/refer_by_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/entities/refer_by_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/usecases/get_refer_by_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/usecases/get_report_filter_options_usecase.dart';

part 'refer_by_report_event.dart';
part 'refer_by_report_state.dart';

// ============================================================
// REFER BY REPORT BLOC
// ------------------------------------------------------------
// Same flow as PatientReportBloc, without pagination
// because GET /reports/refer-by returns the full list.
// ============================================================

class ReferByReportBloc extends Bloc<ReferByReportEvent, ReferByReportState> {
  ReferByReportBloc({
    required this.getReferByReportUseCase,
    required this.getReportFilterOptionsUseCase,
  }) : super(const ReferByReportInitial()) {
    on<ReferByReportStarted>(_onStarted);
    on<ReferByReportRefreshed>(_onRefreshed);
    on<ReferByReportSearchChanged>(_onSearchChanged);
    on<ReferByReportSearchSubmitted>(_onSearchSubmitted);
    on<ReferByReportFiltersApplied>(_onFiltersApplied);
  }

  final GetReferByReportUseCase getReferByReportUseCase;
  final GetReportFilterOptionsUseCase getReportFilterOptionsUseCase;

  ReferByReportQuery _query = const ReferByReportQuery();
  ReportFilterOptionsEntity _filterOptions =
      const ReportFilterOptionsEntity.empty();
  Timer? _searchDebounce;

  static const _debounceDuration = Duration(milliseconds: 450);

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(ReferByReportRefreshed(completer: completer));
    return completer.future;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    ReferByReportStarted event,
    Emitter<ReferByReportState> emit,
  ) async {
    emit(const ReferByReportLoading());
    _query = const ReferByReportQuery();
    await _loadFilterOptions();
    await _loadRows(emit, keepOnError: _snapshot());
  }

  Future<void> _onRefreshed(
    ReferByReportRefreshed event,
    Emitter<ReferByReportState> emit,
  ) async {
    try {
      await _loadFilterOptions();
      await _loadRows(emit, keepOnError: _snapshot());
    } finally {
      if (!event.completer.isCompleted) event.completer.complete();
    }
  }

  void _onSearchChanged(
    ReferByReportSearchChanged event,
    Emitter<ReferByReportState> emit,
  ) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_debounceDuration, () {
      add(ReferByReportSearchSubmitted(event.search));
    });
  }

  Future<void> _onSearchSubmitted(
    ReferByReportSearchSubmitted event,
    Emitter<ReferByReportState> emit,
  ) async {
    _searchDebounce?.cancel();
    _query = _query.copyWith(search: event.search);
    await _reloadList(emit);
  }

  Future<void> _onFiltersApplied(
    ReferByReportFiltersApplied event,
    Emitter<ReferByReportState> emit,
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
        referralType: event.referralType,
        clearFromDate: event.clearFromDate,
        clearToDate: event.clearToDate,
        clearClinicId: event.clearClinicId,
        clearReceptionistId: event.clearReceptionistId,
        clearReferralType: event.clearReferralType,
      );
    }

    await _reloadList(emit);
  }

  Future<void> _reloadList(Emitter<ReferByReportState> emit) async {
    final current = state;
    if (current is ReferByReportLoaded) {
      emit(current.copyWith(isRefreshingList: true, query: _query));
      await _loadRows(emit, keepOnError: _snapshot());
      return;
    }
    emit(const ReferByReportLoading());
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
    if (s is ReferByReportLoaded) {
      return _Snapshot(
        rows: s.rows,
        filterOptions: s.filterOptions,
        query: s.query,
      );
    }
    if (s is ReferByReportError) {
      return _Snapshot(
        rows: s.rows,
        filterOptions: s.filterOptions,
        query: s.query,
      );
    }
    return _Snapshot(filterOptions: _filterOptions, query: _query);
  }

  List<String> _searchFields(ReferByReportEntity row) => [
        row.referralSource,
        row.referralType,
      ];

  Future<void> _loadRows(
    Emitter<ReferByReportState> emit, {
    _Snapshot keepOnError = const _Snapshot(),
  }) async {
    // Keep search local so the API still returns the full filtered list.
    final result = await getReferByReportUseCase(_query.copyWith(search: ''));

    result.when(
      success: (rows) {
        emit(ReferByReportLoaded(
          rows: AppSearchRanker.matchesThenRelated(
            items: rows,
            query: _query.search,
            fieldsOf: _searchFields,
          ),
          isRefreshingList: false,
          filterOptions: _filterOptions,
          query: _query,
        ));
      },
      failure: (failure) {
        emit(ReferByReportError(
          title: failure.title,
          message: failure.message,
          rows: keepOnError.rows,
          filterOptions: keepOnError.filterOptions,
          query: keepOnError.query,
        ));
        if (keepOnError.rows.isNotEmpty) {
          emit(ReferByReportLoaded(
            rows: keepOnError.rows,
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
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const ReferByReportQuery(),
  });

  final List<ReferByReportEntity> rows;
  final ReportFilterOptionsEntity filterOptions;
  final ReferByReportQuery query;
}
