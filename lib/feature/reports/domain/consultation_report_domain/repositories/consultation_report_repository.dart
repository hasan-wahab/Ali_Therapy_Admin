import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/entities/consultation_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/entities/consultation_report_query.dart';

// ============================================================
// CONSULTATION REPORT REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class ConsultationReportRepository {
  ResultFuture<ConsultationReportPageEntity> getConsultationReportPage({
    required ConsultationReportQuery query,
  });
}
