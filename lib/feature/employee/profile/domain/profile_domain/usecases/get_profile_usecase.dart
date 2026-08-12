import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

// ============================================================
// GET PROFILE USE CASE
// ------------------------------------------------------------
// One job: fetch profile data.
// ============================================================

class GetProfileUseCase extends UseCase<ProfileEntity, NoParams> {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  @override
  ResultFuture<ProfileEntity> call(NoParams params) {
    return repository.getProfile();
  }
}
