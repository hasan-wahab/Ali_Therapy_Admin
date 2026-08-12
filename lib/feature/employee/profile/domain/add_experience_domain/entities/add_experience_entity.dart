import 'package:equatable/equatable.dart';

// ============================================================
// ADDEXPERIENCE ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class AddExperienceEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const AddExperienceEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
