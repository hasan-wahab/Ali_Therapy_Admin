import 'package:equatable/equatable.dart';

// ============================================================
// TOTALVISITS ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class TotalVisitsEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const TotalVisitsEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
