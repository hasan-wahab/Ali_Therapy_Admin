import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/clinical_history_domain/entities/clinical_history_entity.dart';
import '../../../domain/clinical_history_domain/repositories/clinical_history_repository.dart';

// ============================================================
// CLINICALHISTORY REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class ClinicalHistoryRepositoryImpl implements ClinicalHistoryRepository {
  ClinicalHistoryRepositoryImpl();

  @override
  ResultFuture<ClinicalHistoryEntity> getClinicalHistory() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('ClinicalHistory API not integrated yet.'),
    );
  }
}
