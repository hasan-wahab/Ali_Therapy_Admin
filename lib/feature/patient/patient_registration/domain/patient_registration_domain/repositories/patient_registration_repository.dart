import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/patient_registration_entity.dart';

// ============================================================
// PATIENTREGISTRATION REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class PatientRegistrationRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<PatientRegistrationEntity> getPatientRegistration();
}
