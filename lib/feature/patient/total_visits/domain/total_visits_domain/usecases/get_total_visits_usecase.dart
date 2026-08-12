import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/total_visits_entity.dart';
import '../repositories/total_visits_repository.dart';

// ============================================================
// GET TOTALVISITS USE CASE
// ------------------------------------------------------------
// One job: fetch total visits data.
// ============================================================

class GetTotalVisitsUseCase extends UseCase<TotalVisitsEntity, NoParams> {
  final TotalVisitsRepository repository;

  GetTotalVisitsUseCase(this.repository);

  @override
  ResultFuture<TotalVisitsEntity> call(NoParams params) {
    return repository.getTotalVisits();
  }
}
