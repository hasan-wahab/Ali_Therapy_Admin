import 'package:equatable/equatable.dart';

// ============================================================
// FORGET PASSWORD ENTITY (Domain)
// ------------------------------------------------------------
// Result of a reset-request call (message from API, etc.).
// Fill fields when the real API contract is known.
// ============================================================

class ForgetPasswordEntity extends Equatable {
  /// Human-readable message from the server (e.g. "Email sent").
  final String message;

  const ForgetPasswordEntity({required this.message});

  @override
  List<Object?> get props => [message];
}
