import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/entities/user_activity_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/entities/user_activity_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/repositories/user_activity_report_repository.dart';

// ============================================================
// GET USER ACTIVITY REPORT USE CASE
// ------------------------------------------------------------
// One job: fetch paginated user activity rows.
// ============================================================

class GetUserActivityReportUseCase
    extends UseCase<UserActivityReportPageEntity, UserActivityReportQuery> {
  GetUserActivityReportUseCase(this.repository);

  final UserActivityReportRepository repository;

  @override
  ResultFuture<UserActivityReportPageEntity> call(
    UserActivityReportQuery params,
  ) {
    return repository.getUserActivityReportPage(query: params);
  }
}
