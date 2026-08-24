import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_form_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_options_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/update_employee_entity.dart';

// ============================================================
// EDIT EMPLOYEE REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class EditEmployeeRepository {
  /// GET employees/{id}/edit (falls back to show).
  ResultFuture<EditEmployeeEntity> getEditEmployee({
    required String employeeId,
  });

  /// POST employees/update/{id}
  ResultFuture<UpdateEmployeeEntity> updateEmployee({
    required String employeeId,
    required EditEmployeeFormEntity form,
    required EditEmployeeOptionsEntity options,
  });
}
