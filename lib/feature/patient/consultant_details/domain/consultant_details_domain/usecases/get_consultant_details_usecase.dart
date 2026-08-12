import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/consultant_details_entity.dart';
import '../repositories/consultant_details_repository.dart';

// ============================================================
// GET CONSULTANTDETAILS USE CASE
// ------------------------------------------------------------
// One job: fetch consultant details data.
// ============================================================

class GetConsultantDetailsUseCase extends UseCase<ConsultantDetailsEntity, NoParams> {
  final ConsultantDetailsRepository repository;

  GetConsultantDetailsUseCase(this.repository);

  @override
  ResultFuture<ConsultantDetailsEntity> call(NoParams params) {
    return repository.getConsultantDetails();
  }
}
