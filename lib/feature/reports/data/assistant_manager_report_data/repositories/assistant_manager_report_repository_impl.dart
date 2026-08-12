import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/assistant_manager_report_domain/entities/assistant_manager_report_entity.dart';
import '../../../domain/assistant_manager_report_domain/repositories/assistant_manager_report_repository.dart';

// ============================================================
// ASSISTANTMANAGERREPORT REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class AssistantManagerReportRepositoryImpl implements AssistantManagerReportRepository {
  AssistantManagerReportRepositoryImpl();

  @override
  ResultFuture<AssistantManagerReportEntity> getAssistantManagerReport() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('AssistantManagerReport API not integrated yet.'),
    );
  }
}
