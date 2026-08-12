import 'package:equatable/equatable.dart';

// ============================================================
// PROFILE ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class ProfileEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const ProfileEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
