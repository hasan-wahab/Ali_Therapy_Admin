import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/all_employees_domain/entities/employee_entity.dart';
import '../../../domain/all_employees_domain/usecases/get_all_employees_usecase.dart';

part 'all_employees_event.dart';
part 'all_employees_state.dart';

// ============================================================
// ALLEMPLOYEES BLOC
// ------------------------------------------------------------
// Started   → page 1 + skeleton
// Refreshed → page 1 replace (pull refresh)
// LoadMore  → next page append
// ============================================================

class AllEmployeesBloc extends Bloc<AllEmployeesEvent, AllEmployeesState> {
  AllEmployeesBloc({required this.getAllEmployeesUseCase})
    : super(const AllEmployeesInitial()) {
    on<AllEmployeesStarted>(_onStarted);
    on<AllEmployeesRefreshed>(_onRefreshed);
    on<AllEmployeesLoadMore>(_onLoadMore);
  }

  final GetAllEmployeesUseCase getAllEmployeesUseCase;

  /// Guard so LoadMore is not fired twice for the same page.
  bool _isFetchingMore = false;

  /// Call from UI: AppPullRefresh(onRefresh: () => bloc.pullRefresh())
  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(AllEmployeesRefreshed(completer: completer));
    return completer.future;
  }

  Future<void> _onStarted(
    AllEmployeesStarted event,
    Emitter<AllEmployeesState> emit,
  ) async {
    emit(const AllEmployeesLoading());
    await _loadPage(emit, page: 1, replace: true);
  }

  Future<void> _onRefreshed(
    AllEmployeesRefreshed event,
    Emitter<AllEmployeesState> emit,
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
    AllEmployeesLoadMore event,
    Emitter<AllEmployeesState> emit,
  ) async {
    final current = state;
    if (current is! AllEmployeesLoaded) return;
    if (!current.hasMore || current.isLoadingMore || _isFetchingMore) return;

    final snapshot = _snapshot();
    _isFetchingMore = true;
    emit(current.copyWith(isLoadingMore: true));

    final nextPage = current.currentPage + 1;
    await _loadPage(
      emit,
      page: nextPage,
      replace: false,
      keepOnError: snapshot,
    );
    _isFetchingMore = false;
  }

  _ListSnapshot _snapshot() {
    final current = state;
    if (current is AllEmployeesLoaded) {
      return _ListSnapshot(
        employees: current.employees,
        currentPage: current.currentPage,
        lastPage: current.lastPage,
        total: current.total,
      );
    }
    if (current is AllEmployeesError) {
      return _ListSnapshot(
        employees: current.employees,
        currentPage: current.currentPage,
        lastPage: current.lastPage,
        total: current.total,
      );
    }
    return const _ListSnapshot();
  }

  Future<void> _loadPage(
    Emitter<AllEmployeesState> emit, {
    required int page,
    required bool replace,
    _ListSnapshot keepOnError = const _ListSnapshot(),
  }) async {
    final result = await getAllEmployeesUseCase(
      GetEmployeesPageParams(page: page),
    );

    result.when(
      success: (pageData) {
        final merged = replace
            ? pageData.employees
            : [...keepOnError.employees, ...pageData.employees];

        emit(
          AllEmployeesLoaded(
            employees: merged,
            currentPage: pageData.currentPage,
            lastPage: pageData.lastPage,
            total: pageData.total,
            isLoadingMore: false,
          ),
        );
      },
      failure: (failure) {
        // Always notify UI with Error (snackbar), then restore Loaded
        // so scroll / load-more can continue when we already have a list.
        emit(
          AllEmployeesError(
            title: failure.title,
            message: failure.message,
            employees: keepOnError.employees,
            currentPage: keepOnError.currentPage,
            lastPage: keepOnError.lastPage,
            total: keepOnError.total,
          ),
        );
        if (keepOnError.employees.isNotEmpty) {
          emit(
            AllEmployeesLoaded(
              employees: keepOnError.employees,
              currentPage: keepOnError.currentPage,
              lastPage: keepOnError.lastPage,
              total: keepOnError.total,
              isLoadingMore: false,
            ),
          );
        }
      },
    );
  }
}

class _ListSnapshot {
  const _ListSnapshot({
    this.employees = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
  });

  final List<EmployeeEntity> employees;
  final int currentPage;
  final int lastPage;
  final int total;
}
