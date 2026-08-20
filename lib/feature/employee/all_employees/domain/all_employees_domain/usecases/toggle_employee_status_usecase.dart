import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/toggle_status_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/repositories/all_employees_repository.dart';
import 'package:equatable/equatable.dart';

// ============================================================
// TOGGLE EMPLOYEE STATUS USE CASE (Domain)
// ------------------------------------------------------------
// One job: POST /employees/{id}/toggle-status
// ============================================================

class ToggleEmployeeStatusUseCase
    extends UseCase<ToggleStatusEntity, ToggleEmployeeStatusParams> {
  ToggleEmployeeStatusUseCase(this.repository);

  final AllEmployeesRepository repository;

  @override
  ResultFuture<ToggleStatusEntity> call(
    ToggleEmployeeStatusParams params,
  ) =>
      repository.toggleEmployeeStatus(
        employeeId: params.employeeId,
        newStatus: params.newStatus,
      );
}

class ToggleEmployeeStatusParams extends Equatable {
  const ToggleEmployeeStatusParams({
    required this.employeeId,
    required this.newStatus,
  });

  final String employeeId;
  final bool newStatus;

  @override
  List<Object?> get props => [employeeId, newStatus];
}
