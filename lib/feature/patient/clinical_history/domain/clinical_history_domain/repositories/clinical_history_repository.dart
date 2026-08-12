import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/clinical_history_entity.dart';

// ============================================================
// CLINICALHISTORY REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class ClinicalHistoryRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<ClinicalHistoryEntity> getClinicalHistory();
}
