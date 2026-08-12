import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/active_packages_domain/entities/active_packages_entity.dart';
import '../../../domain/active_packages_domain/repositories/active_packages_repository.dart';

// ============================================================
// ACTIVEPACKAGES REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class ActivePackagesRepositoryImpl implements ActivePackagesRepository {
  ActivePackagesRepositoryImpl();

  @override
  ResultFuture<ActivePackagesEntity> getActivePackages() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('ActivePackages API not integrated yet.'),
    );
  }
}
