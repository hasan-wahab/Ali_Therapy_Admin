import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/refer_by_report_domain/entities/refer_by_report_entity.dart';
import '../../../domain/refer_by_report_domain/repositories/refer_by_report_repository.dart';

// ============================================================
// REFERBYREPORT REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class ReferByReportRepositoryImpl implements ReferByReportRepository {
  ReferByReportRepositoryImpl();

  @override
  ResultFuture<ReferByReportEntity> getReferByReport() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('ReferByReport API not integrated yet.'),
    );
  }
}
