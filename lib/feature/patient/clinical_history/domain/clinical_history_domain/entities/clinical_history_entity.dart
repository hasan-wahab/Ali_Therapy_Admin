import 'package:equatable/equatable.dart';

// ============================================================
// CLINICALHISTORY ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class ClinicalHistoryEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const ClinicalHistoryEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
