import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/assistant_manager_report_entity.dart';
import '../repositories/assistant_manager_report_repository.dart';

// ============================================================
// GET ASSISTANTMANAGERREPORT USE CASE
// ------------------------------------------------------------
// One job: fetch assistant manager report data.
// ============================================================

class GetAssistantManagerReportUseCase extends UseCase<AssistantManagerReportEntity, NoParams> {
  final AssistantManagerReportRepository repository;

  GetAssistantManagerReportUseCase(this.repository);

  @override
  ResultFuture<AssistantManagerReportEntity> call(NoParams params) {
    return repository.getAssistantManagerReport();
  }
}
