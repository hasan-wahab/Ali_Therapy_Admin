import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/usecases/get_discount_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/usecases/get_report_filter_options_usecase.dart';

part 'discount_report_event.dart';
part 'discount_report_state.dart';

// ============================================================
// DISCOUNT REPORT BLOC
// ------------------------------------------------------------
// Same flow as PatientDuesBloc:
// first load → search/filters → pull refresh → load more.
// Search: matches first, then related rows (dual fetch).
// ============================================================

class DiscountReportBloc
    extends Bloc<DiscountReportEvent, DiscountReportState> {
  DiscountReportBloc({
    required this.getDiscountReportUseCase,
    required this.getReportFilterOptionsUseCase,
  }) : super(const DiscountReportInitial()) {
    on<DiscountReportStarted>(_onStarted);
    on<DiscountReportRefreshed>(_onRefreshed);
    on<DiscountReportLoadMore>(_onLoadMore);
    on<DiscountReportSearchChanged>(_onSearchChanged);
    on<DiscountReportSearchSubmitted>(_onSearchSubmitted);
    on<DiscountReportFiltersApplied>(_onFiltersApplied);
  }

  final GetDiscountReportUseCase getDiscountReportUseCase;
  final GetReportFilterOptionsUseCase getReportFilterOptionsUseCase;

  bool _isFetchingMore = false;
  DiscountReportQuery _query = const DiscountReportQuery();
  ReportFilterOptionsEntity _filterOptions =
      const ReportFilterOptionsEntity.empty();
  Timer? _searchDebounce;

  static const _debounceDuration = Duration(milliseconds: 450);

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(DiscountReportRefreshed(completer: completer));
    return completer.future;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    DiscountReportStarted event,
    Emitter<DiscountReportState> emit,
  ) async {
    emit(const DiscountReportLoading());
    _query = const DiscountReportQuery();
    await _loadFilterOptions();
    await _loadPage(emit, page: 1, replace: true);
  }

  Future<void> _onRefreshed(
    DiscountReportRefreshed event,
    Emitter<DiscountReportState> emit,
  ) async {
    try {
      await _loadFilterOptions();
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
    } finally {
      if (!event.completer.isCompleted) event.completer.complete();
    }
  }

  Future<void> _onLoadMore(
    DiscountReportLoadMore event,
    Emitter<DiscountReportState> emit,
  ) async {
    final current = state;
    if (current is! DiscountReportLoaded) return;
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
    DiscountReportSearchChanged event,
    Emitter<DiscountReportState> emit,
  ) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_debounceDuration, () {
      add(DiscountReportSearchSubmitted(event.search));
    });
  }

  Future<void> _onSearchSubmitted(
    DiscountReportSearchSubmitted event,
    Emitter<DiscountReportState> emit,
  ) async {
    _searchDebounce?.cancel();
    _query = _query.copyWith(search: event.search, page: 1);
    await _reloadList(emit);
  }

  Future<void> _onFiltersApplied(
    DiscountReportFiltersApplied event,
    Emitter<DiscountReportState> emit,
  ) async {
    _searchDebounce?.cancel();

    if (event.resetAll) {
      _query = _query.resetFilters();
    } else {
      _query = _query.copyWith(
        clinicId: event.clinicId,
        consultantId: event.consultantId,
        receptionistId: event.receptionistId,
        fromDate: event.fromDate,
        toDate: event.toDate,
        discountPercent: event.discountPercent,
        clearClinicId: event.clearClinicId,
        clearConsultantId: event.clearConsultantId,
        clearReceptionistId: event.clearReceptionistId,
        clearFromDate: event.clearFromDate,
        clearToDate: event.clearToDate,
        clearDiscountPercent: event.clearDiscountPercent,
        page: 1,
      );
    }

    await _reloadList(emit);
  }

  Future<void> _reloadList(Emitter<DiscountReportState> emit) async {
    final current = state;
    if (current is DiscountReportLoaded) {
      emit(current.copyWith(isRefreshingList: true, query: _query));
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
      return;
    }
    emit(const DiscountReportLoading());
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
    if (s is DiscountReportLoaded) {
      return _Snapshot(
        rows: s.rows,
        currentPage: s.currentPage,
        lastPage: s.lastPage,
        total: s.total,
        filterOptions: s.filterOptions,
        query: s.query,
      );
    }
    if (s is DiscountReportError) {
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

  List<String> _searchFields(DiscountReportEntity row) => [
        row.patientName,
        row.patientPhone,
        row.patientCnic,
        row.consultantName,
        row.receptionistName,
        row.clinicName,
      ];

  List<DiscountReportEntity> _applyLocalDiscountFilter(
    List<DiscountReportEntity> rows,
  ) {
    final percent = _query.discountPercent;
    if (percent == null) return rows;
    return rows.where((row) => row.discountPercent == percent).toList();
  }

  Future<void> _loadPage(
    Emitter<DiscountReportState> emit, {
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

    final result = await getDiscountReportUseCase(fetchQuery);

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

        emit(DiscountReportLoaded(
          rows: _applyLocalDiscountFilter(merged),
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
        emit(DiscountReportError(
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
          emit(DiscountReportLoaded(
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
    Emitter<DiscountReportState> emit, {
    required _Snapshot keepOnError,
  }) async {
    final results = await Future.wait([
      getDiscountReportUseCase(_query),
      getDiscountReportUseCase(_query.copyWith(search: '', page: 1)),
    ]);
    final matchResult = results[0];
    final relatedResult = results[1];

    if (matchResult.isFailure && relatedResult.isFailure) {
      final failure = matchResult.failure;
      emit(DiscountReportError(
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
        emit(DiscountReportLoaded(
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
        : <DiscountReportEntity>[];
    final relatedPage = relatedResult.isSuccess ? relatedResult.data : null;
    final related = relatedPage?.rows ?? <DiscountReportEntity>[];

    emit(DiscountReportLoaded(
      rows: _applyLocalDiscountFilter(
        AppSearchRanker.pinMatchesThenRelated(
          matches: matches,
          related: related,
          query: _query.search,
          idOf: (row) => row.id,
          fieldsOf: _searchFields,
        ),
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
    this.query = const DiscountReportQuery(),
  });

  final List<DiscountReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReportFilterOptionsEntity filterOptions;
  final DiscountReportQuery query;
}
