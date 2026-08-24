import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_summary_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/usecases/get_assistant_manager_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/usecases/get_report_filter_options_usecase.dart';

part 'assistant_manager_report_event.dart';
part 'assistant_manager_report_state.dart';

// ============================================================
// ASSISTANT MANAGER REPORT BLOC
// ------------------------------------------------------------
// Same flow as ReceptionistReportBloc / ConsultationReportBloc.
// ============================================================

class AssistantManagerReportBloc
    extends Bloc<AssistantManagerReportEvent, AssistantManagerReportState> {
  AssistantManagerReportBloc({
    required this.getAssistantManagerReportUseCase,
    required this.getReportFilterOptionsUseCase,
  }) : super(const AssistantManagerReportInitial()) {
    on<AssistantManagerReportStarted>(_onStarted);
    on<AssistantManagerReportRefreshed>(_onRefreshed);
    on<AssistantManagerReportLoadMore>(_onLoadMore);
    on<AssistantManagerReportSearchChanged>(_onSearchChanged);
    on<AssistantManagerReportSearchSubmitted>(_onSearchSubmitted);
    on<AssistantManagerReportFiltersApplied>(_onFiltersApplied);
    on<AssistantManagerReportStatsToggled>(_onStatsToggled);
  }

  final GetAssistantManagerReportUseCase getAssistantManagerReportUseCase;
  final GetReportFilterOptionsUseCase getReportFilterOptionsUseCase;

  bool _isFetchingMore = false;
  AssistantManagerReportQuery _query = const AssistantManagerReportQuery();
  ReportFilterOptionsEntity _filterOptions =
      const ReportFilterOptionsEntity.empty();
  Timer? _searchDebounce;

  static const _debounceDuration = Duration(milliseconds: 450);

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(AssistantManagerReportRefreshed(completer: completer));
    return completer.future;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    AssistantManagerReportStarted event,
    Emitter<AssistantManagerReportState> emit,
  ) async {
    emit(const AssistantManagerReportLoading());
    _query = const AssistantManagerReportQuery();
    await _loadFilterOptions();
    await _loadPage(emit, page: 1, replace: true);
  }

  Future<void> _onRefreshed(
    AssistantManagerReportRefreshed event,
    Emitter<AssistantManagerReportState> emit,
  ) async {
    try {
      await _loadFilterOptions();
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
    } finally {
      if (!event.completer.isCompleted) event.completer.complete();
    }
  }

  Future<void> _onLoadMore(
    AssistantManagerReportLoadMore event,
    Emitter<AssistantManagerReportState> emit,
  ) async {
    final current = state;
    if (current is! AssistantManagerReportLoaded) return;
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
    AssistantManagerReportSearchChanged event,
    Emitter<AssistantManagerReportState> emit,
  ) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_debounceDuration, () {
      add(AssistantManagerReportSearchSubmitted(event.search));
    });
  }

  Future<void> _onSearchSubmitted(
    AssistantManagerReportSearchSubmitted event,
    Emitter<AssistantManagerReportState> emit,
  ) async {
    _searchDebounce?.cancel();
    _query = _query.copyWith(search: event.search, page: 1);
    await _reloadList(emit);
  }

  Future<void> _onFiltersApplied(
    AssistantManagerReportFiltersApplied event,
    Emitter<AssistantManagerReportState> emit,
  ) async {
    _searchDebounce?.cancel();

    if (event.resetAll) {
      _query = _query.resetFilters();
    } else {
      _query = _query.copyWith(
        fromDate: event.fromDate,
        toDate: event.toDate,
        assistantManagerId: event.assistantManagerId,
        clinicId: event.clinicId,
        perPage: event.perPage,
        clearFromDate: event.clearFromDate,
        clearToDate: event.clearToDate,
        clearAssistantManagerId: event.clearAssistantManagerId,
        clearClinicId: event.clearClinicId,
        page: 1,
      );
    }

    await _reloadList(emit);
  }

  void _onStatsToggled(
    AssistantManagerReportStatsToggled event,
    Emitter<AssistantManagerReportState> emit,
  ) {
    final current = state;
    if (current is AssistantManagerReportLoaded) {
      emit(current.copyWith(showStats: !current.showStats));
    }
  }

  Future<void> _reloadList(Emitter<AssistantManagerReportState> emit) async {
    final current = state;
    if (current is AssistantManagerReportLoaded) {
      emit(current.copyWith(isRefreshingList: true, query: _query));
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
      return;
    }
    emit(const AssistantManagerReportLoading());
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
    if (s is AssistantManagerReportLoaded) {
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
    if (s is AssistantManagerReportError) {
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

  AssistantManagerReportSummaryEntity _resolvedSummary({
    required AssistantManagerReportSummaryEntity incoming,
    required List<AssistantManagerReportEntity> rows,
    required int visitCount,
  }) {
    final fallback = AssistantManagerReportSummaryEntity.fromRows(
      rows,
      visitCount: visitCount,
      clinicNames: [
        for (final clinic in _filterOptions.clinics) clinic.name,
      ],
    );
    if (incoming.isEmpty) return fallback;
    if (incoming.clinics.isNotEmpty) return incoming;
    return AssistantManagerReportSummaryEntity(
      totalVisits: incoming.totalVisits,
      clinics: fallback.clinics,
    );
  }

  List<String> _searchFields(AssistantManagerReportEntity row) => [
        row.patientName,
        row.patientPhone,
        row.patientCnic,
        row.assistantManagerName,
        row.consultantName,
        row.clinicName,
        row.stage,
      ];

  Future<void> _loadPage(
    Emitter<AssistantManagerReportState> emit, {
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

    final result = await getAssistantManagerReportUseCase(fetchQuery);

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

        emit(AssistantManagerReportLoaded(
          rows: merged,
          currentPage: pageData.currentPage,
          lastPage: pageData.lastPage,
          total: pageData.total,
          summary: _resolvedSummary(
            incoming: pageData.summary,
            rows: merged,
            visitCount: pageData.total,
          ),
          showStats: keepOnError.showStats,
          isLoadingMore: false,
          isRefreshingList: false,
          filterOptions: _filterOptions,
          query: _query,
        ));
      },
      failure: (failure) {
        emit(AssistantManagerReportError(
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
          emit(AssistantManagerReportLoaded(
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
    Emitter<AssistantManagerReportState> emit, {
    required _Snapshot keepOnError,
  }) async {
    final results = await Future.wait([
      getAssistantManagerReportUseCase(_query),
      getAssistantManagerReportUseCase(_query.copyWith(search: '', page: 1)),
    ]);
    final matchResult = results[0];
    final relatedResult = results[1];

    if (matchResult.isFailure && relatedResult.isFailure) {
      final failure = matchResult.failure;
      emit(AssistantManagerReportError(
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
        emit(AssistantManagerReportLoaded(
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
        : <AssistantManagerReportEntity>[];
    final relatedPage = relatedResult.isSuccess ? relatedResult.data : null;
    final related = relatedPage?.rows ?? <AssistantManagerReportEntity>[];

    final rankedRows = AppSearchRanker.pinMatchesThenRelated(
      matches: matches,
      related: related,
      query: _query.search,
      idOf: (row) => row.id,
      fieldsOf: _searchFields,
    );
    final rankedTotal = relatedPage?.total ?? matches.length;

    emit(AssistantManagerReportLoaded(
      rows: rankedRows,
      currentPage: relatedPage?.currentPage ?? 1,
      lastPage: relatedPage?.lastPage ?? 1,
      total: rankedTotal,
      summary: _resolvedSummary(
        incoming: relatedPage?.summary ??
            (matchResult.isSuccess
                ? matchResult.data.summary
                : const AssistantManagerReportSummaryEntity.empty()),
        rows: rankedRows,
        visitCount: rankedTotal,
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
    this.summary = const AssistantManagerReportSummaryEntity.empty(),
    this.showStats = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const AssistantManagerReportQuery(),
  });

  final List<AssistantManagerReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final AssistantManagerReportSummaryEntity summary;
  final bool showStats;
  final ReportFilterOptionsEntity filterOptions;
  final AssistantManagerReportQuery query;
}
