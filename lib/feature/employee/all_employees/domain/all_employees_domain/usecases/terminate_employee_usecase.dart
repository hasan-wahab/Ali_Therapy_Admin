import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/terminate_employee_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/repositories/all_employees_repository.dart';
import 'package:equatable/equatable.dart';

// ============================================================
// TERMINATE EMPLOYEE USE CASE (Domain)
// ------------------------------------------------------------
// One job: POST /employees/{id}/terminate
// ============================================================

class TerminateEmployeeUseCase
    extends UseCase<TerminateEmployeeEntity, TerminateEmployeeParams> {
  TerminateEmployeeUseCase(this.repository);

  final AllEmployeesRepository repository;

  @override
  ResultFuture<TerminateEmployeeEntity> call(
    TerminateEmployeeParams params,
  ) =>
      repository.terminateEmployee(
        employeeId: params.employeeId,
        reason: params.reason,
        date: params.date,
      );
}

class TerminateEmployeeParams extends Equatable {
  const TerminateEmployeeParams({
    required this.employeeId,
    required this.reason,
    required this.date,
  });

  final String employeeId;
  final String reason;

  /// API date as yyyy-MM-dd, or empty string.
  final String date;

  @override
  List<Object?> get props => [employeeId, reason, date];
}
