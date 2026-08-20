import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/entities/patient_dues_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/entities/patient_dues_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/repositories/patient_dues_repository.dart';

// ============================================================
// GET PATIENT DUES USE CASE (Domain)
// ------------------------------------------------------------
// One job: fetch one page of patient dues.
// ============================================================

class GetPatientDuesUseCase
    extends UseCase<PatientDuesPageEntity, PatientDuesQuery> {
  GetPatientDuesUseCase(this.repository);

  final PatientDuesRepository repository;

  @override
  ResultFuture<PatientDuesPageEntity> call(PatientDuesQuery params) =>
      repository.getPatientDuesPage(query: params);
}
