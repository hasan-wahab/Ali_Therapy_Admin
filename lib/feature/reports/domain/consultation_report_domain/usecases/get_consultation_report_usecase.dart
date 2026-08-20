import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/entities/consultation_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/entities/consultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/repositories/consultation_report_repository.dart';

// ============================================================
// GET CONSULTATION REPORT USE CASE
// ------------------------------------------------------------
// One job: fetch paginated consultant report rows.
// ============================================================

class GetConsultationReportUseCase
    extends UseCase<ConsultationReportPageEntity, ConsultationReportQuery> {
  GetConsultationReportUseCase(this.repository);

  final ConsultationReportRepository repository;

  @override
  ResultFuture<ConsultationReportPageEntity> call(ConsultationReportQuery params) {
    return repository.getConsultationReportPage(query: params);
  }
}
