import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/reconsultation_report_entity.dart';

// ============================================================
// RECONSULTATIONREPORT REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class ReconsultationReportRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<ReconsultationReportEntity> getReconsultationReport();
}
