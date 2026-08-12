import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/patient_profile_domain/entities/patient_profile_entity.dart';
import '../../../domain/patient_profile_domain/repositories/patient_profile_repository.dart';

// ============================================================
// PATIENTPROFILE REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class PatientProfileRepositoryImpl implements PatientProfileRepository {
  PatientProfileRepositoryImpl();

  @override
  ResultFuture<PatientProfileEntity> getPatientProfile() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('PatientProfile API not integrated yet.'),
    );
  }
}
