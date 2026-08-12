import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/user_activity_report_entity.dart';
import '../repositories/user_activity_report_repository.dart';

// ============================================================
// GET USERACTIVITYREPORT USE CASE
// ------------------------------------------------------------
// One job: fetch user activity report data.
// ============================================================

class GetUserActivityReportUseCase extends UseCase<UserActivityReportEntity, NoParams> {
  final UserActivityReportRepository repository;

  GetUserActivityReportUseCase(this.repository);

  @override
  ResultFuture<UserActivityReportEntity> call(NoParams params) {
    return repository.getUserActivityReport();
  }
}
