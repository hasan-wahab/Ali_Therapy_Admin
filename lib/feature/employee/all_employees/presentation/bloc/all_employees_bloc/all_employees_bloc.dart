import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import '../../../domain/all_employees_domain/entities/employee_entity.dart';
import '../../../domain/all_employees_domain/usecases/get_all_employees_usecase.dart';

part 'all_employees_event.dart';
part 'all_employees_state.dart';

// ============================================================
// ALLEMPLOYEES BLOC
// ------------------------------------------------------------
// Started  → skeleton loading
// Refreshed → pull-to-refresh (list stays visible)
// ============================================================

class AllEmployeesBloc extends Bloc<AllEmployeesEvent, AllEmployeesState> {
  AllEmployeesBloc({required this.getAllEmployeesUseCase})
      : super(const AllEmployeesInitial()) {
    on<AllEmployeesStarted>(_onStarted);
    on<AllEmployeesRefreshed>(_onRefreshed);
  }

  final GetAllEmployeesUseCase getAllEmployeesUseCase;

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
    await _loadEmployees(emit);
  }

  Future<void> _onRefreshed(
    AllEmployeesRefreshed event,
    Emitter<AllEmployeesState> emit,
  ) async {
    try {
      await _loadEmployees(emit, keepEmployeesOnError: _currentEmployees());
    } finally {
      if (!event.completer.isCompleted) {
        event.completer.complete();
      }
    }
  }

  List<EmployeeEntity> _currentEmployees() {
    final current = state;
    if (current is AllEmployeesLoaded) return current.employees;
    if (current is AllEmployeesError) return current.employees;
    return const [];
  }

  Future<void> _loadEmployees(
    Emitter<AllEmployeesState> emit, {
    List<EmployeeEntity> keepEmployeesOnError = const [],
  }) async {
    final result = await getAllEmployeesUseCase(const NoParams());

    result.when(
      success: (employees) => emit(AllEmployeesLoaded(employees)),
      failure: (failure) => emit(
        AllEmployeesError(
          title: failure.title,
          message: failure.message,
          employees: keepEmployeesOnError,
        ),
      ),
    );
  }
}
