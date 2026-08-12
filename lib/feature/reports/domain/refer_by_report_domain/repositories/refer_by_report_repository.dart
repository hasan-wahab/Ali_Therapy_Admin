import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/refer_by_report_entity.dart';

// ============================================================
// REFERBYREPORT REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class ReferByReportRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<ReferByReportEntity> getReferByReport();
}
