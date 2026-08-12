import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/add_experience_entity.dart';

// ============================================================
// ADDEXPERIENCE REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class AddExperienceRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<AddExperienceEntity> getAddExperience();
}
