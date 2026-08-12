import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/insurance_panel_report_entity.dart';

// ============================================================
// INSURANCEPANELREPORT REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class InsurancePanelReportRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<InsurancePanelReportEntity> getInsurancePanelReport();
}
