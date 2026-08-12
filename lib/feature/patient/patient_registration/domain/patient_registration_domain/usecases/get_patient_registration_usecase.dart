import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/patient_registration_entity.dart';
import '../repositories/patient_registration_repository.dart';

// ============================================================
// GET PATIENTREGISTRATION USE CASE
// ------------------------------------------------------------
// One job: fetch patient registration data.
// ============================================================

class GetPatientRegistrationUseCase extends UseCase<PatientRegistrationEntity, NoParams> {
  final PatientRegistrationRepository repository;

  GetPatientRegistrationUseCase(this.repository);

  @override
  ResultFuture<PatientRegistrationEntity> call(NoParams params) {
    return repository.getPatientRegistration();
  }
}
