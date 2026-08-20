import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/entities/refer_by_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/entities/refer_by_report_query.dart';

// ============================================================
// REFER BY REPORT REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class ReferByReportRepository {
  ResultFuture<List<ReferByReportEntity>> getReferByReport({
    required ReferByReportQuery query,
  });
}
