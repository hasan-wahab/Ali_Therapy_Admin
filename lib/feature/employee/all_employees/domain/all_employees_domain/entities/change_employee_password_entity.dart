import 'package:equatable/equatable.dart';

// ============================================================
// CHANGE EMPLOYEE PASSWORD ENTITY (Domain)
// ------------------------------------------------------------
// Response from POST /employees/{id}/change-password
// ============================================================

class ChangeEmployeePasswordEntity extends Equatable {
  const ChangeEmployeePasswordEntity({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
