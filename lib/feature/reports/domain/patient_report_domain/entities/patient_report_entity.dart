import 'package:equatable/equatable.dart';

// ============================================================
// PATIENTREPORT ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class PatientReportEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const PatientReportEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
