import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/repositories/in_progress_sessions_repository.dart';

// ============================================================
// GET IN-PROGRESS SESSIONS USE CASE
// ------------------------------------------------------------
// One job: fetch paginated in-progress session rows.
// ============================================================

class GetInProgressSessionsUseCase
    extends UseCase<InProgressSessionsPageEntity, InProgressSessionsQuery> {
  GetInProgressSessionsUseCase(this.repository);

  final InProgressSessionsRepository repository;

  @override
  ResultFuture<InProgressSessionsPageEntity> call(
    InProgressSessionsQuery params,
  ) {
    return repository.getInProgressSessionsPage(query: params);
  }
}
