import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/edit_employee_entity.dart';

// ============================================================
// EDITEMPLOYEE REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class EditEmployeeRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<EditEmployeeEntity> getEditEmployee();
}
