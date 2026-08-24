import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/delete_employee_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/repositories/all_employees_repository.dart';
import 'package:equatable/equatable.dart';

// ============================================================
// DELETE EMPLOYEE USE CASE (Domain)
// ------------------------------------------------------------
// One job: DELETE /employees/{id}
// ============================================================

class DeleteEmployeeUseCase
    extends UseCase<DeleteEmployeeEntity, DeleteEmployeeParams> {
  DeleteEmployeeUseCase(this.repository);

  final AllEmployeesRepository repository;

  @override
  ResultFuture<DeleteEmployeeEntity> call(DeleteEmployeeParams params) =>
      repository.deleteEmployee(employeeId: params.employeeId);
}

class DeleteEmployeeParams extends Equatable {
  const DeleteEmployeeParams({required this.employeeId});

  final String employeeId;

  @override
  List<Object?> get props => [employeeId];
}
