import 'package:ali_therapy_admin/feature/employee/edit_employee/data/edit_employee_data/models/edit_employee_model.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/data/edit_employee_data/models/update_employee_model.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_form_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_options_entity.dart';

// ============================================================
// EDIT EMPLOYEE REMOTE DATA SOURCE (contract)
// ============================================================

abstract class EditEmployeeRemoteDataSource {
  /// GET employees/{id} (same payload as View). Falls back to /edit.
  Future<EditEmployeeModel> getEditEmployee({
    required String employeeId,
  });

  /// POST /employees/update/{id}
  Future<UpdateEmployeeModel> updateEmployee({
    required String employeeId,
    required EditEmployeeFormEntity form,
    required EditEmployeeOptionsEntity options,
  });
}
