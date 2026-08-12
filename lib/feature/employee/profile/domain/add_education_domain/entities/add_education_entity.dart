import 'package:equatable/equatable.dart';

// ============================================================
// ADDEDUCATION ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class AddEducationEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const AddEducationEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
