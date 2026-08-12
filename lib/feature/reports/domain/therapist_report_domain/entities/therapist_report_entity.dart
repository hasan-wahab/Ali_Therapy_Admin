import 'package:equatable/equatable.dart';

// ============================================================
// THERAPISTREPORT ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class TherapistReportEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const TherapistReportEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
