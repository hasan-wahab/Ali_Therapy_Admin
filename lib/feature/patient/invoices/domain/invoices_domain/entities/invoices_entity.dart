import 'package:equatable/equatable.dart';

// ============================================================
// INVOICES ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class InvoicesEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const InvoicesEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
