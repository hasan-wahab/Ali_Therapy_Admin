import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/total_visits_entity.dart';

// ============================================================
// TOTALVISITS REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class TotalVisitsRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<TotalVisitsEntity> getTotalVisits();
}
