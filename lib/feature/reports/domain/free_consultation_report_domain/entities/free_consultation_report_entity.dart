import 'package:equatable/equatable.dart';

// ============================================================
// FREECONSULTATIONREPORT ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class FreeConsultationReportEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const FreeConsultationReportEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
