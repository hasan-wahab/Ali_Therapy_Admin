import 'package:equatable/equatable.dart';

// ============================================================
// ASSIGN EMPLOYEE BIOMETRIC ID ENTITY (Domain)
// ------------------------------------------------------------
// Response from POST /employees/{id}/assign-biometric-id
// ============================================================

class AssignEmployeeBiometricIdEntity extends Equatable {
  const AssignEmployeeBiometricIdEntity({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
