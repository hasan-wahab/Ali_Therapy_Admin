import 'package:equatable/equatable.dart';

// ============================================================
// ALLPATIENTS ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class AllPatientsEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const AllPatientsEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
