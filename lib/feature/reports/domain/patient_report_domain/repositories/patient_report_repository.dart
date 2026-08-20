import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/entities/patient_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/entities/patient_report_query.dart';

// ============================================================
// PATIENT REPORT REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class PatientReportRepository {
  ResultFuture<PatientReportPageEntity> getPatientReportPage({
    required PatientReportQuery query,
  });
}
