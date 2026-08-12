import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/add_education_entity.dart';
import '../repositories/add_education_repository.dart';

// ============================================================
// GET ADDEDUCATION USE CASE
// ------------------------------------------------------------
// One job: fetch add education data.
// ============================================================

class GetAddEducationUseCase extends UseCase<AddEducationEntity, NoParams> {
  final AddEducationRepository repository;

  GetAddEducationUseCase(this.repository);

  @override
  ResultFuture<AddEducationEntity> call(NoParams params) {
    return repository.getAddEducation();
  }
}
