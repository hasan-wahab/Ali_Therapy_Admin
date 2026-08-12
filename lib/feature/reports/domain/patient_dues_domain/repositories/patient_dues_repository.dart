import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/patient_dues_entity.dart';

// ============================================================
// PATIENTDUES REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class PatientDuesRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<PatientDuesEntity> getPatientDues();
}
