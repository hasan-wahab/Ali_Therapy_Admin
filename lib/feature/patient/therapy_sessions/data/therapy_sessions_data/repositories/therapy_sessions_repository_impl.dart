import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/therapy_sessions_domain/entities/therapy_sessions_entity.dart';
import '../../../domain/therapy_sessions_domain/repositories/therapy_sessions_repository.dart';

// ============================================================
// THERAPYSESSIONS REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class TherapySessionsRepositoryImpl implements TherapySessionsRepository {
  TherapySessionsRepositoryImpl();

  @override
  ResultFuture<TherapySessionsEntity> getTherapySessions() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('TherapySessions API not integrated yet.'),
    );
  }
}
