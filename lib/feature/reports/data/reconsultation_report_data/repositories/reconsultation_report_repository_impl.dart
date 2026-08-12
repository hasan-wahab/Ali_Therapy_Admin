import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/reconsultation_report_domain/entities/reconsultation_report_entity.dart';
import '../../../domain/reconsultation_report_domain/repositories/reconsultation_report_repository.dart';

// ============================================================
// RECONSULTATIONREPORT REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class ReconsultationReportRepositoryImpl implements ReconsultationReportRepository {
  ReconsultationReportRepositoryImpl();

  @override
  ResultFuture<ReconsultationReportEntity> getReconsultationReport() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('ReconsultationReport API not integrated yet.'),
    );
  }
}
