import 'package:equatable/equatable.dart';

// ============================================================
// THERAPYSESSIONS ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class TherapySessionsEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const TherapySessionsEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
