import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/total_visits_domain/entities/total_visits_entity.dart';
import '../../../domain/total_visits_domain/repositories/total_visits_repository.dart';

// ============================================================
// TOTALVISITS REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class TotalVisitsRepositoryImpl implements TotalVisitsRepository {
  TotalVisitsRepositoryImpl();

  @override
  ResultFuture<TotalVisitsEntity> getTotalVisits() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('TotalVisits API not integrated yet.'),
    );
  }
}
