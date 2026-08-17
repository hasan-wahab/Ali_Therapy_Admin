import 'package:equatable/equatable.dart';

import 'employee_entity.dart';

// ============================================================
// EMPLOYEES PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page from employees-list API.
// ============================================================

class EmployeesPageEntity extends Equatable {
  final List<EmployeeEntity> employees;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const EmployeesPageEntity({
    required this.employees,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [employees, currentPage, lastPage, perPage, total];
}
