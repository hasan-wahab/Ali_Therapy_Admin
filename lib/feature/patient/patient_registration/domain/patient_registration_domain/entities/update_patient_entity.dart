import 'package:equatable/equatable.dart';

// ============================================================
// UPDATE PATIENT ENTITY (Domain)
// ------------------------------------------------------------
// Response from POST /patients/{id}/update
// ============================================================

class UpdatePatientEntity extends Equatable {
  const UpdatePatientEntity({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
