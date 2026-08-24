import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/repositories/edit_employee_repository.dart';
import 'package:equatable/equatable.dart';

// ============================================================
// GET EDIT EMPLOYEE USE CASE (Domain)
// ------------------------------------------------------------
// One job: load employee + dropdowns for the edit form.
// ============================================================

class GetEditEmployeeUseCase
    extends UseCase<EditEmployeeEntity, GetEditEmployeeParams> {
  GetEditEmployeeUseCase(this.repository);

  final EditEmployeeRepository repository;

  @override
  ResultFuture<EditEmployeeEntity> call(GetEditEmployeeParams params) {
    return repository.getEditEmployee(employeeId: params.employeeId);
  }
}

class GetEditEmployeeParams extends Equatable {
  const GetEditEmployeeParams({required this.employeeId});

  final String employeeId;

  @override
  List<Object?> get props => [employeeId];
}
