import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/employee_entity.dart';

// ============================================================
// ALLEMPLOYEES REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class AllEmployeesRepository {
  /// Load all employees from API.
  ResultFuture<List<EmployeeEntity>> getAllEmployees();
}
