import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/entities/reconsultation_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/entities/reconsultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/repositories/reconsultation_report_repository.dart';

// ============================================================
// GET RECONSULTATION REPORT USE CASE
// ------------------------------------------------------------
// One job: fetch paginated reconsultation report rows.
// ============================================================

class GetReconsultationReportUseCase extends UseCase<
    ReconsultationReportPageEntity, ReconsultationReportQuery> {
  GetReconsultationReportUseCase(this.repository);

  final ReconsultationReportRepository repository;

  @override
  ResultFuture<ReconsultationReportPageEntity> call(
    ReconsultationReportQuery params,
  ) {
    return repository.getReconsultationReportPage(query: params);
  }
}
