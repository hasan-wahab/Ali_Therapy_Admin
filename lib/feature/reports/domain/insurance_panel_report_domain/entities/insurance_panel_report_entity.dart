import 'package:equatable/equatable.dart';

// ============================================================
// INSURANCEPANELREPORT ENTITY (Domain)
// ------------------------------------------------------------
// Pure business object — no Flutter / Dio / JSON here.
// Fill fields when the API contract is known.
// ============================================================

class InsurancePanelReportEntity extends Equatable {
  /// Placeholder id until real fields are defined.
  final String id;

  const InsurancePanelReportEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
