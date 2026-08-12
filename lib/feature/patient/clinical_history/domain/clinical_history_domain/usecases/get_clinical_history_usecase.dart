import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/clinical_history_entity.dart';
import '../repositories/clinical_history_repository.dart';

// ============================================================
// GET CLINICALHISTORY USE CASE
// ------------------------------------------------------------
// One job: fetch clinical history data.
// ============================================================

class GetClinicalHistoryUseCase extends UseCase<ClinicalHistoryEntity, NoParams> {
  final ClinicalHistoryRepository repository;

  GetClinicalHistoryUseCase(this.repository);

  @override
  ResultFuture<ClinicalHistoryEntity> call(NoParams params) {
    return repository.getClinicalHistory();
  }
}
