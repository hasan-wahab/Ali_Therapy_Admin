import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/patient_detail_entity.dart';

// ============================================================
// PATIENTDETAIL REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class PatientDetailRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<PatientDetailEntity> getPatientDetail();
}
