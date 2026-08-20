import 'package:equatable/equatable.dart';

// ============================================================
// TERMINATE EMPLOYEE ENTITY (Domain)
// ------------------------------------------------------------
// Response from POST /employees/{id}/terminate
// ============================================================

class TerminateEmployeeEntity extends Equatable {
  const TerminateEmployeeEntity({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
