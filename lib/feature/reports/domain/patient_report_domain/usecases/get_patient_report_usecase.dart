import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/patient_report_entity.dart';
import '../repositories/patient_report_repository.dart';

// ============================================================
// GET PATIENTREPORT USE CASE
// ------------------------------------------------------------
// One job: fetch patient report data.
// ============================================================

class GetPatientReportUseCase extends UseCase<PatientReportEntity, NoParams> {
  final PatientReportRepository repository;

  GetPatientReportUseCase(this.repository);

  @override
  ResultFuture<PatientReportEntity> call(NoParams params) {
    return repository.getPatientReport();
  }
}
