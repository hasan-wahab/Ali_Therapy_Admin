part of 'all_employees_bloc.dart';

abstract class AllEmployeesState extends Equatable {
  const AllEmployeesState();

  @override
  List<Object?> get props => [];
}

class AllEmployeesInitial extends AllEmployeesState {
  const AllEmployeesInitial();
}

class AllEmployeesLoading extends AllEmployeesState {
  const AllEmployeesLoading();
}

/// API success — list is ready for UI.
class AllEmployeesLoaded extends AllEmployeesState {
  final List<EmployeeEntity> employees;

  const AllEmployeesLoaded(this.employees);

  @override
  List<Object?> get props => [employees];
}

class AllEmployeesError extends AllEmployeesState {
  final String title;
  final String message;

  /// Keep showing this list when pull-refresh fails.
  final List<EmployeeEntity> employees;

  const AllEmployeesError({
    required this.title,
    required this.message,
    this.employees = const [],
  });

  @override
  List<Object?> get props => [title, message, employees];
}
