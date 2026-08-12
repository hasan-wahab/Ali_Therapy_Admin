import 'package:equatable/equatable.dart';

// ============================================================
// RECEPTIONISTREPORT ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class ReceptionistReportEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const ReceptionistReportEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
