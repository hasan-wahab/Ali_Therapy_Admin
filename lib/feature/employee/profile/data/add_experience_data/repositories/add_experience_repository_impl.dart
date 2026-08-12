import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/add_experience_domain/entities/add_experience_entity.dart';
import '../../../domain/add_experience_domain/repositories/add_experience_repository.dart';

// ============================================================
// ADDEXPERIENCE REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class AddExperienceRepositoryImpl implements AddExperienceRepository {
  AddExperienceRepositoryImpl();

  @override
  ResultFuture<AddExperienceEntity> getAddExperience() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('AddExperience API not integrated yet.'),
    );
  }
}
