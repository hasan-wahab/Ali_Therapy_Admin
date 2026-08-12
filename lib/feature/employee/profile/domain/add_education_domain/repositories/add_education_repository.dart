import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/add_education_entity.dart';

// ============================================================
// ADDEDUCATION REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class AddEducationRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<AddEducationEntity> getAddEducation();
}
