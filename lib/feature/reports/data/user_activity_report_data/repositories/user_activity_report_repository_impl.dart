import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/user_activity_report_domain/entities/user_activity_report_entity.dart';
import '../../../domain/user_activity_report_domain/repositories/user_activity_report_repository.dart';

// ============================================================
// USERACTIVITYREPORT REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class UserActivityReportRepositoryImpl implements UserActivityReportRepository {
  UserActivityReportRepositoryImpl();

  @override
  ResultFuture<UserActivityReportEntity> getUserActivityReport() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('UserActivityReport API not integrated yet.'),
    );
  }
}
