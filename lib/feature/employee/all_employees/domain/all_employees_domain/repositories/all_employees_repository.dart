import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employees_page_entity.dart';

import 'package:ali_therapy_admin/core/utils/typedefs.dart';

// ============================================================
// ALLEMPLOYEES REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class AllEmployeesRepository {
  /// Load one page of employees (Laravel ?page=).
  ResultFuture<EmployeesPageEntity> getEmployeesPage({required int page});
}
