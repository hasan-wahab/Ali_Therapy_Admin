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

/// API success — list ready (supports append / load-more).
class AllEmployeesLoaded extends AllEmployeesState {
  final List<EmployeeEntity> employees;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool isLoadingMore;

  const AllEmployeesLoaded({
    required this.employees,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.isLoadingMore = false,
  });

  bool get hasMore => currentPage < lastPage;

  AllEmployeesLoaded copyWith({
    List<EmployeeEntity>? employees,
    int? currentPage,
    int? lastPage,
    int? total,
    bool? isLoadingMore,
  }) {
    return AllEmployeesLoaded(
      employees: employees ?? this.employees,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      total: total ?? this.total,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
        employees,
        currentPage,
        lastPage,
        total,
        isLoadingMore,
      ];
}

class AllEmployeesError extends AllEmployeesState {
  final String title;
  final String message;

  /// Keep showing this list when refresh / load-more fails.
  final List<EmployeeEntity> employees;
  final int currentPage;
  final int lastPage;
  final int total;

  const AllEmployeesError({
    required this.title,
    required this.message,
    this.employees = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
  });

  @override
  List<Object?> get props => [
        title,
        message,
        employees,
        currentPage,
        lastPage,
        total,
      ];
}
