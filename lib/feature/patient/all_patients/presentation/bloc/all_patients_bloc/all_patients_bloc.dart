import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';

import '../../../domain/all_patients_domain/entities/patient_entity.dart';
import '../../../domain/all_patients_domain/entities/patients_list_query.dart';
import '../../../domain/all_patients_domain/usecases/get_all_patients_usecase.dart';

part 'all_patients_event.dart';
part 'all_patients_state.dart';

// ============================================================
// ALL PATIENTS BLOC
// ------------------------------------------------------------
// Started        → page 1
// SearchChanged  → debounce → page 1 with search + current filters
// FiltersApplied → immediate page 1 with new filters
// LoadMore       → next page, same query
// ============================================================

class AllPatientsBloc extends Bloc<AllPatientsEvent, AllPatientsState> {
  AllPatientsBloc({required this.getAllPatientsUseCase})
      : super(const AllPatientsInitial()) {
    on<AllPatientsStarted>(_onStarted);
    on<AllPatientsRefreshed>(_onRefreshed);
    on<AllPatientsLoadMore>(_onLoadMore);
    on<AllPatientsSearchChanged>(_onSearchChanged);
    on<AllPatientsSearchSubmitted>(_onSearchSubmitted);
    on<AllPatientsFiltersApplied>(_onFiltersApplied);
  }

  final GetAllPatientsUseCase getAllPatientsUseCase;

  bool _isFetchingMore = false;
  PatientsListQuery _query = const PatientsListQuery();
  Timer? _searchDebounce;

  static const _searchDebounceDuration = Duration(milliseconds: 450);

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(AllPatientsRefreshed(completer: completer));
    return completer.future;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    AllPatientsStarted event,
    Emitter<AllPatientsState> emit,
  ) async {
    emit(const AllPatientsLoading());
    _query = const PatientsListQuery();
    await _loadPage(emit, page: 1, replace: true);
  }

  Future<void> _onRefreshed(
    AllPatientsRefreshed event,
    Emitter<AllPatientsState> emit,
  ) async {
    try {
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
    } finally {
      if (!event.completer.isCompleted) {
        event.completer.complete();
      }
    }
  }

  Future<void> _onLoadMore(
    AllPatientsLoadMore event,
    Emitter<AllPatientsState> emit,
  ) async {
    final current = state;
    if (current is! AllPatientsLoaded) return;
    if (!current.hasMore || current.isLoadingMore || _isFetchingMore) return;

    final snapshot = _snapshot();
    _isFetchingMore = true;
    emit(current.copyWith(isLoadingMore: true));

    await _loadPage(
      emit,
      page: current.currentPage + 1,
      replace: false,
      keepOnError: snapshot,
    );
    _isFetchingMore = false;
  }

  void _onSearchChanged(
    AllPatientsSearchChanged event,
    Emitter<AllPatientsState> emit,
  ) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_searchDebounceDuration, () {
      add(AllPatientsSearchSubmitted(event.search));
    });
  }

  Future<void> _onSearchSubmitted(
    AllPatientsSearchSubmitted event,
    Emitter<AllPatientsState> emit,
  ) async {
    _searchDebounce?.cancel();
    _query = _query.copyWith(search: event.search, page: 1);
    await _reloadList(emit);
  }

  Future<void> _onFiltersApplied(
    AllPatientsFiltersApplied event,
    Emitter<AllPatientsState> emit,
  ) async {
    _searchDebounce?.cancel();

    if (event.resetAll) {
      _query = _query.resetFilters();
    } else {
      _query = _query.copyWith(
        clinic: event.clinic,
        receptionist: event.receptionist,
        dateFrom: event.fromDate,
        dateTo: event.toDate,
        perPage: event.perPage,
        clearClinic: event.clinic != null && event.clinic!.isEmpty,
        clearReceptionist:
            event.receptionist != null && event.receptionist!.isEmpty,
        clearDateFrom: event.clearFromDate,
        clearDateTo: event.clearToDate,
        page: 1,
      );
    }

    await _reloadList(emit);
  }

  Future<void> _reloadList(Emitter<AllPatientsState> emit) async {
    final current = state;
    if (current is AllPatientsLoaded) {
      emit(current.copyWith(isRefreshingList: true, query: _query));
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
      return;
    }

    emit(const AllPatientsLoading());
    await _loadPage(emit, page: 1, replace: true);
  }

  _ListSnapshot _snapshot() {
    final current = state;
    if (current is AllPatientsLoaded) {
      return _ListSnapshot(
        patients: current.patients,
        currentPage: current.currentPage,
        lastPage: current.lastPage,
        total: current.total,
        query: current.query,
      );
    }
    if (current is AllPatientsError) {
      return _ListSnapshot(
        patients: current.patients,
        currentPage: current.currentPage,
        lastPage: current.lastPage,
        total: current.total,
        query: current.query,
      );
    }
    return _ListSnapshot(query: _query);
  }

  List<String> _searchFields(PatientEntity row) => [
        row.name,
        row.id,
        row.cnic,
        ...row.problems,
        row.insurance,
        row.createdBy,
        row.receptionist,
        row.assistantManager,
        row.consultant,
        row.therapist,
      ];

  Future<void> _loadPage(
    Emitter<AllPatientsState> emit, {
    required int page,
    required bool replace,
    _ListSnapshot keepOnError = const _ListSnapshot(),
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

    final result = await getAllPatientsUseCase(fetchQuery);

    result.when(
      success: (pageData) {
        var merged = replace
            ? pageData.patients
            : AppSearchRanker.appendUnique(
                current: keepOnError.patients,
                extra: pageData.patients,
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
          AllPatientsLoaded(
            patients: merged,
            currentPage: pageData.currentPage,
            lastPage: pageData.lastPage,
            total: pageData.total,
            isLoadingMore: false,
            query: _query,
            isRefreshingList: false,
          ),
        );
      },
      failure: (failure) {
        emit(
          AllPatientsError(
            title: failure.title,
            message: failure.message,
            patients: keepOnError.patients,
            currentPage: keepOnError.currentPage,
            lastPage: keepOnError.lastPage,
            total: keepOnError.total,
            query: keepOnError.query,
          ),
        );
        if (keepOnError.patients.isNotEmpty) {
          emit(
            AllPatientsLoaded(
              patients: keepOnError.patients,
              currentPage: keepOnError.currentPage,
              lastPage: keepOnError.lastPage,
              total: keepOnError.total,
              isLoadingMore: false,
              query: keepOnError.query,
              isRefreshingList: false,
            ),
          );
        }
      },
    );
  }

  Future<void> _loadRankedFirstPage(
    Emitter<AllPatientsState> emit, {
    required _ListSnapshot keepOnError,
  }) async {
    final results = await Future.wait([
      getAllPatientsUseCase(_query),
      getAllPatientsUseCase(_query.copyWith(search: '', page: 1)),
    ]);
    final matchResult = results[0];
    final relatedResult = results[1];

    if (matchResult.isFailure && relatedResult.isFailure) {
      final failure = matchResult.failure;
      emit(
        AllPatientsError(
          title: failure.title,
          message: failure.message,
          patients: keepOnError.patients,
          currentPage: keepOnError.currentPage,
          lastPage: keepOnError.lastPage,
          total: keepOnError.total,
          query: keepOnError.query,
        ),
      );
      if (keepOnError.patients.isNotEmpty) {
        emit(
          AllPatientsLoaded(
            patients: keepOnError.patients,
            currentPage: keepOnError.currentPage,
            lastPage: keepOnError.lastPage,
            total: keepOnError.total,
            isLoadingMore: false,
            query: keepOnError.query,
            isRefreshingList: false,
          ),
        );
      }
      return;
    }

    final matches =
        matchResult.isSuccess ? matchResult.data.patients : <PatientEntity>[];
    final relatedPage = relatedResult.isSuccess ? relatedResult.data : null;
    final related = relatedPage?.patients ?? <PatientEntity>[];

    emit(
      AllPatientsLoaded(
        patients: AppSearchRanker.pinMatchesThenRelated(
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
        query: _query,
        isRefreshingList: false,
      ),
    );
  }
}

class _ListSnapshot {
  const _ListSnapshot({
    this.patients = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.query = const PatientsListQuery(),
  });

  final List<PatientEntity> patients;
  final int currentPage;
  final int lastPage;
  final int total;
  final PatientsListQuery query;
}
