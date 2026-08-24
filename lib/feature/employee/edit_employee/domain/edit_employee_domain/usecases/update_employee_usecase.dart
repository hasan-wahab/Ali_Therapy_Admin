import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_form_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_options_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/update_employee_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/repositories/edit_employee_repository.dart';
import 'package:equatable/equatable.dart';

// ============================================================
// UPDATE EMPLOYEE USE CASE (Domain)
// ------------------------------------------------------------
// One job: POST /employees/update/{id}
// ============================================================

class UpdateEmployeeUseCase
    extends UseCase<UpdateEmployeeEntity, UpdateEmployeeParams> {
  UpdateEmployeeUseCase(this.repository);

  final EditEmployeeRepository repository;

  @override
  ResultFuture<UpdateEmployeeEntity> call(UpdateEmployeeParams params) {
    return repository.updateEmployee(
      employeeId: params.employeeId,
      form: params.form,
      options: params.options,
    );
  }
}

class UpdateEmployeeParams extends Equatable {
  const UpdateEmployeeParams({
    required this.employeeId,
    required this.form,
    required this.options,
  });

  final String employeeId;
  final EditEmployeeFormEntity form;
  final EditEmployeeOptionsEntity options;

  @override
  List<Object?> get props => [employeeId, form, options];
}
