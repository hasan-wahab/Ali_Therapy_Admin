import 'package:equatable/equatable.dart';

// ============================================================
// PATIENTDETAIL ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class PatientDetailEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const PatientDetailEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
