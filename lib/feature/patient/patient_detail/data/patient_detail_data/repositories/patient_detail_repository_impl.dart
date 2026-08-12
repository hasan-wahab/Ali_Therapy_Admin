import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/patient_detail_domain/entities/patient_detail_entity.dart';
import '../../../domain/patient_detail_domain/repositories/patient_detail_repository.dart';

// ============================================================
// PATIENTDETAIL REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class PatientDetailRepositoryImpl implements PatientDetailRepository {
  PatientDetailRepositoryImpl();

  @override
  ResultFuture<PatientDetailEntity> getPatientDetail() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('PatientDetail API not integrated yet.'),
    );
  }
}
