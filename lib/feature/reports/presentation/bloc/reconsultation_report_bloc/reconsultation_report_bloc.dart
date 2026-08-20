import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/entities/reconsultation_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/entities/reconsultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/usecases/get_reconsultation_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/usecases/get_report_filter_options_usecase.dart';

part 'reconsultation_report_event.dart';
part 'reconsultation_report_state.dart';

// ============================================================
// RECONSULTATION REPORT BLOC
// ------------------------------------------------------------
// Same flow as ConsultationReportBloc / TherapistReportBloc.
// ============================================================

class ReconsultationReportBloc
    extends Bloc<ReconsultationReportEvent, ReconsultationReportState> {
  ReconsultationReportBloc({
    required this.getReconsultationReportUseCase,
    required this.getReportFilterOptionsUseCase,
  }) : super(const ReconsultationReportInitial()) {
    on<ReconsultationReportStarted>(_onStarted);
    on<ReconsultationReportRefreshed>(_onRefreshed);
    on<ReconsultationReportLoadMore>(_onLoadMore);
    on<ReconsultationReportSearchChanged>(_onSearchChanged);
    on<ReconsultationReportSearchSubmitted>(_onSearchSubmitted);
    on<ReconsultationReportFiltersApplied>(_onFiltersApplied);
  }

  final GetReconsultationReportUseCase getReconsultationReportUseCase;
  final GetReportFilterOptionsUseCase getReportFilterOptionsUseCase;

  bool _isFetchingMore = false;
  ReconsultationReportQuery _query = const ReconsultationReportQuery();
  ReportFilterOptionsEntity _filterOptions =
      const ReportFilterOptionsEntity.empty();
  Timer? _searchDebounce;

  static const _debounceDuration = Duration(milliseconds: 450);

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(ReconsultationReportRefreshed(completer: completer));
    return completer.future;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    ReconsultationReportStarted event,
    Emitter<ReconsultationReportState> emit,
  ) async {
    emit(const ReconsultationReportLoading());
    _query = const ReconsultationReportQuery();
    await _loadFilterOptions();
    await _loadPage(emit, page: 1, replace: true);
  }

  Future<void> _onRefreshed(
    ReconsultationReportRefreshed event,
    Emitter<ReconsultationReportState> emit,
  ) async {
    try {
      await _loadFilterOptions();
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
    } finally {
      if (!event.completer.isCompleted) event.completer.complete();
    }
  }

  Future<void> _onLoadMore(
    ReconsultationReportLoadMore event,
    Emitter<ReconsultationReportState> emit,
  ) async {
    final current = state;
    if (current is! ReconsultationReportLoaded) return;
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
    ReconsultationReportSearchChanged event,
    Emitter<ReconsultationReportState> emit,
  ) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_debounceDuration, () {
      add(ReconsultationReportSearchSubmitted(event.search));
    });
  }

  Future<void> _onSearchSubmitted(
    ReconsultationReportSearchSubmitted event,
    Emitter<ReconsultationReportState> emit,
  ) async {
    _searchDebounce?.cancel();
    _query = _query.copyWith(search: event.search, page: 1);
    await _reloadList(emit);
  }

  Future<void> _onFiltersApplied(
    ReconsultationReportFiltersApplied event,
    Emitter<ReconsultationReportState> emit,
  ) async {
    _searchDebounce?.cancel();

    if (event.resetAll) {
      _query = _query.resetFilters();
    } else {
      _query = _query.copyWith(
        fromDate: event.fromDate,
        toDate: event.toDate,
        consultantId: event.consultantId,
        clinicId: event.clinicId,
        perPage: event.perPage,
        clearFromDate: event.clearFromDate,
        clearToDate: event.clearToDate,
        clearConsultantId: event.clearConsultantId,
        clearClinicId: event.clearClinicId,
        page: 1,
      );
    }

    await _reloadList(emit);
  }

  Future<void> _reloadList(Emitter<ReconsultationReportState> emit) async {
    final current = state;
    if (current is ReconsultationReportLoaded) {
      emit(current.copyWith(isRefreshingList: true, query: _query));
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
      return;
    }
    emit(const ReconsultationReportLoading());
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
    if (s is ReconsultationReportLoaded) {
      return _Snapshot(
        rows: s.rows,
        currentPage: s.currentPage,
        lastPage: s.lastPage,
        total: s.total,
        filterOptions: s.filterOptions,
        query: s.query,
      );
    }
    if (s is ReconsultationReportError) {
      return _Snapshot(
        rows: s.rows,
        currentPage: s.currentPage,
        lastPage: s.lastPage,
        total: s.total,
        filterOptions: s.filterOptions,
        query: s.query,
      );
    }
    return _Snapshot(filterOptions: _filterOptions, query: _query);
  }

  List<String> _searchFields(ReconsultationReportEntity row) => [
        row.patientName,
        row.patientPhone,
        row.patientCnic,
        row.consultantName,
        row.clinicName,
      ];

  Future<void> _loadPage(
    Emitter<ReconsultationReportState> emit, {
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

    final result = await getReconsultationReportUseCase(fetchQuery);

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

        emit(ReconsultationReportLoaded(
          rows: merged,
          currentPage: pageData.currentPage,
          lastPage: pageData.lastPage,
          total: pageData.total,
          isLoadingMore: false,
          isRefreshingList: false,
          filterOptions: _filterOptions,
          query: _query,
        ));
      },
      failure: (failure) {
        emit(ReconsultationReportError(
          title: failure.title,
          message: failure.message,
          rows: keepOnError.rows,
          currentPage: keepOnError.currentPage,
          lastPage: keepOnError.lastPage,
          total: keepOnError.total,
          filterOptions: keepOnError.filterOptions,
          query: keepOnError.query,
        ));
        if (keepOnError.rows.isNotEmpty) {
          emit(ReconsultationReportLoaded(
            rows: keepOnError.rows,
            currentPage: keepOnError.currentPage,
            lastPage: keepOnError.lastPage,
            total: keepOnError.total,
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
    Emitter<ReconsultationReportState> emit, {
    required _Snapshot keepOnError,
  }) async {
    final results = await Future.wait([
      getReconsultationReportUseCase(_query),
      getReconsultationReportUseCase(_query.copyWith(search: '', page: 1)),
    ]);
    final matchResult = results[0];
    final relatedResult = results[1];

    if (matchResult.isFailure && relatedResult.isFailure) {
      final failure = matchResult.failure;
      emit(ReconsultationReportError(
        title: failure.title,
        message: failure.message,
        rows: keepOnError.rows,
        currentPage: keepOnError.currentPage,
        lastPage: keepOnError.lastPage,
        total: keepOnError.total,
        filterOptions: keepOnError.filterOptions,
        query: keepOnError.query,
      ));
      if (keepOnError.rows.isNotEmpty) {
        emit(ReconsultationReportLoaded(
          rows: keepOnError.rows,
          currentPage: keepOnError.currentPage,
          lastPage: keepOnError.lastPage,
          total: keepOnError.total,
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
        : <ReconsultationReportEntity>[];
    final relatedPage = relatedResult.isSuccess ? relatedResult.data : null;
    final related = relatedPage?.rows ?? <ReconsultationReportEntity>[];

    emit(ReconsultationReportLoaded(
      rows: AppSearchRanker.pinMatchesThenRelated(
        matches: matches,
        related: related,
        query: _query.search,
        idOf: (row) => row.id,
        fieldsOf: _searchFields,
      ),
      currentPage: relatedPage?.currentPage ?? 1,
      lastPage: relatedPage?.lastPage ?? 1,
      total: relatedPage?.total ?? matches.length,
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
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const ReconsultationReportQuery(),
  });

  final List<ReconsultationReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReportFilterOptionsEntity filterOptions;
  final ReconsultationReportQuery query;
}
