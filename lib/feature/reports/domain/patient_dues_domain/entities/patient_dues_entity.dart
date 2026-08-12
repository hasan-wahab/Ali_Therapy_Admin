import 'package:equatable/equatable.dart';

// ============================================================
// PATIENTDUES ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class PatientDuesEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const PatientDuesEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
