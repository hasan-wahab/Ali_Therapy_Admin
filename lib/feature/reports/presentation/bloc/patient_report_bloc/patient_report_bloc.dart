import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/entities/patient_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/entities/patient_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/usecases/get_patient_report_usecase.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/usecases/get_report_filter_options_usecase.dart';

part 'patient_report_event.dart';
part 'patient_report_state.dart';

// ============================================================
// PATIENT REPORT BLOC
// ------------------------------------------------------------
// Same flow as ReceptionistReportBloc / ConsultationReportBloc.
// ============================================================

class PatientReportBloc extends Bloc<PatientReportEvent, PatientReportState> {
  PatientReportBloc({
    required this.getPatientReportUseCase,
    required this.getReportFilterOptionsUseCase,
  }) : super(const PatientReportInitial()) {
    on<PatientReportStarted>(_onStarted);
    on<PatientReportRefreshed>(_onRefreshed);
    on<PatientReportLoadMore>(_onLoadMore);
    on<PatientReportSearchChanged>(_onSearchChanged);
    on<PatientReportSearchSubmitted>(_onSearchSubmitted);
    on<PatientReportFiltersApplied>(_onFiltersApplied);
  }

  final GetPatientReportUseCase getPatientReportUseCase;
  final GetReportFilterOptionsUseCase getReportFilterOptionsUseCase;

  bool _isFetchingMore = false;
  PatientReportQuery _query = const PatientReportQuery();
  ReportFilterOptionsEntity _filterOptions =
      const ReportFilterOptionsEntity.empty();
  Timer? _searchDebounce;

  static const _debounceDuration = Duration(milliseconds: 450);

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(PatientReportRefreshed(completer: completer));
    return completer.future;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    PatientReportStarted event,
    Emitter<PatientReportState> emit,
  ) async {
    emit(const PatientReportLoading());
    _query = const PatientReportQuery();
    await _loadFilterOptions();
    await _loadPage(emit, page: 1, replace: true);
  }

  Future<void> _onRefreshed(
    PatientReportRefreshed event,
    Emitter<PatientReportState> emit,
  ) async {
    try {
      await _loadFilterOptions();
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
    } finally {
      if (!event.completer.isCompleted) event.completer.complete();
    }
  }

  Future<void> _onLoadMore(
    PatientReportLoadMore event,
    Emitter<PatientReportState> emit,
  ) async {
    final current = state;
    if (current is! PatientReportLoaded) return;
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
    PatientReportSearchChanged event,
    Emitter<PatientReportState> emit,
  ) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_debounceDuration, () {
      add(PatientReportSearchSubmitted(event.search));
    });
  }

  Future<void> _onSearchSubmitted(
    PatientReportSearchSubmitted event,
    Emitter<PatientReportState> emit,
  ) async {
    _searchDebounce?.cancel();
    _query = _query.copyWith(search: event.search, page: 1);
    await _reloadList(emit);
  }

  Future<void> _onFiltersApplied(
    PatientReportFiltersApplied event,
    Emitter<PatientReportState> emit,
  ) async {
    _searchDebounce?.cancel();

    if (event.resetAll) {
      _query = _query.resetFilters();
    } else {
      _query = _query.copyWith(
        fromDate: event.fromDate,
        toDate: event.toDate,
        clinicId: event.clinicId,
        consultantId: event.consultantId,
        therapistId: event.therapistId,
        assistantManagerId: event.assistantManagerId,
        receptionistId: event.receptionistId,
        perPage: event.perPage,
        clearFromDate: event.clearFromDate,
        clearToDate: event.clearToDate,
        clearClinicId: event.clearClinicId,
        clearConsultantId: event.clearConsultantId,
        clearTherapistId: event.clearTherapistId,
        clearAssistantManagerId: event.clearAssistantManagerId,
        clearReceptionistId: event.clearReceptionistId,
        page: 1,
      );
    }

    await _reloadList(emit);
  }

  Future<void> _reloadList(Emitter<PatientReportState> emit) async {
    final current = state;
    if (current is PatientReportLoaded) {
      emit(current.copyWith(isRefreshingList: true, query: _query));
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
      return;
    }
    emit(const PatientReportLoading());
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
    if (s is PatientReportLoaded) {
      return _Snapshot(
        rows: s.rows,
        currentPage: s.currentPage,
        lastPage: s.lastPage,
        total: s.total,
        filterOptions: s.filterOptions,
        query: s.query,
      );
    }
    if (s is PatientReportError) {
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

  List<String> _searchFields(PatientReportEntity row) => [
    row.patientName,
    row.email,
  ];

  Future<void> _loadPage(
    Emitter<PatientReportState> emit, {
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

    final result = await getPatientReportUseCase(fetchQuery);

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

        emit(
          PatientReportLoaded(
            rows: merged,
            currentPage: pageData.currentPage,
            lastPage: pageData.lastPage,
            total: pageData.total,
            isLoadingMore: false,
            isRefreshingList: false,
            filterOptions: _filterOptions,
            query: _query,
          ),
        );
      },
      failure: (failure) {
        emit(
          PatientReportError(
            title: failure.title,
            message: failure.message,
            rows: keepOnError.rows,
            currentPage: keepOnError.currentPage,
            lastPage: keepOnError.lastPage,
            total: keepOnError.total,
            filterOptions: keepOnError.filterOptions,
            query: keepOnError.query,
          ),
        );
        if (keepOnError.rows.isNotEmpty) {
          emit(
            PatientReportLoaded(
              rows: keepOnError.rows,
              currentPage: keepOnError.currentPage,
              lastPage: keepOnError.lastPage,
              total: keepOnError.total,
              isLoadingMore: false,
              isRefreshingList: false,
              filterOptions: keepOnError.filterOptions,
              query: keepOnError.query,
            ),
          );
        }
      },
    );
  }

  Future<void> _loadRankedFirstPage(
    Emitter<PatientReportState> emit, {
    required _Snapshot keepOnError,
  }) async {
    final results = await Future.wait([
      getPatientReportUseCase(_query),
      getPatientReportUseCase(_query.copyWith(search: '', page: 1)),
    ]);
    final matchResult = results[0];
    final relatedResult = results[1];

    if (matchResult.isFailure && relatedResult.isFailure) {
      final failure = matchResult.failure;
      emit(
        PatientReportError(
          title: failure.title,
          message: failure.message,
          rows: keepOnError.rows,
          currentPage: keepOnError.currentPage,
          lastPage: keepOnError.lastPage,
          total: keepOnError.total,
          filterOptions: keepOnError.filterOptions,
          query: keepOnError.query,
        ),
      );
      if (keepOnError.rows.isNotEmpty) {
        emit(
          PatientReportLoaded(
            rows: keepOnError.rows,
            currentPage: keepOnError.currentPage,
            lastPage: keepOnError.lastPage,
            total: keepOnError.total,
            isLoadingMore: false,
            isRefreshingList: false,
            filterOptions: keepOnError.filterOptions,
            query: keepOnError.query,
          ),
        );
      }
      return;
    }

    final matches = matchResult.isSuccess
        ? matchResult.data.rows
        : <PatientReportEntity>[];
    final relatedPage = relatedResult.isSuccess ? relatedResult.data : null;
    final related = relatedPage?.rows ?? <PatientReportEntity>[];

    emit(
      PatientReportLoaded(
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
      ),
    );
  }
}

class _Snapshot {
  const _Snapshot({
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const PatientReportQuery(),
  });

  final List<PatientReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReportFilterOptionsEntity filterOptions;
  final PatientReportQuery query;
}
