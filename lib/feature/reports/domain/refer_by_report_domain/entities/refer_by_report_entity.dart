import 'package:equatable/equatable.dart';

// ============================================================
// REFERBYREPORT ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class ReferByReportEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const ReferByReportEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
