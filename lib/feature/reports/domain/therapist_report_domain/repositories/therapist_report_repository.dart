import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/therapist_report_entity.dart';

// ============================================================
// THERAPISTREPORT REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class TherapistReportRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<TherapistReportEntity> getTherapistReport();
}
