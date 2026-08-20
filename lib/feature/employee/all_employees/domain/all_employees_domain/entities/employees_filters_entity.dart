import 'package:equatable/equatable.dart';

import 'employee_filter_option_entity.dart';

// ============================================================
// EMPLOYEES FILTERS ENTITY (Domain)
// ------------------------------------------------------------
// Filter dropdown lists for All Employees screen:
// roles, designations, clinics, departments, shifts, statuses.
// ============================================================

class EmployeesFiltersEntity extends Equatable {
  final List<EmployeeFilterOptionEntity> roles;
  final List<EmployeeFilterOptionEntity> designations;
  final List<EmployeeFilterOptionEntity> clinics;
  final List<EmployeeFilterOptionEntity> departments;
  final List<EmployeeFilterOptionEntity> shifts;
  final List<EmployeeFilterOptionEntity> statuses;

  const EmployeesFiltersEntity({
    required this.roles,
    required this.designations,
    required this.clinics,
    required this.departments,
    required this.shifts,
    required this.statuses,
  });

  /// Empty lists — useful before API loads.
  const EmployeesFiltersEntity.empty()
      : roles = const [],
        designations = const [],
        clinics = const [],
        departments = const [],
        shifts = const [],
        statuses = const [];

  @override
  List<Object?> get props => [
        roles,
        designations,
        clinics,
        departments,
        shifts,
        statuses,
      ];
}
