import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/add_experience_entity.dart';
import '../repositories/add_experience_repository.dart';

// ============================================================
// GET ADDEXPERIENCE USE CASE
// ------------------------------------------------------------
// One job: fetch add experience data.
// ============================================================

class GetAddExperienceUseCase extends UseCase<AddExperienceEntity, NoParams> {
  final AddExperienceRepository repository;

  GetAddExperienceUseCase(this.repository);

  @override
  ResultFuture<AddExperienceEntity> call(NoParams params) {
    return repository.getAddExperience();
  }
}
