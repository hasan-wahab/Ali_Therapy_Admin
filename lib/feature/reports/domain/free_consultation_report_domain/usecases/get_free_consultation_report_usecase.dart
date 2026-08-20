import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/free_consultation_report_domain/entities/free_consultation_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/free_consultation_report_domain/entities/free_consultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/free_consultation_report_domain/repositories/free_consultation_report_repository.dart';

// ============================================================
// GET FREE CONSULTATION REPORT USE CASE
// ------------------------------------------------------------
// One job: fetch paginated free consultation report rows.
// ============================================================

class GetFreeConsultationReportUseCase extends UseCase<
    FreeConsultationReportPageEntity, FreeConsultationReportQuery> {
  GetFreeConsultationReportUseCase(this.repository);

  final FreeConsultationReportRepository repository;

  @override
  ResultFuture<FreeConsultationReportPageEntity> call(
    FreeConsultationReportQuery params,
  ) {
    return repository.getFreeConsultationReportPage(query: params);
  }
}
