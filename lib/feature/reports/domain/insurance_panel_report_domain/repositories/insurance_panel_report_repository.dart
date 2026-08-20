import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_result_entity.dart';

// ============================================================
// INSURANCE PANEL REPORT REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class InsurancePanelReportRepository {
  ResultFuture<InsurancePanelReportResultEntity> getInsurancePanelReport({
    required InsurancePanelReportQuery query,
  });
}
