import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/free_consultation_report_domain/entities/free_consultation_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/free_consultation_report_domain/entities/free_consultation_report_query.dart';

// ============================================================
// FREE CONSULTATION REPORT REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class FreeConsultationReportRepository {
  ResultFuture<FreeConsultationReportPageEntity> getFreeConsultationReportPage({
    required FreeConsultationReportQuery query,
  });
}
