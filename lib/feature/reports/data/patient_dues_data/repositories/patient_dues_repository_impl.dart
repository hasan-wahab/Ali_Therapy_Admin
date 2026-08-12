import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/patient_dues_domain/entities/patient_dues_entity.dart';
import '../../../domain/patient_dues_domain/repositories/patient_dues_repository.dart';

// ============================================================
// PATIENTDUES REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class PatientDuesRepositoryImpl implements PatientDuesRepository {
  PatientDuesRepositoryImpl();

  @override
  ResultFuture<PatientDuesEntity> getPatientDues() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('PatientDues API not integrated yet.'),
    );
  }
}
