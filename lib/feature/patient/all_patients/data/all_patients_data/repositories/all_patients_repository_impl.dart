import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/all_patients_domain/entities/all_patients_entity.dart';
import '../../../domain/all_patients_domain/repositories/all_patients_repository.dart';

// ============================================================
// ALLPATIENTS REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class AllPatientsRepositoryImpl implements AllPatientsRepository {
  AllPatientsRepositoryImpl();

  @override
  ResultFuture<AllPatientsEntity> getAllPatients() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('AllPatients API not integrated yet.'),
    );
  }
}
