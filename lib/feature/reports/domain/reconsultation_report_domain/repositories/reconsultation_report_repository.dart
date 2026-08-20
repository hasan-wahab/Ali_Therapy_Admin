import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/entities/reconsultation_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/entities/reconsultation_report_query.dart';

// ============================================================
// RECONSULTATION REPORT REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class ReconsultationReportRepository {
  ResultFuture<ReconsultationReportPageEntity> getReconsultationReportPage({
    required ReconsultationReportQuery query,
  });
}
