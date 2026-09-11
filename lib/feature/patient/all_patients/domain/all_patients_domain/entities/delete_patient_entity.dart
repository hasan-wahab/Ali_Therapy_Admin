import 'package:equatable/equatable.dart';

// ============================================================
// DELETE PATIENT ENTITY (Domain)
// ------------------------------------------------------------
// Response from DELETE /patients/{id}
// ============================================================

class DeletePatientEntity extends Equatable {
  const DeletePatientEntity({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
