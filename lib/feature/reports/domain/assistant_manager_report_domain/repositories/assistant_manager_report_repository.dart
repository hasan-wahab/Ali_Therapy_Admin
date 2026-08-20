import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_query.dart';

// ============================================================
// ASSISTANT MANAGER REPORT REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class AssistantManagerReportRepository {
  ResultFuture<AssistantManagerReportPageEntity> getAssistantManagerReportPage({
    required AssistantManagerReportQuery query,
  });
}
