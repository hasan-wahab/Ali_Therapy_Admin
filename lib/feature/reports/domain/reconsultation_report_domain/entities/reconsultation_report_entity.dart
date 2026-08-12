import 'package:equatable/equatable.dart';

// ============================================================
// RECONSULTATIONREPORT ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class ReconsultationReportEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const ReconsultationReportEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
