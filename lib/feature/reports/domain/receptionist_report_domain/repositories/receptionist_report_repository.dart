import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/entities/receptionist_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/entities/receptionist_report_query.dart';

// ============================================================
// RECEPTIONIST REPORT REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class ReceptionistReportRepository {
  ResultFuture<ReceptionistReportPageEntity> getReceptionistReportPage({
    required ReceptionistReportQuery query,
  });
}
