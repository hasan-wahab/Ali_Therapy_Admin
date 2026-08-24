import 'package:equatable/equatable.dart';

// ============================================================
// UPDATE EMPLOYEE ENTITY (Domain)
// ------------------------------------------------------------
// Response from POST /employees/update/{id}
// ============================================================

class UpdateEmployeeEntity extends Equatable {
  const UpdateEmployeeEntity({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
