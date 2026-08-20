import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/assign_employee_biometric_id_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/assign_employee_device_id_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/change_employee_password_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employees_filters_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employees_list_query.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employees_page_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/terminate_employee_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/toggle_status_entity.dart';

import 'package:ali_therapy_admin/core/utils/typedefs.dart';

// ============================================================
// ALLEMPLOYEES REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class AllEmployeesRepository {
  /// Load one page of employees (search + filters + page).
  ResultFuture<EmployeesPageEntity> getEmployeesPage({
    required EmployeesListQuery query,
  });

  /// Load filter dropdown lists for All Employees.
  ResultFuture<EmployeesFiltersEntity> getEmployeesFilters();

  /// Toggle employee active / inactive status.
  ResultFuture<ToggleStatusEntity> toggleEmployeeStatus({
    required String employeeId,
    required bool newStatus,
  });

  /// Terminate one employee (reason + optional date).
  ResultFuture<TerminateEmployeeEntity> terminateEmployee({
    required String employeeId,
    required String reason,
    required String date,
  });

  /// Change one employee's password.
  ResultFuture<ChangeEmployeePasswordEntity> changeEmployeePassword({
    required String employeeId,
    required String newPassword,
    required String newPasswordConfirmation,
  });

  /// Assign a numeric device ID to one employee.
  ResultFuture<AssignEmployeeDeviceIdEntity> assignEmployeeDeviceId({
    required String employeeId,
    required int deviceId,
  });

  /// Assign a biometric ID to one employee.
  ResultFuture<AssignEmployeeBiometricIdEntity> assignEmployeeBiometricId({
    required String employeeId,
    required String biometricId,
  });
}
