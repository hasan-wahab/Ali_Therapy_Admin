import 'package:equatable/equatable.dart';

// ============================================================
// DELETE EMPLOYEE ENTITY (Domain)
// ------------------------------------------------------------
// Response from DELETE /employees/{id}
// ============================================================

class DeleteEmployeeEntity extends Equatable {
  const DeleteEmployeeEntity({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
