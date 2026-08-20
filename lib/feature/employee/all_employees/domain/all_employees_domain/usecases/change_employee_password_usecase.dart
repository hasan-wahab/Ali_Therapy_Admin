import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/change_employee_password_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/repositories/all_employees_repository.dart';
import 'package:equatable/equatable.dart';

// ============================================================
// CHANGE EMPLOYEE PASSWORD USE CASE (Domain)
// ------------------------------------------------------------
// One job: POST /employees/{id}/change-password
// ============================================================

class ChangeEmployeePasswordUseCase
    extends UseCase<ChangeEmployeePasswordEntity, ChangeEmployeePasswordParams> {
  ChangeEmployeePasswordUseCase(this.repository);

  final AllEmployeesRepository repository;

  @override
  ResultFuture<ChangeEmployeePasswordEntity> call(
    ChangeEmployeePasswordParams params,
  ) =>
      repository.changeEmployeePassword(
        employeeId: params.employeeId,
        newPassword: params.newPassword,
        newPasswordConfirmation: params.newPasswordConfirmation,
      );
}

class ChangeEmployeePasswordParams extends Equatable {
  const ChangeEmployeePasswordParams({
    required this.employeeId,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  final String employeeId;
  final String newPassword;
  final String newPasswordConfirmation;

  @override
  List<Object?> get props => [
        employeeId,
        newPassword,
        newPasswordConfirmation,
      ];
}
