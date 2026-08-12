import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/therapy_sessions_entity.dart';

// ============================================================
// THERAPYSESSIONS REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class TherapySessionsRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<TherapySessionsEntity> getTherapySessions();
}
