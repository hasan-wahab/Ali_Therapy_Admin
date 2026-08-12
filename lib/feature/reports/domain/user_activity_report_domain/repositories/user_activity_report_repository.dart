import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/user_activity_report_entity.dart';

// ============================================================
// USERACTIVITYREPORT REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class UserActivityReportRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<UserActivityReportEntity> getUserActivityReport();
}
