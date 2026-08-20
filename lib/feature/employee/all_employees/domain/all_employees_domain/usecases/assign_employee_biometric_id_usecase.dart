import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/assign_employee_biometric_id_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/repositories/all_employees_repository.dart';
import 'package:equatable/equatable.dart';

// ============================================================
// ASSIGN EMPLOYEE BIOMETRIC ID USE CASE (Domain)
// ------------------------------------------------------------
// One job: POST /employees/{id}/assign-biometric-id
// ============================================================

class AssignEmployeeBiometricIdUseCase
    extends UseCase<AssignEmployeeBiometricIdEntity,
        AssignEmployeeBiometricIdParams> {
  AssignEmployeeBiometricIdUseCase(this.repository);

  final AllEmployeesRepository repository;

  @override
  ResultFuture<AssignEmployeeBiometricIdEntity> call(
    AssignEmployeeBiometricIdParams params,
  ) =>
      repository.assignEmployeeBiometricId(
        employeeId: params.employeeId,
        biometricId: params.biometricId,
      );
}

class AssignEmployeeBiometricIdParams extends Equatable {
  const AssignEmployeeBiometricIdParams({
    required this.employeeId,
    required this.biometricId,
  });

  final String employeeId;
  final String biometricId;

  @override
  List<Object?> get props => [employeeId, biometricId];
}
