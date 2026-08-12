import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/consultation_report_entity.dart';
import '../repositories/consultation_report_repository.dart';

// ============================================================
// GET CONSULTATIONREPORT USE CASE
// ------------------------------------------------------------
// One job: fetch consultation report data.
// ============================================================

class GetConsultationReportUseCase extends UseCase<ConsultationReportEntity, NoParams> {
  final ConsultationReportRepository repository;

  GetConsultationReportUseCase(this.repository);

  @override
  ResultFuture<ConsultationReportEntity> call(NoParams params) {
    return repository.getConsultationReport();
  }
}
