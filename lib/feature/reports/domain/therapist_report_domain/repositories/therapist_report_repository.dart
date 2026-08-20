import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/entities/therapist_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/entities/therapist_report_query.dart';

// ============================================================
// THERAPIST REPORT REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class TherapistReportRepository {
  ResultFuture<TherapistReportPageEntity> getTherapistReportPage({
    required TherapistReportQuery query,
  });
}
