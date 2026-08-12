import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/patient_dues_entity.dart';
import '../repositories/patient_dues_repository.dart';

// ============================================================
// GET PATIENTDUES USE CASE
// ------------------------------------------------------------
// One job: fetch patient dues data.
// ============================================================

class GetPatientDuesUseCase extends UseCase<PatientDuesEntity, NoParams> {
  final PatientDuesRepository repository;

  GetPatientDuesUseCase(this.repository);

  @override
  ResultFuture<PatientDuesEntity> call(NoParams params) {
    return repository.getPatientDues();
  }
}
