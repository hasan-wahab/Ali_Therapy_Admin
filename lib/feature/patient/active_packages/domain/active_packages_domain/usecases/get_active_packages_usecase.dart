import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/active_packages_entity.dart';
import '../repositories/active_packages_repository.dart';

// ============================================================
// GET ACTIVEPACKAGES USE CASE
// ------------------------------------------------------------
// One job: fetch active packages data.
// ============================================================

class GetActivePackagesUseCase extends UseCase<ActivePackagesEntity, NoParams> {
  final ActivePackagesRepository repository;

  GetActivePackagesUseCase(this.repository);

  @override
  ResultFuture<ActivePackagesEntity> call(NoParams params) {
    return repository.getActivePackages();
  }
}
