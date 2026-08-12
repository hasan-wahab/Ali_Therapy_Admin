import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/assistant_manager_report_entity.dart';

// ============================================================
// ASSISTANTMANAGERREPORT REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class AssistantManagerReportRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<AssistantManagerReportEntity> getAssistantManagerReport();
}
