import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/consultation_report_domain/entities/consultation_report_entity.dart';
import '../../../domain/consultation_report_domain/repositories/consultation_report_repository.dart';

// ============================================================
// CONSULTATIONREPORT REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class ConsultationReportRepositoryImpl implements ConsultationReportRepository {
  ConsultationReportRepositoryImpl();

  @override
  ResultFuture<ConsultationReportEntity> getConsultationReport() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('ConsultationReport API not integrated yet.'),
    );
  }
}
