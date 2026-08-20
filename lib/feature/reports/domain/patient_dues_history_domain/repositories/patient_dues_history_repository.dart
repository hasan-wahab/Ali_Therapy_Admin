import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_history_domain/entities/patient_dues_history_entity.dart';

// ============================================================
// PATIENT DUES HISTORY REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class PatientDuesHistoryRepository {
  ResultFuture<List<PatientDuesHistoryEntity>> getPatientDuesHistory({
    required String patientId,
  });
}
