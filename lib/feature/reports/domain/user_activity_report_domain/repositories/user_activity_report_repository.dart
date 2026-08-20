import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/entities/user_activity_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/entities/user_activity_report_query.dart';

// ============================================================
// USER ACTIVITY REPORT REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class UserActivityReportRepository {
  ResultFuture<UserActivityReportPageEntity> getUserActivityReportPage({
    required UserActivityReportQuery query,
  });
}
