import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_query.dart';

// ============================================================
// IN-PROGRESS SESSIONS REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class InProgressSessionsRepository {
  ResultFuture<InProgressSessionsPageEntity> getInProgressSessionsPage({
    required InProgressSessionsQuery query,
  });
}
