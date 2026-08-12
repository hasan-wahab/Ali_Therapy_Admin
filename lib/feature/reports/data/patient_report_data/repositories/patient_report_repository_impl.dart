import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/patient_report_domain/entities/patient_report_entity.dart';
import '../../../domain/patient_report_domain/repositories/patient_report_repository.dart';

// ============================================================
// PATIENTREPORT REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class PatientReportRepositoryImpl implements PatientReportRepository {
  PatientReportRepositoryImpl();

  @override
  ResultFuture<PatientReportEntity> getPatientReport() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('PatientReport API not integrated yet.'),
    );
  }
}
