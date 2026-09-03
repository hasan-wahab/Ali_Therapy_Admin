import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/patient_detail_entity.dart';

// ============================================================
// PATIENT DETAIL REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class PatientDetailRepository {
  /// GET patient/{id}/full-view
  ResultFuture<PatientDetailEntity> getPatientDetail({
    required String patientId,
  });
}
