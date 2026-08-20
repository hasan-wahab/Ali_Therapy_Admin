import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/assign_employee_device_id_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/repositories/all_employees_repository.dart';
import 'package:equatable/equatable.dart';

// ============================================================
// ASSIGN EMPLOYEE DEVICE ID USE CASE (Domain)
// ------------------------------------------------------------
// One job: POST /employees/{id}/assign-device-id
// ============================================================

class AssignEmployeeDeviceIdUseCase
    extends
        UseCase<AssignEmployeeDeviceIdEntity, AssignEmployeeDeviceIdParams> {
  AssignEmployeeDeviceIdUseCase(this.repository);

  final AllEmployeesRepository repository;

  @override
  ResultFuture<AssignEmployeeDeviceIdEntity> call(
    AssignEmployeeDeviceIdParams params,
  ) =>
      repository.assignEmployeeDeviceId(
        employeeId: params.employeeId,
        deviceId: params.deviceId,
      );
}

class AssignEmployeeDeviceIdParams extends Equatable {
  const AssignEmployeeDeviceIdParams({
    required this.employeeId,
    required this.deviceId,
  });

  final String employeeId;
  final int deviceId;

  @override
  List<Object?> get props => [employeeId, deviceId];
}
