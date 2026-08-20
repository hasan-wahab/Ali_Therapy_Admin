import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';

// ============================================================
// REPORT FILTER OPTIONS REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class ReportFilterOptionsRepository {
  /// Fetch all filter dropdown lists for reports.
  ResultFuture<ReportFilterOptionsEntity> getFilterOptions();
}
