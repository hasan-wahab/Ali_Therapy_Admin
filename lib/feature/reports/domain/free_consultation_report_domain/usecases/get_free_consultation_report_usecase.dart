import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/free_consultation_report_entity.dart';
import '../repositories/free_consultation_report_repository.dart';

// ============================================================
// GET FREECONSULTATIONREPORT USE CASE
// ------------------------------------------------------------
// One job: fetch free consultation report data.
// ============================================================

class GetFreeConsultationReportUseCase extends UseCase<FreeConsultationReportEntity, NoParams> {
  final FreeConsultationReportRepository repository;

  GetFreeConsultationReportUseCase(this.repository);

  @override
  ResultFuture<FreeConsultationReportEntity> call(NoParams params) {
    return repository.getFreeConsultationReport();
  }
}
