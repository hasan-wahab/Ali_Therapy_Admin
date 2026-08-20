import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/usecases/get_report_filter_options_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/entities/therapist_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/entities/therapist_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/usecases/get_therapist_report_usecase.dart';

part 'therapist_report_event.dart';
part 'therapist_report_state.dart';

// ============================================================
// THERAPIST REPORT BLOC
// ------------------------------------------------------------
// Same flow as ConsultationReportBloc / PatientDuesBloc.
// ============================================================

class TherapistReportBloc
    extends Bloc<TherapistReportEvent, TherapistReportState> {
  TherapistReportBloc({
    required this.getTherapistReportUseCase,
    required this.getReportFilterOptionsUseCase,
  }) : super(const TherapistReportInitial()) {
    on<TherapistReportStarted>(_onStarted);
    on<TherapistReportRefreshed>(_onRefreshed);
    on<TherapistReportLoadMore>(_onLoadMore);
    on<TherapistReportSearchChanged>(_onSearchChanged);
    on<TherapistReportSearchSubmitted>(_onSearchSubmitted);
    on<TherapistReportFiltersApplied>(_onFiltersApplied);
  }

  final GetTherapistReportUseCase getTherapistReportUseCase;
  final GetReportFilterOptionsUseCase getReportFilterOptionsUseCase;

  bool _isFetchingMore = false;
  TherapistReportQuery _query = const TherapistReportQuery();
  ReportFilterOptionsEntity _filterOptions =
      const ReportFilterOptionsEntity.empty();
  Timer? _searchDebounce;

  static const _debounceDuration = Duration(milliseconds: 450);

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(TherapistReportRefreshed(completer: completer));
    return completer.future;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    TherapistReportStarted event,
    Emitter<TherapistReportState> emit,
  ) async {
    emit(const TherapistReportLoading());
    _query = const TherapistReportQuery();
    await _loadFilterOptions();
    await _loadPage(emit, page: 1, replace: true);
  }

  Future<void> _onRefreshed(
    TherapistReportRefreshed event,
    Emitter<TherapistReportState> emit,
  ) async {
    try {
      await _loadFilterOptions();
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
    } finally {
      if (!event.completer.isCompleted) event.completer.complete();
    }
  }

  Future<void> _onLoadMore(
    TherapistReportLoadMore event,
    Emitter<TherapistReportState> emit,
  ) async {
    final current = state;
    if (current is! TherapistReportLoaded) return;
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
    TherapistReportSearchChanged event,
    Emitter<TherapistReportState> emit,
  ) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_debounceDuration, () {
      add(TherapistReportSearchSubmitted(event.search));
    });
  }

  Future<void> _onSearchSubmitted(
    TherapistReportSearchSubmitted event,
    Emitter<TherapistReportState> emit,
  ) async {
    _searchDebounce?.cancel();
    _query = _query.copyWith(search: event.search, page: 1);
    await _reloadList(emit);
  }

  Future<void> _onFiltersApplied(
    TherapistReportFiltersApplied event,
    Emitter<TherapistReportState> emit,
  ) async {
    _searchDebounce?.cancel();

    if (event.resetAll) {
      _query = _query.resetFilters();
    } else {
      _query = _query.copyWith(
        fromDate: event.fromDate,
        toDate: event.toDate,
        therapistId: event.therapistId,
        clinicId: event.clinicId,
        perPage: event.perPage,
        clearFromDate: event.clearFromDate,
        clearToDate: event.clearToDate,
        clearTherapistId: event.clearTherapistId,
        clearClinicId: event.clearClinicId,
        page: 1,
      );
    }

    await _reloadList(emit);
  }

  Future<void> _reloadList(Emitter<TherapistReportState> emit) async {
    final current = state;
    if (current is TherapistReportLoaded) {
      emit(current.copyWith(isRefreshingList: true, query: _query));
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
      return;
    }
    emit(const TherapistReportLoading());
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
    if (s is TherapistReportLoaded) {
      return _Snapshot(
        rows: s.rows,
        currentPage: s.currentPage,
        lastPage: s.lastPage,
        total: s.total,
        filterOptions: s.filterOptions,
        query: s.query,
      );
    }
    if (s is TherapistReportError) {
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

  List<String> _searchFields(TherapistReportEntity row) => [
        row.patientName,
        row.patientPhone,
        row.patientCnic,
        row.therapistName,
        row.consultantName,
        row.clinicName,
        row.status,
      ];

  Future<void> _loadPage(
    Emitter<TherapistReportState> emit, {
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

    final result = await getTherapistReportUseCase(fetchQuery);

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

        emit(TherapistReportLoaded(
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
        emit(TherapistReportError(
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
          emit(TherapistReportLoaded(
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
    Emitter<TherapistReportState> emit, {
    required _Snapshot keepOnError,
  }) async {
    final results = await Future.wait([
      getTherapistReportUseCase(_query),
      getTherapistReportUseCase(_query.copyWith(search: '', page: 1)),
    ]);
    final matchResult = results[0];
    final relatedResult = results[1];

    if (matchResult.isFailure && relatedResult.isFailure) {
      final failure = matchResult.failure;
      emit(TherapistReportError(
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
        emit(TherapistReportLoaded(
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
        : <TherapistReportEntity>[];
    final relatedPage = relatedResult.isSuccess ? relatedResult.data : null;
    final related = relatedPage?.rows ?? <TherapistReportEntity>[];

    emit(TherapistReportLoaded(
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
    this.query = const TherapistReportQuery(),
  });

  final List<TherapistReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReportFilterOptionsEntity filterOptions;
  final TherapistReportQuery query;
}
