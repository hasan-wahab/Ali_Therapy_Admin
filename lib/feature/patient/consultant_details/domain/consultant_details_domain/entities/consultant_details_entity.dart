import 'package:equatable/equatable.dart';

// ============================================================
// CONSULTANTDETAILS ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class ConsultantDetailsEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const ConsultantDetailsEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
