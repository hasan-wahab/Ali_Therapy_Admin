import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';

import '../../../domain/all_employees_domain/entities/employee_entity.dart';
import '../../../domain/all_employees_domain/entities/employees_filters_entity.dart';
import '../../../domain/all_employees_domain/entities/employees_list_query.dart';
import '../../../domain/all_employees_domain/usecases/assign_employee_biometric_id_usecase.dart';
import '../../../domain/all_employees_domain/usecases/assign_employee_device_id_usecase.dart';
import '../../../domain/all_employees_domain/usecases/change_employee_password_usecase.dart';
import '../../../domain/all_employees_domain/usecases/get_all_employees_usecase.dart';
import '../../../domain/all_employees_domain/usecases/get_employees_filters_usecase.dart';
import '../../../domain/all_employees_domain/usecases/terminate_employee_usecase.dart';
import '../../../domain/all_employees_domain/usecases/toggle_employee_status_usecase.dart';

part 'all_employees_event.dart';
part 'all_employees_state.dart';

// ============================================================
// ALLEMPLOYEES BLOC
// ------------------------------------------------------------
// Started        → filters meta + page 1 (default status=1)
// SearchChanged  → debounce → page 1 with search + current filters
// FiltersApplied → immediate page 1 with new filter ids
// LoadMore       → next page, same query
// ============================================================

class AllEmployeesBloc extends Bloc<AllEmployeesEvent, AllEmployeesState> {
  AllEmployeesBloc({
    required this.getAllEmployeesUseCase,
    required this.getEmployeesFiltersUseCase,
    required this.toggleEmployeeStatusUseCase,
    required this.terminateEmployeeUseCase,
    required this.changeEmployeePasswordUseCase,
    required this.assignEmployeeDeviceIdUseCase,
    required this.assignEmployeeBiometricIdUseCase,
  }) : super(const AllEmployeesInitial()) {
    on<AllEmployeesStarted>(_onStarted);
    on<AllEmployeesRefreshed>(_onRefreshed);
    on<AllEmployeesLoadMore>(_onLoadMore);
    on<AllEmployeesSearchChanged>(_onSearchChanged);
    on<AllEmployeesSearchSubmitted>(_onSearchSubmitted);
    on<AllEmployeesFiltersApplied>(_onFiltersApplied);
    on<AllEmployeesStatusToggled>(_onStatusToggled);
    on<AllEmployeesTerminated>(_onTerminated);
    on<AllEmployeesPasswordChanged>(_onPasswordChanged);
    on<AllEmployeesDeviceIdAssigned>(_onDeviceIdAssigned);
    on<AllEmployeesBiometricIdAssigned>(_onBiometricIdAssigned);
  }

  final GetAllEmployeesUseCase getAllEmployeesUseCase;
  final GetEmployeesFiltersUseCase getEmployeesFiltersUseCase;
  final ToggleEmployeeStatusUseCase toggleEmployeeStatusUseCase;
  final TerminateEmployeeUseCase terminateEmployeeUseCase;
  final ChangeEmployeePasswordUseCase changeEmployeePasswordUseCase;
  final AssignEmployeeDeviceIdUseCase assignEmployeeDeviceIdUseCase;
  final AssignEmployeeBiometricIdUseCase assignEmployeeBiometricIdUseCase;

  bool _isFetchingMore = false;

  EmployeesFiltersEntity _filtersMeta = const EmployeesFiltersEntity.empty();

  /// Current list query (search + filters + page).
  EmployeesListQuery _query = const EmployeesListQuery();

  Timer? _searchDebounce;

  static const _searchDebounceDuration = Duration(milliseconds: 450);

  Future<void> pullRefresh() {
    final completer = Completer<void>();
    add(AllEmployeesRefreshed(completer: completer));
    return completer.future;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    AllEmployeesStarted event,
    Emitter<AllEmployeesState> emit,
  ) async {
    emit(const AllEmployeesLoading());
    _query = const EmployeesListQuery(); // status=all, per_page=50
    await _loadFiltersMeta();
    await _loadPage(emit, page: 1, replace: true);
  }

  Future<void> _onRefreshed(
    AllEmployeesRefreshed event,
    Emitter<AllEmployeesState> emit,
  ) async {
    try {
      await _loadFiltersMeta();
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

  void _onSearchChanged(
    AllEmployeesSearchChanged event,
    Emitter<AllEmployeesState> emit,
  ) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_searchDebounceDuration, () {
      add(AllEmployeesSearchSubmitted(event.search));
    });
  }

  Future<void> _onSearchSubmitted(
    AllEmployeesSearchSubmitted event,
    Emitter<AllEmployeesState> emit,
  ) async {
    _searchDebounce?.cancel();
    _query = _query.copyWith(search: event.search, page: 1);
    await _reloadList(emit);
  }

  Future<void> _onFiltersApplied(
    AllEmployeesFiltersApplied event,
    Emitter<AllEmployeesState> emit,
  ) async {
    // Cancel pending search debounce so filter wins immediately.
    _searchDebounce?.cancel();

    if (event.resetAll) {
      _query = _query.resetFilters();
    } else {
      _query = _query.copyWith(
        status: event.status,
        clinicId: event.clinicId,
        departmentId: event.departmentId,
        designationId: event.designationId,
        shiftId: event.shiftId,
        roleId: event.roleId,
        perPage: event.perPage,
        clearClinicId: event.clearClinicId,
        clearDepartmentId: event.clearDepartmentId,
        clearDesignationId: event.clearDesignationId,
        clearShiftId: event.clearShiftId,
        clearRoleId: event.clearRoleId,
        page: 1,
      );
    }

    await _reloadList(emit);
  }

  Future<void> _onStatusToggled(
    AllEmployeesStatusToggled event,
    Emitter<AllEmployeesState> emit,
  ) async {
    final current = state;
    if (current is! AllEmployeesLoaded) return;

    // Optimistic: update list immediately + mark card as toggling.
    final optimisticList = current.employees.map((e) {
      if (e.id == event.employeeId) {
        return EmployeeEntity(
          id: e.id,
          imageUrl: e.imageUrl,
          name: e.name,
          email: e.email,
          phone: e.phone,
          cnic: e.cnic,
          employeeId: e.employeeId,
          joinedDate: e.joinedDate,
          tenure: e.tenure,
          roles: e.roles,
          shift: e.shift,
          isActive: event.newStatus,
          createdBy: e.createdBy,
        );
      }
      return e;
    }).toList();

    emit(
      current.copyWith(
        employees: optimisticList,
        togglingEmployeeId: event.employeeId,
      ),
    );

    final result = await toggleEmployeeStatusUseCase(
      ToggleEmployeeStatusParams(
        employeeId: event.employeeId,
        newStatus: event.newStatus,
      ),
    );

    result.when(
      success: (data) {
        // Confirm optimistic update with API response.
        final confirmedList = (state is AllEmployeesLoaded
                ? (state as AllEmployeesLoaded).employees
                : optimisticList)
            .map((e) {
          if (e.id == data.id) {
            return EmployeeEntity(
              id: e.id,
              imageUrl: e.imageUrl,
              name: e.name,
              email: e.email,
              phone: e.phone,
              cnic: e.cnic,
              employeeId: e.employeeId,
              joinedDate: e.joinedDate,
              tenure: e.tenure,
              roles: e.roles,
              shift: e.shift,
              isActive: data.isActive,
              createdBy: e.createdBy,
            );
          }
          return e;
        }).toList();

        if (state is AllEmployeesLoaded) {
          emit(
            (state as AllEmployeesLoaded).copyWith(
              employees: confirmedList,
              togglingEmployeeId: null,
            ),
          );
        }
      },
      failure: (failure) {
        // Revert optimistic change on failure.
        final revertedList = optimisticList.map((e) {
          if (e.id == event.employeeId) {
            return EmployeeEntity(
              id: e.id,
              imageUrl: e.imageUrl,
              name: e.name,
              email: e.email,
              phone: e.phone,
              cnic: e.cnic,
              employeeId: e.employeeId,
              joinedDate: e.joinedDate,
              tenure: e.tenure,
              roles: e.roles,
              shift: e.shift,
              isActive: !event.newStatus, // revert
              createdBy: e.createdBy,
            );
          }
          return e;
        }).toList();

        if (state is AllEmployeesLoaded) {
          emit(
            (state as AllEmployeesLoaded).copyWith(
              employees: revertedList,
              togglingEmployeeId: null,
            ),
          );
        }

        emit(
          AllEmployeesError(
            title: failure.title,
            message: failure.message,
            employees: revertedList,
            currentPage: current.currentPage,
            lastPage: current.lastPage,
            total: current.total,
            filters: current.filters,
            query: current.query,
          ),
        );
        if (state is! AllEmployeesLoaded) {
          emit(
            current.copyWith(
              employees: revertedList,
              togglingEmployeeId: null,
            ),
          );
        }
      },
    );
  }

  Future<void> _onTerminated(
    AllEmployeesTerminated event,
    Emitter<AllEmployeesState> emit,
  ) async {
    final current = state;
    if (current is! AllEmployeesLoaded) return;
    if (current.terminatingEmployeeId != null) return;

    emit(
      current.copyWith(
        terminatingEmployeeId: event.employeeId,
        successMessage: null,
      ),
    );

    final result = await terminateEmployeeUseCase(
      TerminateEmployeeParams(
        employeeId: event.employeeId,
        reason: event.reason,
        date: event.date,
      ),
    );

    await result.when(
      success: (data) async {
        await _loadPage(
          emit,
          page: 1,
          replace: true,
          keepOnError: _snapshot(),
        );
        final after = state;
        if (after is AllEmployeesLoaded) {
          emit(
            after.copyWith(
              terminatingEmployeeId: null,
              successMessage: data.message,
            ),
          );
        }
      },
      failure: (failure) async {
        emit(
          AllEmployeesError(
            title: failure.title,
            message: failure.message,
            employees: current.employees,
            currentPage: current.currentPage,
            lastPage: current.lastPage,
            total: current.total,
            filters: current.filters,
            query: current.query,
          ),
        );
        emit(
          current.copyWith(
            terminatingEmployeeId: null,
            successMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _onPasswordChanged(
    AllEmployeesPasswordChanged event,
    Emitter<AllEmployeesState> emit,
  ) async {
    final current = state;
    if (current is! AllEmployeesLoaded) return;
    if (current.changingPasswordEmployeeId != null) return;

    emit(
      current.copyWith(
        changingPasswordEmployeeId: event.employeeId,
        successMessage: null,
      ),
    );

    final result = await changeEmployeePasswordUseCase(
      ChangeEmployeePasswordParams(
        employeeId: event.employeeId,
        newPassword: event.newPassword,
        newPasswordConfirmation: event.newPasswordConfirmation,
      ),
    );

    result.when(
      success: (data) {
        final after = state;
        if (after is AllEmployeesLoaded) {
          emit(
            after.copyWith(
              changingPasswordEmployeeId: null,
              successMessage: data.message,
            ),
          );
        }
      },
      failure: (failure) {
        emit(
          AllEmployeesError(
            title: failure.title,
            message: failure.message,
            employees: current.employees,
            currentPage: current.currentPage,
            lastPage: current.lastPage,
            total: current.total,
            filters: current.filters,
            query: current.query,
          ),
        );
        emit(
          current.copyWith(
            changingPasswordEmployeeId: null,
            successMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _onDeviceIdAssigned(
    AllEmployeesDeviceIdAssigned event,
    Emitter<AllEmployeesState> emit,
  ) async {
    final current = state;
    if (current is! AllEmployeesLoaded) return;
    if (current.assigningDeviceEmployeeId != null) return;

    emit(
      current.copyWith(
        assigningDeviceEmployeeId: event.employeeId,
        successMessage: null,
      ),
    );

    final result = await assignEmployeeDeviceIdUseCase(
      AssignEmployeeDeviceIdParams(
        employeeId: event.employeeId,
        deviceId: event.deviceId,
      ),
    );

    result.when(
      success: (data) {
        final after = state;
        if (after is AllEmployeesLoaded) {
          emit(
            after.copyWith(
              assigningDeviceEmployeeId: null,
              successMessage: data.message,
            ),
          );
        }
      },
      failure: (failure) {
        emit(
          AllEmployeesError(
            title: failure.title,
            message: failure.message,
            employees: current.employees,
            currentPage: current.currentPage,
            lastPage: current.lastPage,
            total: current.total,
            filters: current.filters,
            query: current.query,
          ),
        );
        emit(
          current.copyWith(
            assigningDeviceEmployeeId: null,
            successMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _onBiometricIdAssigned(
    AllEmployeesBiometricIdAssigned event,
    Emitter<AllEmployeesState> emit,
  ) async {
    final current = state;
    if (current is! AllEmployeesLoaded) return;
    if (current.assigningBiometricEmployeeId != null) return;

    emit(
      current.copyWith(
        assigningBiometricEmployeeId: event.employeeId,
        successMessage: null,
      ),
    );

    final result = await assignEmployeeBiometricIdUseCase(
      AssignEmployeeBiometricIdParams(
        employeeId: event.employeeId,
        biometricId: event.biometricId,
      ),
    );

    result.when(
      success: (data) {
        final after = state;
        if (after is AllEmployeesLoaded) {
          emit(
            after.copyWith(
              assigningBiometricEmployeeId: null,
              successMessage: data.message,
            ),
          );
        }
      },
      failure: (failure) {
        emit(
          AllEmployeesError(
            title: failure.title,
            message: failure.message,
            employees: current.employees,
            currentPage: current.currentPage,
            lastPage: current.lastPage,
            total: current.total,
            filters: current.filters,
            query: current.query,
          ),
        );
        emit(
          current.copyWith(
            assigningBiometricEmployeeId: null,
            successMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _reloadList(Emitter<AllEmployeesState> emit) async {
    final current = state;
    if (current is AllEmployeesLoaded) {
      emit(current.copyWith(isRefreshingList: true, query: _query));
      await _loadPage(emit, page: 1, replace: true, keepOnError: _snapshot());
      return;
    }

    emit(const AllEmployeesLoading());
    await _loadPage(emit, page: 1, replace: true);
  }

  Future<void> _loadFiltersMeta() async {
    final result = await getEmployeesFiltersUseCase(const NoParams());
    result.when(
      success: (filters) => _filtersMeta = filters,
      failure: (_) {},
    );
  }

  _ListSnapshot _snapshot() {
    final current = state;
    if (current is AllEmployeesLoaded) {
      return _ListSnapshot(
        employees: current.employees,
        currentPage: current.currentPage,
        lastPage: current.lastPage,
        total: current.total,
        filters: current.filters,
        query: current.query,
      );
    }
    if (current is AllEmployeesError) {
      return _ListSnapshot(
        employees: current.employees,
        currentPage: current.currentPage,
        lastPage: current.lastPage,
        total: current.total,
        filters: current.filters,
        query: current.query,
      );
    }
    return _ListSnapshot(filters: _filtersMeta, query: _query);
  }

  List<String> _searchFields(EmployeeEntity row) => [
        row.name,
        row.email,
        row.phone,
        row.cnic,
        row.employeeId,
        ...row.roles,
        row.shift,
        row.createdBy,
      ];

  Future<void> _loadPage(
    Emitter<AllEmployeesState> emit, {
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

    final result = await getAllEmployeesUseCase(fetchQuery);

    result.when(
      success: (pageData) {
        var merged = replace
            ? pageData.employees
            : AppSearchRanker.appendUnique(
                current: keepOnError.employees,
                extra: pageData.employees,
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
          AllEmployeesLoaded(
            employees: merged,
            currentPage: pageData.currentPage,
            lastPage: pageData.lastPage,
            total: pageData.total,
            isLoadingMore: false,
            filters: _filtersMeta,
            query: _query,
            isRefreshingList: false,
          ),
        );
      },
      failure: (failure) {
        final filters = keepOnError.filters.roles.isNotEmpty ||
                keepOnError.filters.statuses.isNotEmpty
            ? keepOnError.filters
            : _filtersMeta;

        emit(
          AllEmployeesError(
            title: failure.title,
            message: failure.message,
            employees: keepOnError.employees,
            currentPage: keepOnError.currentPage,
            lastPage: keepOnError.lastPage,
            total: keepOnError.total,
            filters: filters,
            query: keepOnError.query,
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
              filters: filters,
              query: keepOnError.query,
              isRefreshingList: false,
            ),
          );
        }
      },
    );
  }

  Future<void> _loadRankedFirstPage(
    Emitter<AllEmployeesState> emit, {
    required _ListSnapshot keepOnError,
  }) async {
    final results = await Future.wait([
      getAllEmployeesUseCase(_query),
      getAllEmployeesUseCase(_query.copyWith(search: '', page: 1)),
    ]);
    final matchResult = results[0];
    final relatedResult = results[1];
    final filters = keepOnError.filters.roles.isNotEmpty ||
            keepOnError.filters.statuses.isNotEmpty
        ? keepOnError.filters
        : _filtersMeta;

    if (matchResult.isFailure && relatedResult.isFailure) {
      final failure = matchResult.failure;
      emit(
        AllEmployeesError(
          title: failure.title,
          message: failure.message,
          employees: keepOnError.employees,
          currentPage: keepOnError.currentPage,
          lastPage: keepOnError.lastPage,
          total: keepOnError.total,
          filters: filters,
          query: keepOnError.query,
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
            filters: filters,
            query: keepOnError.query,
            isRefreshingList: false,
          ),
        );
      }
      return;
    }

    final matches = matchResult.isSuccess
        ? matchResult.data.employees
        : <EmployeeEntity>[];
    final relatedPage = relatedResult.isSuccess ? relatedResult.data : null;
    final related = relatedPage?.employees ?? <EmployeeEntity>[];

    emit(
      AllEmployeesLoaded(
        employees: AppSearchRanker.pinMatchesThenRelated(
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
        filters: _filtersMeta,
        query: _query,
        isRefreshingList: false,
      ),
    );
  }
}

class _ListSnapshot {
  const _ListSnapshot({
    this.employees = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.filters = const EmployeesFiltersEntity.empty(),
    this.query = const EmployeesListQuery(),
  });

  final List<EmployeeEntity> employees;
  final int currentPage;
  final int lastPage;
  final int total;
  final EmployeesFiltersEntity filters;
  final EmployeesListQuery query;
}
