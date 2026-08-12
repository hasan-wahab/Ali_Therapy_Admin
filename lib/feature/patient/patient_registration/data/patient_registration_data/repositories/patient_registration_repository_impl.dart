import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/patient_registration_domain/entities/patient_registration_entity.dart';
import '../../../domain/patient_registration_domain/repositories/patient_registration_repository.dart';

// ============================================================
// PATIENTREGISTRATION REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class PatientRegistrationRepositoryImpl implements PatientRegistrationRepository {
  PatientRegistrationRepositoryImpl();

  @override
  ResultFuture<PatientRegistrationEntity> getPatientRegistration() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('PatientRegistration API not integrated yet.'),
    );
  }
}
