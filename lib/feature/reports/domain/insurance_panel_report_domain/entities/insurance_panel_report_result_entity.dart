import 'package:equatable/equatable.dart';

import 'insurance_panel_report_entity.dart';
import 'insurance_panel_report_summary_entity.dart';

// ============================================================
// INSURANCE PANEL REPORT RESULT ENTITY (Domain)
// ------------------------------------------------------------
// Full response: summary totals + panel rows.
// ============================================================

class InsurancePanelReportResultEntity extends Equatable {
  const InsurancePanelReportResultEntity({
    required this.summary,
    required this.panels,
  });

  final InsurancePanelReportSummaryEntity summary;
  final List<InsurancePanelReportEntity> panels;

  @override
  List<Object?> get props => [summary, panels];
}
