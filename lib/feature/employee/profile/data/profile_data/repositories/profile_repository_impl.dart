import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/profile_domain/entities/profile_entity.dart';
import '../../../domain/profile_domain/repositories/profile_repository.dart';

// ============================================================
// PROFILE REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl();

  @override
  ResultFuture<ProfileEntity> getProfile() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('Profile API not integrated yet.'),
    );
  }
}
