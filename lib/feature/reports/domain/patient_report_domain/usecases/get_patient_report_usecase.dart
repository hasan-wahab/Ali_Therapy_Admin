import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/entities/patient_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/entities/patient_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/repositories/patient_report_repository.dart';

// ============================================================
// GET PATIENT REPORT USE CASE
// ------------------------------------------------------------
// One job: fetch paginated patient report rows.
// ============================================================

class GetPatientReportUseCase
    extends UseCase<PatientReportPageEntity, PatientReportQuery> {
  GetPatientReportUseCase(this.repository);

  final PatientReportRepository repository;

  @override
  ResultFuture<PatientReportPageEntity> call(PatientReportQuery params) {
    return repository.getPatientReportPage(query: params);
  }
}
