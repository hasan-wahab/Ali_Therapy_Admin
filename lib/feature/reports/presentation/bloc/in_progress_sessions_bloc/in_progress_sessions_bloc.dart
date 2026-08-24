import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_summary_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/usecases/get_in_progress_sessions_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/usecases/get_report_filter_options_usecase.dart';

part 'in_progress_sessions_event.dart';
part 'in_progress_sessions_state.dart';

// ============================================================
// IN-PROGRESS SESSIONS BLOC
// ------------------------------------------------------------
// Same flow as PatientDuesBloc:
// first load → search/filters → pull refresh → load more.
// Search: matches first, then related rows (dual fetch).
// ============================================================

class InProgressSessionsBloc
    extends Bloc<InProgressSessionsEvent, InProgressSessionsState> {
  InProgressSessionsBloc({
    required this.getInProgressSessionsUseCase,
    required this.getReportFilterOptionsUseCase,
  }) : super(const InProgressSessionsInitial()) {
    on<InProgressSessionsStarted>(_onStarted);
    on<InProgressSessionsRefreshed>(_onRefreshed);
    on<InProgressSessionsLoadMore>(_onLoadMore);
    on<InProgressSessionsSearchChanged>(_onSearchChanged);
    on<InProgressSessionsSearchSubmitted>(_onSearchSubmitted);
    on<InProgressSessionsFiltersApplied>(_onFiltersApplied);
    on<InProgressSessionsStatsToggled>(_onStatsToggled);
  }

  final GetInProgressSessionsUseCase getInProgressSessionsUseCase;
  final GetReportFilterOptionsUseCase getReportFilterOptionsUseCase;

  bool _isFetchingMore = false;
  InProgressSessionsQuery _query = const InProgressSessionsQuery();
  ReportFilterOptionsEntity _filterOptions =
      const ReportFilterOptionsEntity.empty();
  Timer? _searchDebounce;

  static const _debounceDuration = Duration(milliseconds: 450);

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(InProgressSessionsRefreshed(completer: completer));
    return completer.future;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    InProgressSessionsStarted event,
    Emitter<InProgressSessionsState> emit,
  ) async {
    emit(const InProgressSessionsLoading());
    _query = const InProgressSessionsQuery();
    await _loadFilterOptions();
    await _loadPage(emit, page: 1, replace: true);
  }

  Future<void> _onRefreshed(
    InProgressSessionsRefreshed event,
    Emitter<InProgressSessionsState> emit,
  ) async {
    try {
      await _loadFilterOptions();
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
    } finally {
      if (!event.completer.isCompleted) event.completer.complete();
    }
  }

  Future<void> _onLoadMore(
    InProgressSessionsLoadMore event,
    Emitter<InProgressSessionsState> emit,
  ) async {
    final current = state;
    if (current is! InProgressSessionsLoaded) return;
    if (!current.hasMore || current.isLoadingMore || _isFetchingMore) return;

    final snap = _snapshot();
    _isFetchingMore = true;
    emit(current.copyWith(isLoadingMore: true));

    await _loadPage(
      emit,
      page: current.currentPage + 1,
      replace: false,
      keepOnError: snap,
    );
    _isFetchingMore = false;
  }

  void _onSearchChanged(
    InProgressSessionsSearchChanged event,
    Emitter<InProgressSessionsState> emit,
  ) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_debounceDuration, () {
      add(InProgressSessionsSearchSubmitted(event.search));
    });
  }

  Future<void> _onSearchSubmitted(
    InProgressSessionsSearchSubmitted event,
    Emitter<InProgressSessionsState> emit,
  ) async {
    _searchDebounce?.cancel();
    _query = _query.copyWith(search: event.search, page: 1);
    await _reloadList(emit);
  }

  Future<void> _onFiltersApplied(
    InProgressSessionsFiltersApplied event,
    Emitter<InProgressSessionsState> emit,
  ) async {
    _searchDebounce?.cancel();

    if (event.resetAll) {
      _query = _query.resetFilters();
    } else {
      _query = _query.copyWith(
        sessionType: event.sessionType,
        clinicId: event.clinicId,
        staffId: event.staffId,
        fromDate: event.fromDate,
        toDate: event.toDate,
        perPage: event.perPage,
        clearClinicId: event.clearClinicId,
        clearStaffId: event.clearStaffId,
        clearFromDate: event.clearFromDate,
        clearToDate: event.clearToDate,
        page: 1,
      );
    }

    await _reloadList(emit);
  }

  void _onStatsToggled(
    InProgressSessionsStatsToggled event,
    Emitter<InProgressSessionsState> emit,
  ) {
    final current = state;
    if (current is InProgressSessionsLoaded) {
      emit(current.copyWith(showStats: !current.showStats));
    }
  }

  Future<void> _reloadList(Emitter<InProgressSessionsState> emit) async {
    final current = state;
    if (current is InProgressSessionsLoaded) {
      emit(current.copyWith(isRefreshingList: true, query: _query));
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
      return;
    }
    emit(const InProgressSessionsLoading());
    await _loadPage(emit, page: 1, replace: true);
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
    if (s is InProgressSessionsLoaded) {
      return _Snapshot(
        rows: s.rows,
        currentPage: s.currentPage,
        lastPage: s.lastPage,
        total: s.total,
        summary: s.summary,
        showStats: s.showStats,
        filterOptions: s.filterOptions,
        query: s.query,
      );
    }
    if (s is InProgressSessionsError) {
      return _Snapshot(
        rows: s.rows,
        currentPage: s.currentPage,
        lastPage: s.lastPage,
        total: s.total,
        summary: s.summary,
        showStats: s.showStats,
        filterOptions: s.filterOptions,
        query: s.query,
      );
    }
    return _Snapshot(filterOptions: _filterOptions, query: _query);
  }

  InProgressSessionsSummaryEntity _resolvedSummary({
    required InProgressSessionsSummaryEntity incoming,
    required List<InProgressSessionsEntity> rows,
    required int sessionCount,
  }) {
    final fallback = InProgressSessionsSummaryEntity.fromRows(
      rows,
      sessionCount: sessionCount,
    );
    if (incoming.isEmpty) return fallback;
    if (incoming.consultationsActive == 0 &&
        incoming.therapyActive == 0 &&
        incoming.clinicsActive == 0) {
      return InProgressSessionsSummaryEntity(
        totalInProgress: incoming.totalInProgress,
        consultationsActive: fallback.consultationsActive,
        therapyActive: fallback.therapyActive,
        clinicsActive: fallback.clinicsActive,
      );
    }
    return incoming;
  }

  List<String> _searchFields(InProgressSessionsEntity row) => [
        row.patientName,
        row.mrNo,
        row.patientCnic,
        row.consultantName,
        row.therapistName,
        row.clinicName,
        ...row.sessionTypes,
      ];

  Future<void> _loadPage(
    Emitter<InProgressSessionsState> emit, {
    required int page,
    required bool replace,
    _Snapshot keepOnError = const _Snapshot(),
  }) async {
    _query = _query.copyWith(page: page);
    final search = _query.search.trim();

    if (search.isNotEmpty && replace) {
      await _loadRankedFirstPage(emit, keepOnError: keepOnError);
      return;
    }

    final fetchQuery = search.isNotEmpty
        ? _query.copyWith(search: '', page: page)
        : _query;

    final result = await getInProgressSessionsUseCase(fetchQuery);

    result.when(
      success: (pageData) {
        var merged = replace
            ? pageData.rows
            : AppSearchRanker.appendUnique(
                current: keepOnError.rows,
                extra: pageData.rows,
                idOf: (row) => row.id,
              );

        if (search.isNotEmpty) {
          merged = AppSearchRanker.matchesThenRelated(
            items: merged,
            query: search,
            fieldsOf: _searchFields,
          );
        }

        emit(InProgressSessionsLoaded(
          rows: merged,
          currentPage: pageData.currentPage,
          lastPage: pageData.lastPage,
          total: pageData.total,
          summary: _resolvedSummary(
            incoming: pageData.summary,
            rows: merged,
            sessionCount: pageData.total,
          ),
          showStats: keepOnError.showStats,
          isLoadingMore: false,
          isRefreshingList: false,
          filterOptions: _filterOptions,
          query: _query,
        ));
      },
      failure: (failure) {
        emit(InProgressSessionsError(
          title: failure.title,
          message: failure.message,
          rows: keepOnError.rows,
          currentPage: keepOnError.currentPage,
          lastPage: keepOnError.lastPage,
          total: keepOnError.total,
          summary: keepOnError.summary,
          showStats: keepOnError.showStats,
          filterOptions: keepOnError.filterOptions,
          query: keepOnError.query,
        ));
        if (keepOnError.rows.isNotEmpty) {
          emit(InProgressSessionsLoaded(
            rows: keepOnError.rows,
            currentPage: keepOnError.currentPage,
            lastPage: keepOnError.lastPage,
            total: keepOnError.total,
            summary: keepOnError.summary,
            showStats: keepOnError.showStats,
            isLoadingMore: false,
            isRefreshingList: false,
            filterOptions: keepOnError.filterOptions,
            query: keepOnError.query,
          ));
        }
      },
    );
  }

  Future<void> _loadRankedFirstPage(
    Emitter<InProgressSessionsState> emit, {
    required _Snapshot keepOnError,
  }) async {
    final results = await Future.wait([
      getInProgressSessionsUseCase(_query),
      getInProgressSessionsUseCase(_query.copyWith(search: '', page: 1)),
    ]);
    final matchResult = results[0];
    final relatedResult = results[1];

    if (matchResult.isFailure && relatedResult.isFailure) {
      final failure = matchResult.failure;
      emit(InProgressSessionsError(
        title: failure.title,
        message: failure.message,
        rows: keepOnError.rows,
        currentPage: keepOnError.currentPage,
        lastPage: keepOnError.lastPage,
        total: keepOnError.total,
        summary: keepOnError.summary,
        showStats: keepOnError.showStats,
        filterOptions: keepOnError.filterOptions,
        query: keepOnError.query,
      ));
      if (keepOnError.rows.isNotEmpty) {
        emit(InProgressSessionsLoaded(
          rows: keepOnError.rows,
          currentPage: keepOnError.currentPage,
          lastPage: keepOnError.lastPage,
          total: keepOnError.total,
          summary: keepOnError.summary,
          showStats: keepOnError.showStats,
          isLoadingMore: false,
          isRefreshingList: false,
          filterOptions: keepOnError.filterOptions,
          query: keepOnError.query,
        ));
      }
      return;
    }

    final matches = matchResult.isSuccess
        ? matchResult.data.rows
        : <InProgressSessionsEntity>[];
    final relatedPage = relatedResult.isSuccess ? relatedResult.data : null;
    final related = relatedPage?.rows ?? <InProgressSessionsEntity>[];

    final rankedRows = AppSearchRanker.pinMatchesThenRelated(
      matches: matches,
      related: related,
      query: _query.search,
      idOf: (row) => row.id,
      fieldsOf: _searchFields,
    );
    final rankedTotal = relatedPage?.total ?? matches.length;

    emit(InProgressSessionsLoaded(
      rows: rankedRows,
      currentPage: relatedPage?.currentPage ?? 1,
      lastPage: relatedPage?.lastPage ?? 1,
      total: rankedTotal,
      summary: _resolvedSummary(
        incoming: relatedPage?.summary ??
            (matchResult.isSuccess
                ? matchResult.data.summary
                : const InProgressSessionsSummaryEntity.empty()),
        rows: rankedRows,
        sessionCount: rankedTotal,
      ),
      showStats: keepOnError.showStats,
      isLoadingMore: false,
      isRefreshingList: false,
      filterOptions: _filterOptions,
      query: _query,
    ));
  }
}

class _Snapshot {
  const _Snapshot({
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.summary = const InProgressSessionsSummaryEntity.empty(),
    this.showStats = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const InProgressSessionsQuery(),
  });

  final List<InProgressSessionsEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final InProgressSessionsSummaryEntity summary;
  final bool showStats;
  final ReportFilterOptionsEntity filterOptions;
  final InProgressSessionsQuery query;
}
