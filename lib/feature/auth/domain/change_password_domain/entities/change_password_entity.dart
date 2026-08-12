import 'package:equatable/equatable.dart';

// ============================================================
// CHANGE PASSWORD ENTITY (Domain)
// ------------------------------------------------------------
// Result after a successful password change.
// ============================================================

class ChangePasswordEntity extends Equatable {
  final String message;

  const ChangePasswordEntity({required this.message});

  @override
  List<Object?> get props => [message];
}
