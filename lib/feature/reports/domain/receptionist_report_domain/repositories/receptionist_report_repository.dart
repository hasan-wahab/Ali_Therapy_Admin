import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/receptionist_report_entity.dart';

// ============================================================
// RECEPTIONISTREPORT REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class ReceptionistReportRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<ReceptionistReportEntity> getReceptionistReport();
}
