import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/free_consultation_report_domain/entities/free_consultation_report_entity.dart';
import '../../../domain/free_consultation_report_domain/repositories/free_consultation_report_repository.dart';

// ============================================================
// FREECONSULTATIONREPORT REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class FreeConsultationReportRepositoryImpl implements FreeConsultationReportRepository {
  FreeConsultationReportRepositoryImpl();

  @override
  ResultFuture<FreeConsultationReportEntity> getFreeConsultationReport() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('FreeConsultationReport API not integrated yet.'),
    );
  }
}
