import 'package:equatable/equatable.dart';

// ============================================================
// ASSISTANTMANAGERREPORT ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class AssistantManagerReportEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const AssistantManagerReportEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
