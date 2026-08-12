import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/add_education_domain/entities/add_education_entity.dart';
import '../../../domain/add_education_domain/repositories/add_education_repository.dart';

// ============================================================
// ADDEDUCATION REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class AddEducationRepositoryImpl implements AddEducationRepository {
  AddEducationRepositoryImpl();

  @override
  ResultFuture<AddEducationEntity> getAddEducation() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('AddEducation API not integrated yet.'),
    );
  }
}
