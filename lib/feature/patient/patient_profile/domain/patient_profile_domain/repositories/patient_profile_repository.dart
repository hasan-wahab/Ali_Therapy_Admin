import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/patient_profile_entity.dart';

// ============================================================
// PATIENTPROFILE REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class PatientProfileRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<PatientProfileEntity> getPatientProfile();
}
