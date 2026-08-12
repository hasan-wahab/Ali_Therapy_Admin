import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/patient_report_entity.dart';

// ============================================================
// PATIENTREPORT REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class PatientReportRepository {
  /// Load data for this feature. Replace with real methods later.
  ResultFuture<PatientReportEntity> getPatientReport();
}
