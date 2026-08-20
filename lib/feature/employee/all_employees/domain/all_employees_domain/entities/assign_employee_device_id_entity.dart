import 'package:equatable/equatable.dart';

// ============================================================
// ASSIGN EMPLOYEE DEVICE ID ENTITY (Domain)
// ------------------------------------------------------------
// Response from POST /employees/{id}/assign-device-id
// ============================================================

class AssignEmployeeDeviceIdEntity extends Equatable {
  const AssignEmployeeDeviceIdEntity({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
