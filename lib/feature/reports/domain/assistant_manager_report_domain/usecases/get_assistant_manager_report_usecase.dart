import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/repositories/assistant_manager_report_repository.dart';

// ============================================================
// GET ASSISTANT MANAGER REPORT USE CASE
// ------------------------------------------------------------
// One job: fetch paginated assistant manager report rows.
// ============================================================

class GetAssistantManagerReportUseCase extends UseCase<
    AssistantManagerReportPageEntity, AssistantManagerReportQuery> {
  GetAssistantManagerReportUseCase(this.repository);

  final AssistantManagerReportRepository repository;

  @override
  ResultFuture<AssistantManagerReportPageEntity> call(
    AssistantManagerReportQuery params,
  ) {
    return repository.getAssistantManagerReportPage(query: params);
  }
}
