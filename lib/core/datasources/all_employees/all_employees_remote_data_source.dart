import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/employee_model.dart';

// ============================================================
// ALLEMPLOYEES REMOTE DATA SOURCE (contract)
// ------------------------------------------------------------
// Lives in core/datasources/all_employees/
// Talks to the API. Throws AppException on errors.
// ============================================================

abstract class AllEmployeesRemoteDataSource {
  /// GET employees-list.
  /// Bearer token is attached by ApiInterceptor.
  Future<List<EmployeeModel>> getAllEmployees();
}
