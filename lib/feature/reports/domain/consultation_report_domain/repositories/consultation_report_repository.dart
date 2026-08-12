import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/consultation_report_entity.dart';

// ============================================================
// CONSULTATIONREPORT REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class ConsultationReportRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<ConsultationReportEntity> getConsultationReport();
}
