import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/patient_profile_entity.dart';
import '../repositories/patient_profile_repository.dart';

// ============================================================
// GET PATIENTPROFILE USE CASE
// ------------------------------------------------------------
// One job: fetch patient profile data.
// ============================================================

class GetPatientProfileUseCase extends UseCase<PatientProfileEntity, NoParams> {
  final PatientProfileRepository repository;

  GetPatientProfileUseCase(this.repository);

  @override
  ResultFuture<PatientProfileEntity> call(NoParams params) {
    return repository.getPatientProfile();
  }
}
