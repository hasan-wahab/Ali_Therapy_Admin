import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/employees_page_model.dart';

// ============================================================
// ALLEMPLOYEES REMOTE DATA SOURCE (contract)
// ------------------------------------------------------------
// API only — no business rules here.
// ============================================================

abstract class AllEmployeesRemoteDataSource {
  /// GET employees-list?page=N
  Future<EmployeesPageModel> getEmployeesPage({required int page});
}
