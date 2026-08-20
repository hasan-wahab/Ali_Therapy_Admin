import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/assign_employee_biometric_id_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/assign_employee_device_id_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/change_employee_password_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/employees_filters_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/employees_page_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/terminate_employee_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/toggle_status_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employees_list_query.dart';

// ============================================================
// ALLEMPLOYEES REMOTE DATA SOURCE (contract)
// ------------------------------------------------------------
// API only — no business rules here.
// ============================================================

abstract class AllEmployeesRemoteDataSource {
  /// GET employees-list?... (search + filters + page)
  Future<EmployeesPageModel> getEmployeesPage({
    required EmployeesListQuery query,
  });

  /// GET employees-filters-data
  Future<EmployeesFiltersModel> getEmployeesFilters();

  /// POST /employees/{id}/toggle-status
  Future<ToggleStatusModel> toggleEmployeeStatus({
    required String employeeId,
    required bool newStatus,
  });

  /// POST /employees/{id}/terminate
  Future<TerminateEmployeeModel> terminateEmployee({
    required String employeeId,
    required String reason,
    required String date,
  });

  /// POST /employees/{id}/change-password
  Future<ChangeEmployeePasswordModel> changeEmployeePassword({
    required String employeeId,
    required String newPassword,
    required String newPasswordConfirmation,
  });

  /// POST /employees/{id}/assign-device-id
  Future<AssignEmployeeDeviceIdModel> assignEmployeeDeviceId({
    required String employeeId,
    required int deviceId,
  });

  /// POST /employees/{id}/assign-biometric-id
  Future<AssignEmployeeBiometricIdModel> assignEmployeeBiometricId({
    required String employeeId,
    required String biometricId,
  });
}
