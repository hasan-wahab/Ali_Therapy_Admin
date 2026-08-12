import 'package:equatable/equatable.dart';

// ============================================================
// ADDDOCUMENT ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class AddDocumentEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const AddDocumentEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
